//
//  AppDelegate.m
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//blueButton.png and greyButton.png downloaded from http://nathanbarry.com/designing-buttons-ios5/


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self.window addSubview:tBC];
    
    [_window makeKeyAndVisible];
    
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    splashView.image = [UIImage imageNamed:@"splashScreenLogo.png"];
    
    [self.window addSubview:splashView];
    
    [self.window bringSubviewToFront:splashView];
    
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:3];
    
    
    
    //Create and add the Activity Indicator to splashView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(160, 360);
    activityIndicator.hidesWhenStopped = NO;
    activityIndicator.center = splashView.center;
    [splashView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    //Reference: http://stackoverflow.com/questions/9400193/adding-an-activity-indicator-programmatically-to-a-view
    
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.1 green:0.7 blue:0.4 alpha:1.0]];
//    [[UITabBar appearance] setBarTintColor:[UIColor greenColor]];
    
    
    return YES;
}

-(void)removeSplash;
{
    [splashView removeFromSuperview];
}


@end
