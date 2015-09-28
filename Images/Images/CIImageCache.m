//
//  CIImageCache.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageCache.h"
#import "CIOperationQueues.h"

@interface CIImageCache ()
@property (strong, nonatomic) NSCache *imagesCache;
@property (strong, nonatomic) CIOperationQueues *operationQueues;
@end

#pragma mark -

@implementation CIImageCache

- (instancetype)initWithOperationQueues:(CIOperationQueues *)operationQueues {
    if (! operationQueues)
        return nil;
    
    self = [super init];
    if (self) {
        self.operationQueues = [CIOperationQueues new];
        
        self.imagesCache = [NSCache new];
        [self.imagesCache setName: @"CIImagesCache"];
        [self.imagesCache setTotalCostLimit: 2097152];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (void)thumbImageForRequest: (CIImageRequest *)request completion:(IdBlock)block {
    if (! request.pathToStoreImage)
        return;
    if (! block)
        return;
    
    id cachedImage = nil;
    
    @synchronized(self.imagesCache) { // mutex lock
        cachedImage = [self.imagesCache objectForKey:request.pathToStoreImage];
    }
    
    WSELF;
    if (! cachedImage) {
        [self.operationQueues fetchOrLoadImageForRequest:request completion:^(id obj) {
            UIImage *image = [wself cacheObject:obj forRequest:request];
            block(image);
        }];
    }
    
    block(cachedImage);
}

- (UIImage *)cacheObject:(id)object forRequest:(CIImageRequest *)request {
    if (! [object isKindOfClass:[UIImage self]])
        return nil;
    if (! request.pathToStoreImage)
        return nil;
    
    @synchronized(self.imagesCache) { // mutex lock
        [self.imagesCache setObject:object forKey:request.pathToStoreImage];
    }
    
    return object;
}

- (void)removeAllObjects {
    @synchronized(self.imagesCache) { // mutex lock
        [self.imagesCache removeAllObjects];
    }
}

- (void)cancelAllOperations {
    [self.operationQueues cancelAllOperations];
}

- (void)removeThumbForRequest:(CIImageRequest *)request {
    if (! request.pathToStoreImage)
        return;
    
    @synchronized(self.imagesCache) { // mutex lock
        [self.imagesCache removeObjectForKey:request.pathToStoreImage];
    }
}

@end
