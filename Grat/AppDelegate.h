//
//  AppDelegate.h
//  Grat
//
//  Created by Chad Ackerman on 1/11/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ProximityKit/ProximityKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RPKManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RPKManager *proximityKitManager;

@end

