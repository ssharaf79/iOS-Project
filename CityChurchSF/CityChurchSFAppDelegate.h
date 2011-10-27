//
//  CityChurchSFAppDelegate.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CityChurchSFAppDelegate : NSObject <UIApplicationDelegate> {

    UIImageView *splashView;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(retain, nonatomic)UIImageView *splashView;

@end
