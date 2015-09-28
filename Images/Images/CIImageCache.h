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
#import "CIImageCacheProtocol.h"

@interface CIImageCache : NSObject <CIImageCacheProtocol>

- (id)initWithOperationQueues:(CIOperationQueues *)operationQueues imageLocating:(CIImageLocating *)locating;

@end
