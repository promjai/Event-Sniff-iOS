//
//  PFLocationViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/21/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

#import "PFMapView.h"
#import "CMMapLauncher.h"

@interface PFLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;
@property (strong, nonatomic) NSMutableArray *arrObjCountry;
@property (strong, nonatomic) NSDictionary *objCountry;
@property (strong, nonatomic) NSMutableArray *arrObjState;
@property (strong, nonatomic) NSDictionary *objState;

@property NSUserDefaults *userOffline;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSString *Country;
@property (strong, nonatomic) NSString *State;

@property (strong, nonatomic) NSString *Country_id;
@property (strong, nonatomic) NSString *State_id;

//Button Tap
- (IBAction)nextTapped:(id)sender;

@end
