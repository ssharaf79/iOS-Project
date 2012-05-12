//
//  RootView.h
//  TestApp
//
//  Created by Samuel Sharaf on 10/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIViewController
{

    IBOutlet UIButton *showView1;

    IBOutlet UIButton *showView2;

    IBOutlet UIButton *showView3;
    
    IBOutlet UIButton *showView4;
}
@property(nonatomic, retain)IBOutlet UIButton *showView1;
@property(nonatomic, retain)IBOutlet UIButton *showView2;
@property(nonatomic, retain)IBOutlet UIButton *showView3;
@property(nonatomic, retain)IBOutlet UIButton *showView4;

-(IBAction)showView1:(id)sender;
-(IBAction)showView2:(id)sender;
-(IBAction)showView3:(id)sender;
-(IBAction)showView4:(id)sender;

@end
