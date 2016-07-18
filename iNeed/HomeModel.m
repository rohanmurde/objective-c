//
//  HomeModel.h
//  iNeed
//
//  Created by Rohan Murde on 11/19/14.
//  Copyright (c) 2014 ROHAN. All rights reserved.
//

#import "HomeModel.h"
//Reference: http://codewithchris.com/iphone-app-connect-to-mysql-database/

@interface HomeModel()
{
        NSMutableData *_downloadedData;
}

@end
@implementation HomeModel
-(void)downloadItems{
    //NSURL *jsonFileUrl = [NSURL URLWithString:@"http://people.rit.edu/ram9125/iNeed21/iNeed_Service2.php"];
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://localhost/iNeed_Service2.php"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_fromJSON = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new category object and set its props to JsonElement properties
        Variables * newVars = [[Variables alloc] init];
        newVars.category = jsonElement[@"category"];
        
        
        // Add this question to the locations array
        [_fromJSON addObject:newVars];
        //NSLog(@"JSON Array==%@",jsonArray);
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_fromJSON];
    }
}

@end
