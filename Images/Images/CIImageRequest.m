//
//  CIImageRequest.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageRequest.h"

@interface CIImageRequest ()

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *rootSavingImagePathPrivate;
@property (strong, nonatomic) NSString *pathToStoreImage;
@end

#pragma mark -

@implementation CIImageRequest

- (instancetype)initWithId:(NSNumber *)id url:(NSString *)url {
    if (! id)
        return nil;
    if (! url)
        return nil;
    
    self = [super init];
    if (self) {
        self.id = id;
        self.url = url;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (NSString *)deriveImagePathForRootPath {
    if (self.pathToStoreImage)
        return self.pathToStoreImage;

    if (! self.rootSavingImagePathPrivate)
        return nil;
    if (! self.id)
        return nil;
    
    NSString *md5 = [self.id.description md5Hash];
    NSString *result = [[[self.rootSavingImagePathPrivate stringByAppendingPathComponent:md5]
                         stringByAppendingPathComponent:self.id.description]
                        stringByAppendingPathExtension:@"png"];
    self.pathToStoreImage = result;
    return result;
}

#pragma mark - properties

- (void)setRootSavingImagePathPrivate:(NSString *)rootSavingImagePathPrivate {
    _rootSavingImagePathPrivate = rootSavingImagePathPrivate;
    self.pathToStoreImage = [self deriveImagePathForRootPath];
}

#pragma mark -

- (BOOL)isEqual:(id)object {
    if ([super isEqual:object])
        return YES;
    if (! [object isKindOfClass:[CIImageRequest self]])
        return NO;
    
    CIImageRequest *another = object;
    return [self.id isEqual:another.id];
}

@end
