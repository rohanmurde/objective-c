//
//  cameraViewController.m
//  iNeed
//
//  Created by Rohan Murde on 11/24/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "lenderViewController.h"

@interface lenderViewController ()

@end

@implementation lenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.tag = 0;
    self.tfStatus.inputView = picker;
    self.statusData = @[@"Unavailable",@"Available"];
    
    UIPickerView *pickerState = [[UIPickerView alloc] init];
    pickerState.dataSource = self;
    pickerState.delegate = self;
    pickerState.tag = 1;
    self.tfState.inputView = pickerState;
    self.stateData = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];

    UIPickerView *pickerCategory = [[UIPickerView alloc] init];
    pickerCategory.dataSource = self;
    pickerCategory.delegate = self;
    pickerCategory.tag = 2;
    self.tfCategory.inputView = pickerCategory;
    self.categoryData = @[@"Books",@"Car",@"Laptops",@"Tools",@"Projector",@"Vaccum Cleaner",@"Kitchenware",@"Magazine",@"Calculator",@"Money",@"Mobile",@"Others"];
}

-(void)dismissKeyboard {
    [_tfCategory resignFirstResponder];
    [_tfdescription resignFirstResponder];
    [_tfStreet resignFirstResponder];
    [_tfState resignFirstResponder];
    [_tfCity resignFirstResponder];
    [_tfZipCode resignFirstResponder];
    [_tfMobileNumber resignFirstResponder];
    [_tfEmailAddress resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) useCamera:(id)sender {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = YES;
    
}

-(void) useGallery:(id)sender{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    newMedia = YES;
}

#pragma mark
#pragma image picker delegates
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void) image: (UIImage *)image finishedSavingWithError: (NSError *)error contextInfo: (void *) contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed" message:@"Failed to save image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.imageView = nil;
}

-(void)useClear{
    self.imageView.image=[UIImage imageNamed:@"NoImage.gif"];
    self.tfName.text = @"";
    self.tfCategory.text = @"";
    self.tfdescription.text=@"";
    self.tfState.text=@"";
    self.tfStreet.text=@"";
    self.tfCity.text=@"";
    self.tfZipCode.text=@"";
    self.tfMobileNumber.text=@"";
    self.tfEmailAddress.text=@"";
    self.tfStatus.text=@"";
}

