//
//  ViewController.h
//  Parent App
//
//  Created by shu ghosh on 4/16/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIDText;
@property (weak, nonatomic) IBOutlet UITextField *latitudeText;
@property (weak, nonatomic) IBOutlet UITextField *longitudeText;
@property (weak, nonatomic) IBOutlet UITextField *radiusText;
@property (weak, nonatomic) IBOutlet UILabel *childStatus;


@property NSString *userID;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *radius;



- (IBAction)saveButton:(id)sender;
- (IBAction)getStatus:(id)sender;


@end
