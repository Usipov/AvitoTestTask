//
//  CDCoreDataManager.m
//  CoreData
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CDCoreDataManager.h"

@implementation CDCoreDataManager

+ (void)initialize {
    [super initialize];
    
    // выключаем авто-создание MagicalRecord, так как создаем модель и координатор руками
    [MagicalRecord setShouldAutoCreateManagedObjectModel:NO];
    [MagicalRecord setShouldAutoCreateDefaultPersistentStoreCoordinator:NO];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCoreDataStack];
    }
    return self;
}

#pragma mark - setup

- (void)setupCoreDataStack {
    NSManagedObjectModel *model = [self setupManagedObjectModel];
    [self setupCoreDataStackWithModel:model];
}

- (NSManagedObjectModel *)setupManagedObjectModel {
    NSURL *modelURL = [self modelURL];
    NSManagedObjectModel *result = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return result;
}

- (NSURL *)modelURL {
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CoreData" ofType:@"momd"];
    NSURL *result = [NSURL fileURLWithPath:modelPath];
    return result;
}

- (void)setupCoreDataStackWithModel:(NSManagedObjectModel *)model {
    NSURL *url = [self storeUrl];
    NSPersistentStoreCoordinator *coordinator = [self setupPersistentStoreCoordinatorWithModel:model url:url];
    
    [NSManagedObjectModel MR_setDefaultManagedObjectModel:model];
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:coordinator];
    [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:coordinator];
}

- (NSURL *)storeUrl {
    NSString *path = [DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"db.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
    return url;
}

- (NSPersistentStoreCoordinator *)setupPersistentStoreCoordinatorWithModel:(NSManagedObjectModel *)model url:(NSURL *)url {
    
    NSParameterAssert(model);
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:url
                                    options:nil
                                      error:nil];
    return coordinator;
}

#pragma mark - public

- (void)clearCoreData {
    NSFileManager *manager = [NSFileManager new];
    [manager removeItemAtURL:[self storeUrl] error:nil];
    [MagicalRecord cleanUp];
    [self setupCoreDataStack];
}

- (void)fetchUsersWithPredicate:(NSPredicate *)predicate
                       sortedBy:(NSString *)sortAttribute
                      ascending:(BOOL)ascending
                     completion:(ArrayBlock)block {
    if (! block)
        return;
    
    doInBackground(^{
        NSArray *result = [User MR_findAllSortedBy:sortAttribute ascending:ascending withPredicate:predicate];
        doOnMain(^{
            block(result);
        });
    });
}

- (void)saveCoreData {
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}

- (User *)newUser {
    User *result = [User MR_createEntity];
    return result;
}

@end
