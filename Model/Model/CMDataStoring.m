//
//  CMDataStoring.m
//  Model
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CMDataStoring.h"
#import "CMUser.h"

@interface CMDataStoring ()
@property (strong, nonatomic) CDCoreDataManager *coreDataManager;
@end

#pragma mark -

@implementation CMDataStoring

- (instancetype)initWithCoreData:(CDCoreDataManager *)coreDataManager {
    if (! coreDataManager)
        return nil;
    
    self = [super init];
    if (self) {
        self.coreDataManager = coreDataManager;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:CUUTILS_ERROR reason:CUUTILS_MESSAGE_ABSTRACT_METHOD userInfo:nil];
}

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

- (void)createUsersOnJson:(NSArray *)json withCompletion:(ArrayBlock)block {
    WSELF;
    doInBackground(^{
        NSArray *users = [json bk_map:^id(NSDictionary *userData) {

            User *user = [self.coreDataManager newUser];
            
            user.login = userData[@"login"];
            user.id = userData[@"id"];
            user.avatarUrl = userData[@"avatar__url"];
            user.gravatarId = userData[@"gravatar_id"];
            user.url = userData[@"_url"];
            user.htmlUrl = userData[@"html_url"];
            user.followersUrl = userData[@"followers_url"];
            user.followingUrl = userData[@"following_url"];
            user.gistsUrl = userData[@"gists_url"];
            user.starredUrl = userData[@"starred_url"];
            user.subscriptionsUrl = userData[@"subscriptions_url"];
            user.organizationsUrl = userData[@"organizations_url"];
            user.reposUrl = userData[@"repos_url"];
            user.eventsUrl = userData[@"events__url"];
            user.receivedEventsUrl = userData[@"receivedEvents_url"];
            user.type = userData[@"type"];
            user.siteAdmin = userData[@"site_admin"];
            
            return user;
        }];
        
        [wself.coreDataManager saveCoreData];
        
        NSArray *modelUsers = [wself modelUsersFromCoreDataUsers:users];
        doOnMain(^{
            if (block) {
                block(modelUsers);
            }
        });
    });
}

- (void)clearStorage {
    [self.coreDataManager clearCoreData];
}

@end
