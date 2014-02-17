//
//  DUAppDelegate.m
//  Duck
//
//  Created by Brad Taylor on 2/16/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import "DUAppDelegate.h"
#import "DUMainViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface DUAppDelegate()

@property (nonatomic, readwrite, strong) DUMainViewController *mainViewController;
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;

@end

@implementation DUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    self.mainViewController = [[DUMainViewController alloc] init];
    self.window.rootViewController = self.mainViewController;
    
    [self.window makeKeyAndVisible];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.locationManager startUpdatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
