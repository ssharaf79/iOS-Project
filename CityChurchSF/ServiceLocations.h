//
//  ServiceLocations.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface ServiceLocations : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    CLLocationManager *locationManager;
    NSMutableArray *annArray;
    
    //iboutlets
    IBOutlet MKMapView *mapView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
}
@end
