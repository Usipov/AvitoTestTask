//
//  User.h
//  CoreData
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * gravatarId;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * htmlUrl;
@property (nonatomic, retain) NSString * followersUrl;
@property (nonatomic, retain) NSString * followingUrl;
@property (nonatomic, retain) NSString * gistsUrl;
@property (nonatomic, retain) NSString * starredUrl;
@property (nonatomic, retain) NSString * subscriptionsUrl;
@property (nonatomic, retain) NSString * organizationsUrl;
@property (nonatomic, retain) NSString * reposUrl;
@property (nonatomic, retain) NSString * eventsUrl;
@property (nonatomic, retain) NSString * receivedEventsUrl;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * siteAdmin;

@end
