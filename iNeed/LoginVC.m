//
//  LoginVC.m
//  iNeed
//
//  Created by tejas sawant on 12/13/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
   
}

-(void)dismissKeyboard {
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
}


-(IBAction)textFieldReturn:(id)textField{
    [textField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    
    //Create and add the Activity Indicator to splashView
    
    [_activityIndicator startAnimating];
    
    NSString *username = [self.userName text];
    NSString *password = [self.password text];
    NSString *flag = @"oldUser";
    
    if ([[username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
        [_activityIndicator stopAnimating];
        NSString *msg;
        msg = [NSString stringWithFormat:@"Invalid Username !"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    else if ([[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0){
        [_activityIndicator stopAnimating];
        NSString *msg;
        msg = [NSString stringWithFormat:@"Invalid Password !"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {

    NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service_login.php"];
    //NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed21/iNeed_Service_login.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"username":username,@"password":password,@"flag":flag};
    
    //NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if(error==nil){
            
            [_activityIndicator stopAnimating];
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"ResponseData = %@",responseData);
            //NSLog(@"ResponseData Length= %lu",(unsigned long)[responseData length]);
            //NSLog(@"----End of ResponseData---");
            
            if ([[responseData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 2) {
                
                NSString *msg;
                msg = [NSString stringWithFormat:@"Login Unsuccessful. New Users please click Register Button !"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                
            }
            
            else{
                [_activityIndicator stopAnimating];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //this block will be executed asynchronously on the main thread bcoz we aren't on the main GUI thread
                    
                    UIStoryboard *storyboard = self.storyboard;
                    LoginVC *lvc = [storyboard instantiateViewControllerWithIdentifier:@"loginscreen"];
                    
                    // Configure the new view controller here.
                    
                    [self presentViewController:lvc animated:YES completion:nil];
                });
               
                
            }
            
                    
        }
    
        
    }];
    
    [uploadTask resume];
}
}

-(IBAction)registration:(id)sender{
    
    [_activityIndicator startAnimating];
    
    NSString *username = [self.userName text];
    NSString *password = [self.password text];
    NSString *flag = @"newUser";
    
    if ([[username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
    [_activityIndicator stopAnimating];
    NSString *msg;
    msg = [NSString stringWithFormat:@"Invalid Username !"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
    }
    
    else if ([[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0){
        [_activityIndicator stopAnimating];
        NSString *msg;
        msg = [NSString stringWithFormat:@"Invalid Password !"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
    NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service_login.php"];
    //NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed21/iNeed_Service_login.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"username":username,@"password":password,@"flag":flag};
    
    //NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if(error==nil){
            [_activityIndicator stopAnimating];
            
                NSString *msg;
                msg = [NSString stringWithFormat:@"Registration Successful !"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                

                [_activityIndicator stopAnimating];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //this block will be executed asynchronously on the main thread bcoz we aren't on the main GUI thread
                    
                    UIStoryboard *storyboard = self.storyboard;
                    LoginVC *lvc = [storyboard instantiateViewControllerWithIdentifier:@"loginscreen"];
                    
                    // Configure the new view controller here.
                    
                    [self presentViewController:lvc animated:YES completion:nil];
                });
            
            
        }
        
        
    }];
    
    [uploadTask resume];
}
    
}

@end
