//
//  CVIntrfaceItem.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVInterfaceItem.h"

@interface CVInterfaceItem ()
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSNumber *id;
@end

#pragma mark -

@implementation CVInterfaceItem

- (instancetype)initWithId:(NSNumber *)id login:(NSString *)login {
    if (! id)
        return nil;
    
    self = [super init];
    if (self) {
        self.id = id;
        self.login = login ? : @"";
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

@end