-(void)useAddItem:(id)sender{
    [self.aiv startAnimating];
    
    if ((([[_tfCategory.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) |
         ([[_tfCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) |
         ([[_tfdescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)|
         ([[_tfEmailAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)|
         !([[_tfMobileNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 10)|
         ([[_tfName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)|
         ([[_tfState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)|
         ([[_tfStreet.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)|
         !([[_tfZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 5)|
         ([[_tfStatus.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0))
        )
    {
        NSString *msg;
        msg = [NSString stringWithFormat:@"No empty fields please !"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    else{
    NSString *cat = _tfCategory.text;
    NSString *cit = _tfCity.text;
    NSString *des = _tfdescription.text;
    NSString *ema = _tfEmailAddress.text;
    NSString *mob = _tfMobileNumber.text;
    NSString *nam = _tfName.text;
    NSString *sta = _tfState.text;
    NSString *str = _tfStreet.text;
    NSString *zip = _tfZipCode.text;
    NSString *status = _tfStatus.text;
     NSString *flag= @"insert";
    
    NSData * imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSString *nameofimg = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    
    //NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service.php"];
    NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed20/iNeed_Service.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
 
    NSDictionary *dictionary = @{@"category":cat,@"name":nam,@"description":des,@"street":str,@"city":cit,@"state":sta,@"zip":zip,@"mobile":mob,@"email":ema,@"image":nameofimg, @"status":status, @"flag":flag};
    
    NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        if(error==nil){
            [self.aiv stopAnimating];
            NSString *msg;
            msg = [NSString stringWithFormat:@"Your item was inserted successfully"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }];
    
    
    
    [uploadTask resume];
    
    
    [self useClear];
    }
}

-(void)useDelItem:(id)sender{
    [self.aiv startAnimating];
    NSString *cat = _tfCategory.text;
    NSString *des = _tfdescription.text;
    NSString *nam = _tfName.text;
    NSString *flag= @"delete";
    
    //NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service.php"];
    NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed20/iNeed_Service.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"category":cat,@"name":nam,@"description":des,@"flag":flag};
    
    NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        if(error==nil){
            [self.aiv stopAnimating];
            NSString *msg;
            msg = [NSString stringWithFormat:@"Your item was deleted successfully"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        

        
    }];
    
    
    
    [uploadTask resume];
    
    
    [self useClear];
    
}

-(void)useFetchItem:(id)sender{
    [self.aiv startAnimating];
    NSString *cat = _tfCategory.text;
    NSString *des = _tfdescription.text;
    NSString *nam = _tfName.text;
    NSString *flag= @"select";
    
    //NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service.php"];
    NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed20/iNeed_Service.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"category":cat,@"name":nam,@"description":des,@"flag":flag};
    
    NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    [self.aiv stopAnimating];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if(error==nil){
            
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"ResponseData = %@",responseData);
             NSLog(@"ResponseData Length= %lu",(unsigned long)[responseData length]);
            NSLog(@"----End of ResponseData---");
            
            if ([[responseData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 2) {
                NSString *msg;
                msg = [NSString stringWithFormat:@"Incorrect data entered !\n Enter Full Name, Category & Description correctly !"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                

            }
            
            else{
                
                NSMutableData *mutData = (NSMutableData *)[responseData dataUsingEncoding:NSUTF8StringEncoding];
                
                //NSLog(@"mutData==%@",mutData);
                
                NSError *error;
                jsonArray = [NSJSONSerialization JSONObjectWithData:mutData options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"select JSON Array==%@",jsonArray);
                
                NSDictionary *item = jsonArray[0];
                NSLog(@"item========%@",item);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //this block will be executed asynchronously on the main thread bcoz we aren't on the main GUI thread
                    _tfCategory.text = item[@"category"];
                    _tfZipCode.text = item[@"zip"];
                    _tfCity.text = item[@"city"];
                    _tfdescription.text = item[@"description"];
                    _tfEmailAddress.text = item[@"email"];
                    _tfMobileNumber.text = item[@"mobile"];
                    _tfName.text = item[@"name"];
                    _tfState.text = item[@"state"];
                    _tfStreet.text = item[@"street"];
                    _tfStatus.text = item[@"status"];
                    
                    UIImage *img = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:item[@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
                    
                    self.imageView.image = img;
                    
                    
                });
            }
          
            
        }
        
    }];

    [uploadTask resume];
  
}

-(void)useUpdateItem:(id)sender{
    [self.aiv startAnimating];
    NSLog(@"Length===%lu",(unsigned long)[_tfCategory.text length]);
   
    if(
        (([[_tfCategory.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) ||
        ([[_tfCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) ||
        ([[_tfdescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)||
        ([[_tfEmailAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)||
        !([[_tfMobileNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 10)||
        ([[_tfName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)||
        ([[_tfState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)||
        ([[_tfStreet.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)||
        !([[_tfZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 5)||
        ([[_tfStatus.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) )
       
//         [[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:_tfZipCode.text]])
         
         //[_tfZipCode.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
       )
    {
        NSString *msg;
        msg = [NSString stringWithFormat:@"Something is wrong with the data you provided !"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
    NSString *cat = _tfCategory.text;
    NSString *cit = _tfCity.text;
    NSString *des = _tfdescription.text;
    NSString *ema = _tfEmailAddress.text;
    NSString *mob = _tfMobileNumber.text;
    NSString *nam = _tfName.text;
    NSString *sta = _tfState.text;
    NSString *str = _tfStreet.text;
    NSString *zip = _tfZipCode.text;
    NSString *status = _tfStatus.text;
    NSString *flag= @"update";
    
    NSData * imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSString *nameofimg = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //NSLog(@"From image field: %@",nameofimg);
    
    //NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service.php"];
    NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed20/iNeed_Service.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary *dictionary = @{@"category":cat,@"name":nam,@"description":des,@"street":str,@"city":cit,@"state":sta,@"zip":zip,@"mobile":mob,@"email":ema, @"image":nameofimg, @"status":status, @"flag":flag};
    
    NSLog(@"Dictionary --- > %@",dictionary);
    
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        if(error==nil){
            [self.aiv stopAnimating];
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"ResponseData = %@",responseData);
            NSLog(@"ResponseData Length= %lu",(unsigned long)[responseData length]);
          
            
            NSString *msg;
            msg = [NSString stringWithFormat:@"Your item was updated successfully"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
                
    }];
    
    
    
    [uploadTask resume];
    
    
    [self useClear];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView.tag == 0){
        return self.statusData[row];
    }
    else if(pickerView.tag == 1){
        return self.stateData[row];
    }
    else{
        return self.categoryData[row];
    }
 
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag == 0)
    {
    self.tfStatus.text = self.statusData[row];
    [self.tfStatus resignFirstResponder];
    }
    
    else if(pickerView.tag == 1)
    {
    self.tfState.text = self.stateData[row];
    [self.tfState resignFirstResponder];
    }
    
    else
    {
    self.tfCategory.text = self.categoryData[row];
    [self.tfCategory resignFirstResponder];
        
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 0)
    {
    return self.statusData.count;
    }
    else if(pickerView.tag == 1){
        return self.stateData.count;
    }
    else{
        return self.categoryData.count;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
