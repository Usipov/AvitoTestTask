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
@property (strong, atomic) NSOperation *loadOperation;
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
    
    WSELF;
    @autoreleasepool {
        self.loadOperation = [[CNDownloader new] dowloadDataFromURL:self.request.url
                                                         completion:^(NSData *data) {
                                                             [wself processImageData:data];
                                                         } error:NULL];
    }
}

-(void)processImageData:(NSData *)data {
    if (! data)
        return;
    
    if (self.cancelled)
        return;
    
    // можно еще добавить удаление устаревших картинок, но не в этот раз
    UIImage *image = [UIImage imageWithData:data];
    if (! [image isKindOfClass:[UIImage self]])
        return;
    
    NSString *imagePath = [self.request pathToStoreImage];
    if (self.cancelled)
        return;
    
    [data writeToFile:imagePath atomically:YES];
    
    doOnMain(^{
        if (! self.cancelled) {
            self.block(image);
        }
    });
}

- (void)cancel {
    [super cancel];
    
    [self.loadOperation cancel];
    self.loadOperation = nil;
}

@end

