//
//  CMDataStoring.h
//  Model
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCoreDataManager.h"

@interface CMDataStoring : NSObject

- (instancetype)initWithCoreData:(CDCoreDataManager *)coreDataManager;

@property (strong, nonatomic, readonly) CDCoreDataManager *coreDataManager;

- (void)fetchUsersWithCompletion:(ArrayBlock)block;

- (void)createUsersOnJson:(NSArray *)json withCompletion:(ArrayBlock)block;

- (void)clearStorage;

@end
