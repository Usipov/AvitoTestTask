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

    [self setupCrashlytics];
    [self createWindowAndRootViewController];
    
    return YES;
}

#pragma mark - PushNotificationDelegate

-(void)createWindowAndRootViewController {
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)setupCrashlytics {
    [Fabric with:@[CrashlyticsKit]];
}

@end
