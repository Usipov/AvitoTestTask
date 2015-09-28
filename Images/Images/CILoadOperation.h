//
//  CILoadOperation.h
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIImageRequest.h"

@interface CILoadOperation : NSOperation

- (instancetype)initWithRequest:(CIImageRequest *)request completion:(IdBlock)block;

@property (strong, nonatomic, readonly) CIImageRequest *request;

@end
