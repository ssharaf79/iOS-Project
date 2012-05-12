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
    [locationManager release];
    [annArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
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
                                                                              title:@"CityChurch - Office Loc" subTitle:@"1388 Sutter Street Suite 412."];

    //annArray = [[NSArray alloc]initWithObjects:r_annotation, m_annotation, nil];
    
    [mapView addAnnotation:r_annotation];
    [mapView addAnnotation:o_annotation];
    [mapView addAnnotation:m_annotation];
    
    //
    [r_annotation release];
    [m_annotation release];
    [o_annotation release];
    //
    [mapView sizeToFit];
    //return YES;
    // Do any additional setup after loading the view from its nib.
     
}
///////////////////////////////////
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
