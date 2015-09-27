//
//  CMDataStoring.m
//  Model
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CMDataStoring.h"
#import "CMUser.h"

@implementation CMDataStoring

- (void)fetchUsersWithCompletion:(ArrayBlock)block {
    if (! block)
        return;
    
    WSELF;
    [self.coreDataManager fetchUsersWithPredicate:nil
                                         sortedBy:NSStringFromSelector(@selector(id))
                                        ascending:YES
                                       completion:^(NSArray *users) {
                                           NSArray *result = [wself modelUsersFromCoreDataUsers:users];
                                           block(result);
                                       }];
}

- (NSArray *)modelUsersFromCoreDataUsers:(NSArray *)users {
    NSArray *result = [users bk_map:^id(User *user) {
        CMUserBuilder *builder = [CMUserBuilder new];
        builder.login = user.login;
        builder.id = user.id;
        builder.avatarUrl = user.avatarUrl;
        builder.gravatarId = user.gravatarId;
        builder.url = user.url;
        builder.htmlUrl = user.htmlUrl;
        builder.followersUrl = user.followersUrl;
        builder.followingUrl = user.followingUrl;
        builder.gistsUrl = user.gistsUrl;
        builder.starredUrl = user.starredUrl;
        builder.subscriptionsUrl = user.subscriptionsUrl;
        builder.organizationsUrl = user.organizationsUrl;
        builder.reposUrl = user.reposUrl;
        builder.eventsUrl = user.eventsUrl;
        builder.receivedEventsUrl = user.receivedEventsUrl;
        builder.type = user.type;
        builder.siteAdmin = user.siteAdmin;
        
        CMUser *cmUser = [[CMUser alloc] initWithBuilder:builder];
        return cmUser;
    }];
    
    return result;
}

@end
