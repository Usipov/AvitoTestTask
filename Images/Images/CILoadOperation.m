//
//  CILoadOperation.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CILoadOperation.h"
#import "CNDownloader.h"

@interface CILoadOperation ()
@property (strong, nonatomic) CIImageRequest *request;
@property (copy, nonatomic) IdBlock block;
@property (strong, nonatomic) NSOperation *loadOperation;
@property (strong, nonatomic) NSPort *port;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (strong, nonatomic) NSThread *thread;
@property (assign, nonatomic) BOOL isCompleted;
@property (assign, nonatomic) BOOL needsStop;
@end

#pragma mark -

@implementation CILoadOperation

- (instancetype)initWithRequest:(CIImageRequest *)request completion:(IdBlock)block {
    self = [super init];
    if (self) {
        self.request = request;
        self.block = block;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (void)main {
    if (self.cancelled)
        return;
    
    self.runLoop = [NSRunLoop currentRunLoop];
    self.port = [NSMachPort port];
    self.thread = [NSThread currentThread];
    [self.runLoop addPort: self.port forMode: NSDefaultRunLoopMode];
    
    WSELF;
    self.loadOperation = [[CNDownloader new] downloadImageFromURL:self.request.url
                                                       completion:^(id image) {
                                                           [wself processImage:image];
                                                       } error:^(NSError *error) {
                                                           DLog(@"%@", error);
                                                           [wself commitImage:nil];
                                                       }];

    // будем прокручивать ран луп, чтобы не дать выйти из функции main и не быть деаллоцированными
    NSTimeInterval stepLength = 0.1;
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow:stepLength];
    while (! self.needsStop && [self.runLoop runMode:NSDefaultRunLoopMode beforeDate:future]) {
        future = [future dateByAddingTimeInterval:stepLength];
    }
    
    self.isCompleted = YES;
    [self internalComplete];
}

- (void)cancel {
    [super cancel];
    [self setNeedsStopOnPrivateThread];
}

#pragma mark - privates

- (void)setNeedsStopOnPrivateThread {
    // если есть текущий поток, значит метод main уже вызывали. если потока нет, значит отмену операции вызвали из главного потока до того, как сработал main
    if (! self.thread || [NSThread currentThread] == self.thread) {
        [self internalComplete];
    } else {
        [self performSelector:@selector(internalComplete) onThread:self.thread withObject:nil waitUntilDone:NO];
    }
}

- (void)internalComplete {
    [self cleanUp];
    self.needsStop = YES;
}

- (void)cleanUp {
    self.block = nil;
    
    [self.loadOperation cancel];
    self.loadOperation = nil;
    
    [self.runLoop removePort: self.port forMode: NSDefaultRunLoopMode];
    self.port = nil;
}

- (void)processImage:(id)imageObject {
    if (! [imageObject isKindOfClass:[UIImage self]]) {
        [self commitImage:nil];
        return;
    }
    
    // можно еще добавить удаление устаревших картинок, но не в этот раз
    UIImage *image = imageObject;
    
    NSString *imagePath = [self.request pathToStoreImage];
    if (self.cancelled)
        return;
    
    // создаем папку
    NSString *folderPath = [imagePath stringByDeletingLastPathComponent];
    [[NSFileManager new] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    // кэшируем на диск
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    // отправляем в UI
    [self commitImage:image];
}

- (void)commitImage:(id)image {
    // сохраняю блок, чтобы он не обнулился в этом потоке за то время, пока управление будет переходить в главный поток
    IdBlock block = self.block;
    NSParameterAssert(block);
    
    WSELF;
    doOnMain(^{
        if (! wself.cancelled) {
            block(image);
        }
    });
    [self setNeedsStopOnPrivateThread];
}

@end

