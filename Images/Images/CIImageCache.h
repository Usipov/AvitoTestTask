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
#import "CIImageLocating.h"

@interface CIImageCache : NSObject

- (id)initWithOperationQueues:(CIOperationQueues *)operationQueues imageLocating:(CIImageLocating *)locating;

- (void)imageForRequest:(CIImageRequest *)request completion:(IdBlock)block;
- (void)removeAllObjects;
- (void)clearAllObjects;
- (void)cancelAllOperations;
- (void)removeImageForRequest:(CIImageRequest *)request;

@end
