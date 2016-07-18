//
//  FavoriteTVC.m
//  iNeed
//
//  Created by Rohan Murde on 12/11/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "FavoriteTVC.h"

@interface FavoriteTVC ()

@end

@implementation FavoriteTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_favItems count];
}

- (void) viewWillAppear:(BOOL)animated
{
    
    _favItems = [[[NSUserDefaults standardUserDefaults] objectForKey:@"favorites"] mutableCopy];
    //mutableCopy is used because while reordering cells it was throwing an error mutating method sent to immutable object.
    
    //NSLog(@"Value from standardUserDefaults: %@", self.FavArray);
    [self.tableView reloadData];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_favItems objectAtIndex:indexPath.row];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [_favItems removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:_favItems forKey: @"favorites"];
        [self.tableView reloadData];
        [defaults synchronize];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *item = [_favItems objectAtIndex:fromIndexPath.row];
    
    [_favItems removeObject:item];
    
    [_favItems insertObject:item atIndex:toIndexPath.row];
    [defaults setObject:_favItems forKey: @"favorites"];
    [defaults synchronize];

}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedDescription = [[[tableView cellForRowAtIndexPath:indexPath] textLabel]text];
    //NSLog(@"_selectedDescription::::%@",_selectedDescription);
    
    NSString *descriptionURL = [NSString stringWithFormat:@"description=%@",_selectedDescription];
    
    //Using NSURL Session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:@"http://localhost/iNeed_Service2.php"];
    //NSURL * url = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed21/iNeed_Service2.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [descriptionURL dataUsingEncoding:NSUTF8StringEncoding];
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
                                                            //NSLog(@"JSON Array==%@",jsonArray);
                                                            
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                //this block will be executed asynchronously on the main thread bcoz we aren't on the main GUI thread
                                                                
                                                                BorrowFullDetails *borrowVC = [[BorrowFullDetails alloc]initWithStyle:UITableViewStyleGrouped];
                                                                borrowVC.title = @"Item Details";
                                                                borrowVC.borrowFullItemDetails = jsonArray;
                                                                [self.navigationController pushViewController:borrowVC animated:YES];
                                                            });
                                                            
                                                        }
                                                    }];
    [postDataTask resume];

    
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
