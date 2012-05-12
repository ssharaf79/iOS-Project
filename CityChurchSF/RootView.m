//
//  RootView.m
//  TestApp
//
//  Created by Samuel Sharaf on 10/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootView.h"
#import "ViewOne.h"
#import "ViewTwo.h"
#import "ServiceLocations.h"
#import "CommunityGroup.h"


@implementation RootView

@synthesize showView1, showView2, showView3,showView4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}

-(IBAction)showView1:(id)sender {
    
    //here we instantiate view1 which e.g. can be a tabular view
    ViewOne *view1 = [[ViewOne alloc]initWithStyle:UITableViewStyleGrouped];
    [view1 setTitle:@"City Church Sermons"];
   // NSLog(@"---Do we have a valid nav controller object here: %@", self.navigationController);
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:view1 animated:YES];
    [view1 release];
    
}

-(IBAction)showView2:(id)sender {
    
    //here we instantiate view1 which e.g. can be a tabular view
    ViewTwo *view2 = [[ViewTwo alloc]initWithStyle:UITableViewStyleGrouped];
    [view2 setTitle:@"City Church Events"];
    
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:view2 animated:YES];
    [view2 release];
    
}

-(IBAction)showView3:(id)sender {
    
    //here we instantiate view1 which e.g. can be a tabular view
    ServiceLocations *services = [[ServiceLocations alloc]init];
    [services setTitle:@"City Church Locations"];
    
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:services animated:YES];
    [services release];
    
}

-(IBAction)showView4:(id)sender {
    
    //here we instantiate view1 which e.g. can be a tabular view
    CommunityGroup *commGroup = [[CommunityGroup alloc]init];
    [commGroup setTitle:@"City Church Contacts"];
    //NSLog(@"---Do we have a valid nav controller object here: %@", self.navigationController);
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:commGroup animated:YES];
    [commGroup release];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

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
