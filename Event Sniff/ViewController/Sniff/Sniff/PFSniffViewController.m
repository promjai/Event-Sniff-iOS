//
//  PFSniffViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFSniffViewController.h"

@interface PFSniffViewController ()

@end

@implementation PFSniffViewController

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"PFSniffViewController";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.canShowCallout = YES;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(getDistance) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = rightButton;
    
    /*
     UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_location.png"]];
     annotationView.leftCalloutAccessoryView = myCustomImage;
     */
    if (annotation == self.mapView.userLocation) {
        return nil;
    } else {
        annotationView.image = [UIImage imageNamed:@"pin_map.png"];
    }
    //add any image which you want to show on map instead of red pins
    annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Sniff";
    
    [self startMap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)startMap {
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    CLLocationCoordinate2D mylocation;
    mylocation.latitude = [latitude doubleValue];
    mylocation.longitude = [longitude doubleValue];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = mylocation;
    //point.title = @"ที่อยู่ของคุณ";
    
    [self.mapView addAnnotation:point];
    [self.mapView selectAnnotation:point animated:NO];
    [self.mapView setCenterCoordinate:mylocation zoomLevel:13 animated:NO];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
}

- (CLLocationCoordinate2D) getLocation{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

- (void)getDistance {

    
}

/* Reset Tap */

- (IBAction)resetTapped:(id)sender {
    
    [self startMap];
    
}

/* Sniff Here Tap */

- (IBAction)sniffhereTapped:(id)sender {

    //Calculate the corners of the map to get the points
    CGPoint nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.mapView.bounds.origin.x),(self.mapView.bounds.origin.y+ self.mapView.bounds.size.height));
    
    //Transform points into lat/long values
    CLLocationCoordinate2D NECoordinate = [self.mapView convertPoint:nePoint toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D SWCoordinate = [self.mapView convertPoint:swPoint toCoordinateFromView:self.mapView];
    
    NSLog(@"SWCoordinate %f , %f",SWCoordinate.latitude,SWCoordinate.longitude);
    NSLog(@"NECoordinate %f , %f",NECoordinate.latitude,NECoordinate.longitude);

}

@end
