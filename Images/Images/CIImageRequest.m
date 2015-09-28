//
//  CIImageRequest.m
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CIImageRequest.h"
#import "CIImageLocating.h"

@interface CIImageRequest ()

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *pathToStoreImage;
@end

#pragma mark -

@implementation CIImageRequest

- (instancetype)initWithId:(NSString *)id url:(NSString *)url {
    if (! id)
        return nil;
    if (! url)
        return nil;
    
    self = [super init];
    if (self) {
        self.id = id;
        self.url = url;
        
        // вычисляем и сохраняем путь для хранения файла сразу, чтобы потом не возиться с потокобезопасностью
        // этот путь на 99% понадобится
        self.pathToStoreImage = [self deriveImagePath];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

- (NSString *)deriveImagePath {
    if (! self.id)
        return nil;
    if (! _pathToStoreImage)
        return _pathToStoreImage;
    
    NSString *rootPath = [[CIImageLocating new] rootImageLocation];
    NSString *md5 = [self.id md5Hash];
    NSString *result = [[[rootPath stringByAppendingPathComponent:md5]
                         stringByAppendingPathComponent:self.id]
                        stringByAppendingPathExtension:@".png"];
    _pathToStoreImage = result;
    return result;
}

#pragma mark -

- (BOOL)isEqual:(id)object {
    if ([super isEqual:object])
        return YES;
    if (! [object isKindOfClass:[CIImageRequest self]])
        return NO;
    
    CIImageRequest *another = object;
    return [self.id isEqualToString:another.id];
}

@end
