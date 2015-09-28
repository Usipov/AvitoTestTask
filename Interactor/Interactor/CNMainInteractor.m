//
//  CNMainInteractor.m
//  Interactor
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CNMainInteractor.h"
#import "CMUser.h"

@implementation CNMainInteractor

- (void)findItemsForPresenter {
    WSELF;
    [self.dataStoring fetchUsersWithCompletion:^(NSArray *modelItems) {
        [wself handleModelItems:modelItems tryLoadIfEmpty:YES];
    }];
}

- (void)handleModelItems:(NSArray *)modelItems tryLoadIfEmpty:(BOOL)tryLoad {
    NSArray *interactorItems = [self interactorItemsForModelItems:modelItems];
    [self.outputReciever foundItemsForPresenter:interactorItems];
    
    WSELF;
    if (modelItems.count == 0 && tryLoad) {
        // качаем
        [wself.downloader downloadArrayFromURL:@"https://api.github.com/users"
                                    completion:^(NSArray *downloadedItems) {
                                        [wself handleDownloadedItems:downloadedItems];
                                    } error:^(NSError *error) {
                                        DLog(@"%@", error);
                                    }];
    }
}

- (void)handleDownloadedItems:(NSArray *)downloadedItems {
    WSELF;
    [self.dataStoring createUsersOnJson:downloadedItems
                         withCompletion:^(NSArray *modelItems) {
                             [wself handleModelItems:modelItems tryLoadIfEmpty:NO];
                         }];
}

- (NSArray *)interactorItemsForModelItems:(NSArray *)modelItems {
    NSArray *result = [modelItems bk_map:^id(CMUser *user) {
        CNDataItemBuilder *builder = [CNDataItemBuilder new];
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
        
        CNDataItem *interactorItem = [[CNDataItem alloc] initWithBuilder:builder];
        return interactorItem;
    }];
    return result;
}

- (void)findImageForPresenterMatchingDataItem:(CNDataItem *)item {
    WSELF;
    CIImageRequest *request = [[CIImageRequest alloc] initWithId:item.id url:item.avatarUrl];
    [self.imageCache imageForRequest:request completion:^(id obj) {
        item.image = obj;
        [wself.outputReciever foundImageForPresenterMatchingDataItem:item];
    }];
}

@end