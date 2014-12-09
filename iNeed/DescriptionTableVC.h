//
//  DescriptionTableVC.h
//  iNeed
//
//  Created by Rohan Murde on 11/20/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Variables.h"
#import "HomeModel.h"
#import "CategoryTableVC.h"
#import "BorrowFullDetails.h"

@interface DescriptionTableVC : UITableViewController
{
    NSArray *jsonArray;
}
@property(retain,nonatomic) NSArray *descItem;
@property(strong,nonatomic) NSString *selectedDescription;

@end
