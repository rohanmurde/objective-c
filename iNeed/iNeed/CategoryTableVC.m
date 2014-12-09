//
//  CategoryTableVC.m
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "CategoryTableVC.h"

@interface CategoryTableVC ()
{
    NSMutableData *_downloadedData1;
}
@end

@implementation CategoryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _feedItem = [[NSArray alloc]init];
    _homeModel = [[HomeModel alloc]init];
    _homeModel.delegate =self;
    [_homeModel downloadItems];
}

-(void)viewWillAppear:(BOOL)animated{
    [_homeModel downloadItems];
    
}

-(void)itemsDownloaded:(NSArray *)items{
    _feedItem = items;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_feedItem count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    // Get the variable to be shown
    Variables *item = _feedItem[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = item.category;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedCategory = [[[tableView cellForRowAtIndexPath:indexPath] textLabel]text];
    //NSLog(@"_selectedCategory::::%@",_selectedCategory);
    
    NSString *categoryURL = [NSString stringWithFormat:@"category=%@",_selectedCategory];
       
    //Using NSURL Session
    NSURLSession *session = [NSURLSession sharedSession];
    //NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service2.php"];
    NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed20/iNeed_Service2.php"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [categoryURL dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if(error==nil){
                                                                NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                //NSLog(@"ResponseData = %@",responseData);
                                                                
                                                                NSMutableData *mutData = (NSMutableData *)[responseData dataUsingEncoding:NSUTF8StringEncoding];
                                                                
                                                                //NSLog(@"mutData==%@",mutData);
                                                                           
                                                                NSError *error;
                                                                jsonArray = [NSJSONSerialization JSONObjectWithData:mutData options:NSJSONReadingAllowFragments error:&error];
                                                                NSLog(@"JSON Array==%@",jsonArray);
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    //this block will be executed asynchronously on the main thread bcoz we aren't on the main GUI thread
                                                                    
                                                                    DescriptionTableVC *desTVC = [[DescriptionTableVC alloc]init];
                                                                    desTVC.title = @"Descriptions";
                                                                    desTVC.descItem = jsonArray;
                                                                    
                                                                    [self.navigationController pushViewController:desTVC animated:YES];
                                                                });

                                                            }
    }];
    [postDataTask resume];
    
    
}





@end
