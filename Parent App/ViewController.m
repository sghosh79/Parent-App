//
//  ViewController.m
//  Parent App
//
//  Created by shu ghosh on 4/16/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

NSMutableData *_responseData;


- (BOOL)textFieldShouldReturn:(UITextField *)textfld {
    NSLog(@"text is : %@",self.userIDText.text);
    NSLog(@"text is : %@",self.longitudeText.text);
    NSLog(@"text is : %@",self.radiusText.text);
    NSLog(@"text is : %@",self.latitudeText.text);

    [textfld resignFirstResponder];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveButton:(id)sender {
    self.userID = self.userIDText.text;
    self.longitude = self.longitudeText.text;
    self.latitude = self.latitudeText.text;
    self.radius = self.radiusText.text;
    
    //write in dictionary, then convert json, then post
    

      
    NSDictionary *userDetails =
  @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",@"user":@{@"username":self.userID,@"latitude":self.latitude,@"longitude":self.longitude,@"radius":self.radius},@"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
                                             
    //label to the left of the colon and argument to the right is getting passed
                                             
    //datawithJSONObject - is where I put the dictionary to convert to JSON
    
      NSError *error;
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:&error];
                                             
    if (! jsonData) {
          NSLog(@"Got an error: %@", error);
      } else {
          NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
          
       //   NSDictionary *userDetails = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

          NSLog(@"json: %@", jsonString);
          
          //ASYNCHRONOUS POST
          NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"URL"]];
          
          // Specify that it will be a POST request
          request.HTTPMethod = @"POST";
          
          // This is how we set header fields
          [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
          
          // Convert your data and set your request's HTTPBody property
     
          request.HTTPBody = jsonData;
          
          // Create url connection and fire request
          NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
          [conn start];
      }
}


-(void)updateChild
{
    NSString *urlString = [NSString stringWithFormat:@"URL", self.userID];
    
    NSMutableURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLConnection *conn1 = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    
    [conn1 start];
    
}


- (IBAction)getStatus:(id)sender {

    
    _responseData = [[NSMutableData alloc] init];
    [self setUserID: self.userIDText.text];
    [self updateChild];
    
}




#pragma mark NSURLConnection Delegate Methods
    
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
        // A response has been received, this is where we initialize the instance var you created
        // so that we can append data to it in the didReceiveData method
        // Furthermore, this method is called each time there is a redirect so reinitializing it
        // also serves to clear it
    
        
}
    
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
        // Append the new data to the instance variable you declared
        [_responseData appendData:data]; //
//        imageviewer.image = [UIImage imageWithData:_responseData]; //received data and appended to response data for viewing
       
        
}




- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
        // The request is complete and data has been received
        // You can parse the stuff in your instance variable now
        
        NSError* error;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error];
    
        NSString *receivedResponse = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"is_in_zone"]];
    
    
    
        if ([receivedResponse isEqualToString: @"1"]) //double check this, not working
            self.childStatus.text = @"is in zone";
        else
            self.childStatus.text = @"is not in zone";
    
    NSLog (@"printifcalled");
}
    
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        // The request has failed for some reason!
        // Check the error var
    }

@end
