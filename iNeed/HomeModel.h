//
//  HomeModel.h
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Variables.h"

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<HomeModelProtocol>
delegate;
- (void)downloadItems;

@end
