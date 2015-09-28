//
//  CVInterfaceItem.h
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVInterfaceItem : NSObject

@property (nonatomic, strong, readonly) NSString *login;
@property (nonatomic, strong, readonly) NSNumber *id;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithId:(NSNumber *)id login:(NSString *)login;

@end
