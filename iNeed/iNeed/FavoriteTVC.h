//
//  FavoriteTVC.h
//  iNeed
//
//  Created by Rohan Murde on 12/11/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorrowFullDetails.h"

@interface FavoriteTVC : UITableViewController{
    NSArray *jsonArray;
}

@property (strong,nonatomic) NSMutableArray *favItems;
@property(strong,nonatomic) NSString *selectedDescription;

@end
