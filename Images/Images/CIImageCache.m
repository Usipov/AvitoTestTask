//
//  CIImageCache.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageCache.h"
#import "CIOperationQueues.h"
#import "CIImageRequest+Privates.h"

@interface CIImageCache ()
@property (strong, nonatomic) NSCache *imagesCache;
@property (strong, nonatomic) CIOperationQueues *operationQueues;
@property (strong, nonatomic) CIImageLocating *imageLocating;
@end

#pragma mark -

@implementation CIImageCache

- (instancetype)initWithOperationQueues:(CIOperationQueues *)operationQueues imageLocating:(CIImageLocating *)locating {
    if (! operationQueues)
        return nil;
    if (! locating)
        return nil;
    
    self = [super init];
    if (self) {
        self.operationQueues = operationQueues;
        self.imageLocating = locating;
        
        self.imagesCache = [NSCache new];
        [self.imagesCache setName: @"CIImagesCache"];
        [self.imagesCache setTotalCostLimit: 2097152];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (void)imageForRequest:(CIImageRequest *)request completion:(IdBlock)block {
    if (! request)
        return;
    if (! block)
        return;
    
    // добавляем еще одно свойство закрытым образом
    [request setRootSavingImagePath:self.imageLocating.rootImageLocation];
    
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

- (void)cancelGettingImageForRequest:(CIImageRequest *)request {
    [self.operationQueues cancelOperationForRequest:request];
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

- (void)clearAllObjects {
    [self removeAllObjects];
    [self cancelAllOperations];
    
    NSString *rootSavingPath = self.imageLocating.rootImageLocation;
    [[NSFileManager new] removeItemAtPath:rootSavingPath error:nil];
}

- (void)cancelAllOperations {
    [self.operationQueues cancelAllOperations];
}

- (void)removeImageForRequest:(CIImageRequest *)request {
    if (! request.pathToStoreImage)
        return;
    
    @synchronized(self.imagesCache) { // mutex lock
        [self.imagesCache removeObjectForKey:request.pathToStoreImage];
    }
}

@end
