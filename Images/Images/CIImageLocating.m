//
//  CIImageLocating.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageLocating.h"

@implementation CIImageLocating

- (NSString *)rootImageLocation {
    return [CACHES_DIRECTORY stringByAppendingPathComponent:@"images"];
}

@end
