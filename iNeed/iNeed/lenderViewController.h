//
//  cameraViewController.h
//  iNeed
//
//  Created by Rohan Murde on 11/24/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface lenderViewController : UIViewController
                                <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate> {
    UIImageView *imageView;
    BOOL newMedia;
    NSArray *jsonArray;
    lenderViewController *lenderVC;
                                    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfCategory;
@property (weak, nonatomic) IBOutlet UITextField *tfdescription;
@property (weak, nonatomic) IBOutlet UITextField *tfStreet;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UITextField *tfState;
@property (weak, nonatomic) IBOutlet UITextField *tfZipCode;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfStatus;

@property (strong,nonatomic) NSArray *statusData;
@property (strong,nonatomic) NSArray *stateData;
@property (strong,nonatomic) NSArray *categoryData;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiv;

-(IBAction)useCamera:(id)sender;
-(IBAction)useGallery:(id)sender;
-(IBAction)useClear;
-(IBAction)useAddItem:(id)sender;
-(IBAction)useDelItem:(id)sender;
-(IBAction)useFetchItem:(id)sender;
-(IBAction)useUpdateItem:(id)sender;
-(IBAction)textFieldReturn:(id)textField;

@end
