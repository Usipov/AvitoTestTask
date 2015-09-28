//
//  CNDataItem.h
//  Interactor
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNDataItemBuilder.h"

@interface CNDataItem : NSObject

@property (nonatomic, strong, readonly) NSString * login;
@property (nonatomic, strong, readonly) NSNumber * id;
@property (nonatomic, strong, readonly) NSString * avatarUrl;
@property (nonatomic, strong, readonly) NSString * gravatarId;
@property (nonatomic, strong, readonly) NSString * url;
@property (nonatomic, strong, readonly) NSString * htmlUrl;
@property (nonatomic, strong, readonly) NSString * followersUrl;
@property (nonatomic, strong, readonly) NSString * followingUrl;
@property (nonatomic, strong, readonly) NSString * gistsUrl;
@property (nonatomic, strong, readonly) NSString * starredUrl;
@property (nonatomic, strong, readonly) NSString * subscriptionsUrl;
@property (nonatomic, strong, readonly) NSString * organizationsUrl;
@property (nonatomic, strong, readonly) NSString * reposUrl;
@property (nonatomic, strong, readonly) NSString * eventsUrl;
@property (nonatomic, strong, readonly) NSString * receivedEventsUrl;
@property (nonatomic, strong, readonly) NSString * type;
@property (nonatomic, strong, readonly) NSNumber * siteAdmin;

@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithBuilder:(CNDataItemBuilder *)builder;

@end
