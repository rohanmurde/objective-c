//
//  LoginVC.h
//  iNeed
//
//  Created by tejas sawant on 12/13/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController{
    LoginVC *logVC;
}
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)login:(id)sender;
- (IBAction)registration:(id)sender;
@end
