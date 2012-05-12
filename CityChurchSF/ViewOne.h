//
//  ViewOne.h
//  TestApp
//
//  Created by Samuel Sharaf on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOne : UITableViewController {
    //////////////
    UIActivityIndicatorView *activityView;
    NSArray *items;
    
    //////////////
}

@property (retain, nonatomic)UIActivityIndicatorView *activityView;
@property (retain, nonatomic)NSArray *items;


@end
