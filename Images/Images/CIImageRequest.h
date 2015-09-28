//
//  CIImageRequest.h
//  Images
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CIImageRequest : NSObject

@property (strong, nonatomic, readonly) NSString *id;
@property (strong, nonatomic, readonly) NSString *url;

- (instancetype)initWithId:(NSString *)id url:(NSString *)url;

- (NSString *)pathToStoreImage;

@end
