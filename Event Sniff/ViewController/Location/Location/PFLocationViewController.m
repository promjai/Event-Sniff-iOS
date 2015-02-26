//
//  PFLocationViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/21/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFLocationViewController.h"

@interface PFLocationViewController ()

@end

@implementation PFLocationViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userOffline = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* Label */
    [self setLabel];
    
    /* Button */
    [self setButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/* Location API */

- (void)PFApi:(id)sender getLocationResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
        
        if ([[[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"name"] lowercaseString] isEqualToString:self.Country]) {
            
            self.Country_id = [[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"];
            [self.Api getCity:[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"]];
        
        }
        
    }
    
}

- (void)PFApi:(id)sender getLocationErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* City API */

- (void)PFApi:(id)sender getCityResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
        
        if ([[[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"name"] lowercaseString] isEqualToString:self.State]) {
            
            self.State_id = [[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"id"];
            NSLog(@"%@",self.Country_id);
            NSLog(@"%@",self.State_id);
            
            //check user id
            if ([[self.Api getUserId] length] == 0) {
            
                [self.Api registerNoneuser];
                
            } else {
            
                [self.Api userLocation:self.Country_id city:self.State_id];
            
            }
            
        }
        
    }
    
}

- (void)PFApi:(id)sender getCityErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* Register Noneuser API */

- (void)PFApi:(id)sender registerNoneuserResponse:(NSDictionary *)response {
    NSLog(@"registerNoneuser %@",response);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[response objectForKey:@"type"] forKey:@"type"];
    [defaults setObject:[response objectForKey:@"access_token"] forKey:@"access_token"];
    [defaults setObject:[response objectForKey:@"user_id"] forKey:@"user_id"];
    [defaults synchronize];
    [self.Api userLocation:self.Country_id city:self.State_id];
    
}

- (void)PFApi:(id)sender registerNoneuserErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* User Location API */

- (void)PFApi:(id)sender userLocationResponse:(NSDictionary *)response {
    NSLog(@"userLocation %@",response);
}

- (void)PFApi:(id)sender userLocationErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* Label */

- (void)setLabel {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.whereLabel.text = @"Where are you?";
        self.startLabel.text = @"Start Event Sniff";
        self.serviceLabel.text = @"by allow location service.";
        
    } else {
        
        self.whereLabel.text = @"คุณอยู่ที่ไหน?";
        self.startLabel.text = @"เริ่มต้นใช้งาน Event Sniff";
        self.serviceLabel.text = @"โดยเปิดใช้งาน บริการค้นหาตำแหน่งที่ตั้ง";
        
    }
    
}

/* Button */

- (void)setButton {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
    
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        
    } else {
        
        [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
        
    }
    
    [self.nextButton.layer setMasksToBounds:YES];
    [self.nextButton.layer setCornerRadius:5.0f];
    
}

/* Next Tap */

- (IBAction)nextTapped:(id)sender {

    if([CLLocationManager locationServicesEnabled]){
        
        CLGeocoder *ceo = [[CLGeocoder alloc]init];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:18.6949921 longitude:98.7897701];
        
        [ceo reverseGeocodeLocation:loc
                  completionHandler:^(NSArray *placemarks, NSError *error) {
                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
                      
                      self.Country = [[placemark.addressDictionary objectForKey:@"Country"] lowercaseString];
                      self.State = [[placemark.addressDictionary objectForKey:@"State"] lowercaseString];
                  }
         ];
        
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            
            if (![[self.Api getLanguage] isEqualToString:@"th"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Event Sniff Would Like to Use Your Current Location"
                                                               delegate:self
                                                      cancelButtonTitle:@"Not Now"
                                                      otherButtonTitles:@"Allow",nil];
                [alert show];
                
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Event Sniff Would Like to Use Your Current Location"
                                                               delegate:self
                                                      cancelButtonTitle:@"ไม่ยินยอม"
                                                      otherButtonTitles:@"ยินยอม",nil];
                [alert show];
            
            }
            
        }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        
        NSLog(@"Not Now");
        [self dismissModalViewControllerAnimated:YES];
        
    } else if (buttonIndex == 1) {
        
        [self.Api getLocation];
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    
    }
}

@end
