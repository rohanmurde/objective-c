//
//  BorrowFullDetails.h
//  iNeed
//
//  Created by Rohan Murde on 11/24/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>

@interface BorrowFullDetails : UITableViewController<MFMailComposeViewControllerDelegate>

@property(retain,nonatomic) NSArray *borrowFullItemDetails;
@property(retain,nonatomic) NSDictionary *item;
@property (nonatomic,assign) CGFloat imageHeight;
@property(nonatomic,assign) CLLocationCoordinate2D coords;
@property(nonatomic,strong) CLLocationManager *locationManager;

@end
