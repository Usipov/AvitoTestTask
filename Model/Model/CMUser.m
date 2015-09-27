//
//  CMUser.m
//  Model
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CMUser.h"

@interface CMUser ()

@property (nonatomic, strong) NSString * login;
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSString * avatarUrl;
@property (nonatomic, strong) NSString * gravatarId;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * htmlUrl;
@property (nonatomic, strong) NSString * followersUrl;
@property (nonatomic, strong) NSString * followingUrl;
@property (nonatomic, strong) NSString * gistsUrl;
@property (nonatomic, strong) NSString * starredUrl;
@property (nonatomic, strong) NSString * subscriptionsUrl;
@property (nonatomic, strong) NSString * organizationsUrl;
@property (nonatomic, strong) NSString * reposUrl;
@property (nonatomic, strong) NSString * eventsUrl;
@property (nonatomic, strong) NSString * receivedEventsUrl;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSNumber * siteAdmin;

@end

#pragma mark - 

@implementation CMUser

- (instancetype)initWithBuilder:(CMUserBuilder *)builder {
    self = [super init];
    if (self) {
        self.login = builder.login;
        self.id = builder.id;
        self.avatarUrl = builder.avatarUrl;
        self.gravatarId = builder.gravatarId;
        self.url = builder.url;
        self.htmlUrl = builder.htmlUrl;
        self.followersUrl = builder.followersUrl;
        self.followingUrl = builder.followingUrl;
        self.gistsUrl = builder.gistsUrl;
        self.starredUrl = builder.starredUrl;
        self.subscriptionsUrl = builder.subscriptionsUrl;
        self.organizationsUrl = builder.organizationsUrl;
        self.reposUrl = builder.reposUrl;
        self.eventsUrl = builder.eventsUrl;
        self.receivedEventsUrl = builder.receivedEventsUrl;
        self.type = builder.type;
        self.siteAdmin = builder.siteAdmin;
    }
    return self;
}

@end
