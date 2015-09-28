//
//  CIImageCache.h
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIImageRequest.h"
#import "CIOperationQueues.h"

@interface CIImageCache : NSObject

- (id)initWithOperationQueues:(CIOperationQueues *)operationQueues;

- (void)imageForRequest:(CIImageRequest *)request completion:(IdBlock)block;
- (void)removeAllObjects;
- (void)cancelAllOperations;
- (void)removeImageForRequest:(CIImageRequest *)request;

@end
