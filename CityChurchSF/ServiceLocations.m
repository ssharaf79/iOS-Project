//
//  ServiceLocations.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServiceLocations.h"
#import "CityMapAnnotation.h"



@implementation ServiceLocations

-(id)init 
{
    [super initWithNibName:nil bundle:nil];
    UITabBarItem *tbi = [self tabBarItem];
    [tbi setTitle:@"Locations"];
    UIImage *image = [UIImage imageNamed:@"world.png"];
    [tbi setImage:image];
    
    return self;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
/**
 *The visible area of a MKMapView is described using MKCoordinateRegion, which consists of two values:
 
 center (the center point of the region), and
 span (the size of the visible area around center).
 
 The center point should be obvious (it's the center point of the region.)
 
 However, span (which is a MKCoordinateSpan) consists of:
 
 latitudeDelta (the vertical distance represented by the region), and
 longitudeDelta (the horizontal distance represented by the region).
 
 A brief example. Here's a toy MKCoordinateRegion:
 
 center:
 latitude: 0
 longitude: 0
 span:
 latitudeDelta: 8
 longitudeDelta: 6
 
 The region could be described using its min and max coordinates as follows:
 
 min coordinate (lower left-hand point):
 latitude: -4
 longitude: -3
 max coordinate (upper right-hand point):
 latitude: 4
 longitude: 3
 
 So, you can specify zoom levels around a center point by using an appropriately sized MKCoordinateSpan. 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView.delegate = self;

    //initializing the location manager
    locationManager = [[CLLocationManager alloc]init];
    
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    
    //set the ctr of the map
    CLLocationCoordinate2D mapCtr = {.latitude =  37.773927, .longitude = -122.419983};
    MKCoordinateSpan mapspan = {.latitudeDelta =  0.1, .longitudeDelta =  0.1};
    MKCoordinateRegion ctrRegion = {mapCtr, mapspan};

       //setting location of russian ctr location!
    CLLocationCoordinate2D rcoord = {.latitude =  37.7851972222222, .longitude = -122.440936111111};
    //MKCoordinateSpan rspan = {.latitudeDelta =  0.9, .longitudeDelta =  0.9};
    //MKCoordinateRegion region = {rcoord, rspan};
    //ctr of the church office
    CLLocationCoordinate2D o_coord = {.latitude=37.787383, .longitude = -122.42465};
    
    //setting location of mission ctr location
    CLLocationCoordinate2D mcoord = {.latitude =  37.753678, .longitude = -122.420114};
    //MKCoordinateSpan m_span = {.latitudeDelta =  0.9, .longitudeDelta =  0.9};
    //MKCoordinateRegion m_region = {mcoord, m_span};
    
    
    //[mapView setRegion:m_region];
    [mapView setRegion:ctrRegion];
    
    
    CityMapAnnotation *r_annotation = [[CityMapAnnotation alloc]initWithCoordinates:rcoord 
                                                                           title:@"CityChurch - Russian Ctr" subTitle:@"2460 Sutter St."];

    CityMapAnnotation *m_annotation = [[CityMapAnnotation alloc]initWithCoordinates:mcoord 
                                                                            title:@"CityChurch - Mission Loc" subTitle:@"3351 23rd St."];
    
    CityMapAnnotation *o_annotation = [[CityMapAnnotation alloc]initWithCoordinates:o_coord 
                                                                              title:@"CityChurch - Office Loc" subTitle:@"1480 Franklin St."];

    //annArray = [[NSArray alloc]initWithObjects:r_annotation, m_annotation, nil];
    
    [mapView addAnnotation:r_annotation];
    [mapView addAnnotation:o_annotation];
    [mapView addAnnotation:m_annotation];
    
    [mapView sizeToFit];
    //return YES;
    // Do any additional setup after loading the view from its nib.
     
}
///////////////////////////////////
/*
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation 
{
    MKPinAnnotationView *pinView = nil;
    
    if(annotation != mapView.userLocation) 
    {
        static NSString *defaultID = @"russianctr";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultID];
        
        if(pinView == nil) 
        {
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:defaultID];
        }
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.pinColor = MKPinAnnotationColorGreen;
    }
}

-(void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 250);
    //[mv setRegion:region animated:YES];
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
