//
//  CityChurchMedia.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


@interface CityChurchMedia : UITableViewController {
    
        
    //////////////
    UIActivityIndicatorView *activityView;
    NSArray *items;
    
    //////////////
}

@property (retain, nonatomic)UIActivityIndicatorView *activityView;
@property (retain, nonatomic)NSArray *items;



@end
