//
//  CIFetchOperation.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIFetchOperation.h"

@interface CIFetchOperation ()
@property (strong, atomic) CIImageRequest *request;
@property (copy, nonatomic) IdBlock block;
@end

#pragma mark -

@implementation CIFetchOperation

- (instancetype)initWithRequest:(CIImageRequest *)request completion:(IdBlock)block {
    self = [super init];
    if (self) {
        self.request = request;
        self.block = block;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

-(void)main {
    if (self.cancelled)
        return;
    
    @autoreleasepool {
        NSString *imagePath = [self.request pathToStoreImage];
        
        if (self.cancelled)
            return;
        
        // можно еще добавить удаление устаревших картинок, но не в этот раз
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
       
        if (self.cancelled)
            return;
        
        id result = [image isKindOfClass:[UIImage self]] ? image : [NSNull null];
        
        doOnMain(^{
            if (! self.cancelled) {
                self.block(result);
            };
        });
    }
}

@end
