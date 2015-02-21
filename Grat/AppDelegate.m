//
//  AppDelegate.m
//  Grat
//
//  Created by Chad Ackerman on 1/11/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.proximityKitManager = [RPKManager managerWithDelegate:self];
    [self.proximityKitManager.locationManager requestWhenInUseAuthorization];
    [self.proximityKitManager.locationManager requestAlwaysAuthorization];
    [self.proximityKitManager start];
    self.rangedBeacons = [[NSMutableArray alloc] init];
    
    UIColor *brandGreen = [UIColor colorWithRed:27.0/255.0 green:188.0/255.0 blue:155.0/255.0 alpha:1.0];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundColor:brandGreen];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

#pragma mark ProximityKit delegate methods

-(void)proximityKit:(RPKManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(RPKRegion *)region {
    
    if (region) {
        [self.rangedBeacons addObject:region.attributes];
        // Post a notification with the URL to open
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"FoundBeacon"
         object:self
         userInfo:region.attributes];
    }
    
    [self.proximityKitManager stopRangingIBeacons];
}

-(void)proximityKit:(RPKManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)proximityKit:(RPKManager *)manager didEnter:(RPKRegion *)region {
    NSLog(@"entered %@", region);
}
- (void)proximityKit:(RPKManager *)manager didExit:(RPKRegion *)region {
    NSLog(@"exited %@", region);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
