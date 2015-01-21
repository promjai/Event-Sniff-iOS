//
//  PFMapView.h
//  CaspuleEngine
//
//  Created by issrapong wongyai on 3/18/56 BE.
//  Copyright (c) 2556 issrapong wongyai. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface PFMapView : MKMapView
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
