//
//  CIOperationQueues.h
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIImageRequest.h"

@interface CIOperationQueues : NSObject

- (instancetype)initWithConcurrentFetchesCount:(NSUInteger)fetchesCount loadingsCount:(NSUInteger)loadingsCount;

- (void)fetchOrLoadImageForRequest:(CIImageRequest *)request completion:(IdBlock)block;

- (void)cancelOperationForRequest:(CIImageRequest *)request;

- (void)cancelAllOperations;

@end
