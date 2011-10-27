//
//  CityMapAnnotation.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface CityMapAnnotation : NSObject <MKAnnotation>{
    
    @private CLLocationCoordinate2D coordinate; 
    NSString *title; 
    NSString *subtitle; 
}  
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;  
-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle;  

@end