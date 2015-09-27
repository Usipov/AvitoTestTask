//
//  CDCoreDataManager.h
//  CoreData
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CDCoreDataManager : NSObject

- (void)clearCoreData;

- (void)fetchUsersWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortAttribute
                      ascending:(BOOL)ascending
                     completion:(ArrayBlock)block;

- (void)saveCoreData;

- (User *)newUser;

@end
