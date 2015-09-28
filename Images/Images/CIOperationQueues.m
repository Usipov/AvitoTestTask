//
//  CIOperationQueues.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIOperationQueues.h"
#import "CIFetchOperation.h"
#import "CILoadOperation.h"

@interface CIOperationQueues ()
@property (strong, nonatomic) NSOperationQueue *fetchQueue;
@property (strong, nonatomic) NSOperationQueue *loadQueue;
@property (assign, nonatomic) NSUInteger fetchesCount;
@property (assign, nonatomic) NSUInteger loadingsCount;
@end

#pragma mark -

@implementation CIOperationQueues

- (instancetype)initWithConcurrentFetchesCount:(NSUInteger)fetchesCount loadingsCount:(NSUInteger)loadingsCount {
    self = [super init];
    if (self) {
        self.fetchesCount = fetchesCount;
        self.loadingsCount = loadingsCount;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cancelAllOperations)
                                                     name:UIApplicationWillTerminateNotification
                                                   object: nil];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (void)fetchOrLoadImageForRequest:(CIImageRequest *)request completion:(IdBlock)block {
    if (! request)
        return;
    if (! block)
        return;
    
    WSELF;
    CIFetchOperation *fetchOperation = [[CIFetchOperation alloc] initWithRequest:request completion:^(id obj) {
        // если Null, то будем грузить по интернету
        if ([obj isKindOfClass:[NSNull self]]) {
            CILoadOperation *loadOperation = [[CILoadOperation alloc] initWithRequest:request completion:block];
            [wself.loadQueue addOperation:loadOperation];
        }
        else {
            block(obj);
        }
    }];
    [self.fetchQueue addOperation:fetchOperation];
}

- (void)cancelOperationForRequest:(CIImageRequest *)request {
    if (! request)
        return;
    
    [[self.fetchQueue.operations bk_match:^BOOL(CIFetchOperation *operation) {
        return [operation.request isEqual:request];
    }] cancel];
    
    [[self.loadQueue.operations bk_match:^BOOL(CILoadOperation *operation) {
        return [operation.request isEqual:request];
    }] cancel];
}

- (void)cancelAllOperations {
    [self.loadQueue cancelAllOperations];
    [self.fetchQueue cancelAllOperations];
}

#pragma mark - properties

- (NSOperationQueue *)fetchQueue {
    if (! _fetchQueue) {
        _fetchQueue = [NSOperationQueue new];
        [_fetchQueue setName: @"CIFetchQueue"];
        _fetchQueue.maxConcurrentOperationCount = self.fetchesCount;
    }
    return _fetchQueue;
}

- (NSOperationQueue *)loadQueue {
    if (! _loadQueue) {
        _loadQueue = [NSOperationQueue new];
        [_loadQueue setName: @"CILoadQueue"];
        _loadQueue.maxConcurrentOperationCount = self.fetchesCount;
    }
    return _loadQueue;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    self.fetchQueue = nil;
    self.loadQueue = nil;
}

@end

