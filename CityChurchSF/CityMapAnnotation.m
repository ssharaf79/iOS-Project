//
//  CityMapAnnotation.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityMapAnnotation.h"


@implementation CityMapAnnotation

@synthesize coordinate, title, subtitle;

-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle
{  
    self = [super init];  
    if (self != nil) { 
        coordinate = paramCoordinates; 
        title = [paramTitle copy]; 
        subtitle = [paramSubTitle copy]; 
    }  
    return(self);  
}  
-init
{
    return self;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
    coordinate = inCoord;
    return self;
}

-(void) dealloc 
{ 
    [title release]; 
    [subtitle release]; 
    [super dealloc]; }

@end
