//
//  AppDelegate.h
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableVC.h"
#import "Variables.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    
    UITabBarController *tBC;
    UIImageView *splashView;
    
}

@property (strong, nonatomic) UIWindow *window;

-(void)removeSplash;

@end

