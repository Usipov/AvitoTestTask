//
//  CIImageRequest+Privates.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageRequest+Privates.h"

@interface CIImageRequest ()
@property (strong, nonatomic) NSString *rootSavingImagePathPrivate;
@end

@implementation CIImageRequest (Privates)

- (void)setRootSavingImagePath:(NSString *)path {
    self.rootSavingImagePathPrivate = path;
}

@end
