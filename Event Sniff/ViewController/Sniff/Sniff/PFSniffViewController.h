//
//  PFSniffViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

#import "PFMapView.h"
#import "CMMapLauncher.h"

@interface PFSniffViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) IBOutlet PFMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

- (IBAction)resetTapped:(id)sender;
- (IBAction)sniffhereTapped:(id)sender;

@end
