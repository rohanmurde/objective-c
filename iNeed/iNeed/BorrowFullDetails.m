//
//  BorrowFullDetails.m
//  iNeed
//
//  Created by Rohan Murde on 11/24/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "BorrowFullDetails.h"

#define Item_Image 0
#define Item_Status 1
#define Item_Category 2
#define Item_Description 3
#define Owner_Name 4
#define Owner_Street 5
#define Owner_City 6
#define Owner_State 7
#define Owner_Zip 8
#define Owner_Mobile 9
#define Owner_Email 10
#define Show_Map 11
#define Favorite 12


@interface BorrowFullDetails ()

@end

@implementation BorrowFullDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        [_locationManager requestWhenInUseAuthorization];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //NSLog(@"FromBorrowVC=%@",_borrowFullItemDetails);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    switch (section) {
        case Item_Image:
            title = @"Item Image";
            break;
        case Item_Status:
            title = @"Status";
            break;
            
        case Item_Category:
            title = @"Item Category";
            break;
        case Item_Description:
            title = @"Item Description";
            break;
        case Owner_Name:
            title = @"Owner Name";
            break;
        case Owner_Street:
            title = @"Street Name";
            break;
        case Owner_City:
            title = @"City";
            break;
        case Owner_State:
            title = @"State";
            break;
        case Owner_Zip:
            title = @"Zip Code";
            break;
        case Owner_Mobile:
            title = @"Owner's Mobile Number";
            break;
        case Owner_Email:
            title = @"Owner's Email Address";
            break;
        case Show_Map:
            title = @"Show On Map";
            break;
        case Favorite:
            title = @"Favorite It";
            break;
            
        default:
            NSLog(@"Should not be here");
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    // Configure the cell...
    _item = _borrowFullItemDetails[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:197.0/255 green:195.0/255 blue:255/255 alpha:0.5];
    
    switch (indexPath.section) {
        case Item_Image:
        {
            //cell.textLabel.text=_item[@"image"];
            UIImage *image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:_item[@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
            //cell.imageView.image = image;
            cell.backgroundColor = [UIColor whiteColor];
            
            UIImageView *newImageView = [[UIImageView alloc] initWithImage:image];
            newImageView.frame = CGRectMake(60, 0, 200, 200);
            [cell addSubview:newImageView];
            
        }
            break;
            
        case Item_Status:
        {
            cell.textLabel.text=_item[@"status"];
        }
            break;
            
        case Item_Category:
        {
            cell.textLabel.text=_item[@"category"];
        }
            break;
            
        case Item_Description:
        {
            cell.textLabel.text=_item[@"description"];
        }
            break;
            
        case Owner_Name:
        {
            cell.textLabel.text=_item[@"name"];
        }
            break;
        case Owner_Street:
        {
            cell.textLabel.text=_item[@"street"];
        }
            break;
        case Owner_City:
        {
            cell.textLabel.text=_item[@"city"];
        }
            break;
        case Owner_State:
        {
            cell.textLabel.text=_item[@"state"];
        }
            break;
        case Owner_Zip:
        {
            cell.textLabel.text=_item[@"zip"];
        }
            break;
        case Owner_Mobile:
        {
            cell.textLabel.text=_item[@"mobile"];
        }
            break;
        case Owner_Email:
        {
            cell.textLabel.text=_item[@"email"];
        }
            break;
        case Show_Map:
        {
            cell.textLabel.text=@"Get Driving Directions";
        }
            break;
        case Favorite:
        {
            cell.textLabel.text=@"Add to Favorites";
        }
            break;
            
        default:
            NSLog(@"Should not be here !!");
            break;
    }
    cell.textLabel.numberOfLines =0;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case Favorite:
        {
            NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults
                                                                     standardUserDefaults] arrayForKey:@"favorites"]];
            
            if (![array containsObject:_item[@"description"]]) {
                [array addObject:_item[@"description"]];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"favorites"];
            
            NSString *msg = [NSString stringWithFormat:@"%@ was added to Favorites",_item[@"description"]];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favorites" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            break;

        }
            
        case Owner_Email:
        {
            // Email Subject
            NSString *emailTitle = [NSString stringWithFormat:@"Interested in %@",_item[@"description"]];
            // Email Content
            // Change the message body to HTML
            NSString *messageBody = @"<h4>Hi <br> Is the item still available ?</h4>";
            
            // To address
            NSString *emailaddress = [NSString stringWithFormat:@"%@",_item[@"email"]];
            NSArray *toRecipients = [emailaddress componentsSeparatedByString:@" "];
            
            if([MFMailComposeViewController canSendMail]){
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:YES];
                [mc setToRecipients:toRecipients];
                // Present mail view controller on screen
                [self presentViewController:mc animated:YES completion:NULL];
                
            }
            break;
        }
            
        case Owner_Mobile:
        {
            NSString *phonenumber = [NSString stringWithFormat:@"%@",_item[@"mobile"]];
            NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"tel:%@",phonenumber]];
            if([[UIApplication sharedApplication] canOpenURL:callUrl])
            {
                [[UIApplication sharedApplication] openURL:callUrl];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ALERT" message:@"This function is only available on the iPhone"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
            
            //reference: http://stackoverflow.com/questions/9732043/make-calls-from-iphone-app
        }
            break;
            
        case Show_Map:
        {
            
            NSString *street = _item[@"street"];
            
            NSString *city = _item[@"city"];
            
            NSString *state = _item[@"state"];
            
            NSString *zip = _item[@"zip"];
            
            CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
            
            NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@",street,city,state,zip];
            
            [geoCoder geocodeAddressString:addressString completionHandler:^(NSArray *palcemarks, NSError *error){
                
                if (error) {
                    
                    NSLog(@"Geocode Failed With Error: %@",error);
                    
                    return;
                    
                }
                
                if (palcemarks && palcemarks.count > 0) {
                    
                    CLPlacemark *placemark = palcemarks[0];
                    
                    CLLocation *location = placemark.location;
                    
                    _coords = location.coordinate;
                    
                    
                    
                    NSDictionary *address = @{(NSString *)kABPersonAddressStreetKey:street,
                                              
                                              (NSString *)kABPersonAddressCityKey:city,
                                              
                                              (NSString *)kABPersonAddressStateKey:state,
                                              
                                              (NSString *)kABPersonAddressZIPKey:zip
                                              
                                              };
                    
                    MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:_coords addressDictionary:address];
                    
                    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:place];
                    
                    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving};
                    
                    [mapItem openInMapsWithLaunchOptions:options];
                    
                    
                    
                }
                
            }];
            
        }
            
    }
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
    
}

//To change height of row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == Item_Image){
        
        return (200.0);
    }
    else{
        return 50.0;
    }
}

@end
