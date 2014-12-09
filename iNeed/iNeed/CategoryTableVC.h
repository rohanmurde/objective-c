//
//  CategoryTableVC.h
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "Variables.h"
#import "DescriptionTableVC.h"

@interface CategoryTableVC : UITableViewController<HomeModelProtocol, NSURLConnectionDataDelegate>
{
    HomeModel *_homeModel;
    NSArray *_feedItem;
    NSArray *jsonArray;
    Variables *_selectedVar;
}

@property(strong,nonatomic) NSString *selectedCategory;
@property(strong,nonatomic) NSMutableArray *data;
@property (nonatomic, weak) id<HomeModelProtocol>
delegate;
//- (void)downloadItemsSelectedCategoryList;

@end
