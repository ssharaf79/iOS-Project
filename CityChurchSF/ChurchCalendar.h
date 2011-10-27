//
//  ChurchCalendar.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChurchCalendar : UITableViewController {
    //////////////
    UIActivityIndicatorView *activityView;
    NSArray *items;
    
    //////////////
}

@property (retain, nonatomic)UIActivityIndicatorView *activityView;
@property (retain, nonatomic)NSArray *items;


@end
