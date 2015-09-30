//
//  AppDelegate.m
//  Sample
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self createWindowAndRootViewController];
    return YES;
}

#pragma mark - PushNotificationDelegate

-(void)createWindowAndRootViewController {
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // модель
    CDCoreDataManager *coreData = [CDCoreDataManager new];
    CMDataStoring *storing = [[CMDataStoring alloc] initWithCoreData:coreData];
    
    // сервисы интерактора
    CIOperationQueues *operationQueues = [[CIOperationQueues alloc] initWithConcurrentFetchesCount:1 loadingsCount:2];
    CIImageLocating *imageLocating = [CIImageLocating new];
    CIImageCache *imageCache = [[CIImageCache alloc] initWithOperationQueues:operationQueues imageLocating:imageLocating];;
    CNDownloader *downloader = [CNDownloader new];
    
    // интерактор
    CNMainInteractor *interactor = [CNMainInteractor new];
    interactor.dataStoring = storing;
    interactor.imageCache = imageCache;
    interactor.downloader = downloader;
    
    // представление
    CVViewController *viewController = [[CVViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // презентер
    CPMainPresenter *presenter = [CPMainPresenter new];
    presenter.interface = viewController;
    presenter.interactor = interactor;
    interactor.outputReciever = presenter;
    viewController.eventsHandler = presenter;
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
}

@end
