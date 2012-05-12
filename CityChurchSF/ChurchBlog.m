//
//  ChurchBlog.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 12/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChurchBlog.h"

@implementation ChurchBlog
@synthesize item,itemDate,itemTitle,itemSummary;

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
    [item release];
  	[itemTitle release];
  	[itemDate release];
  	[itemSummary release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithItem:(NSDictionary *)theItem {
  	if (self = [super initWithNibName:@"ChurchBlog" bundle:nil]) {
  		self.item = theItem;
  		self.title = [item objectForKey:@"title"];
  	}
    
  	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
  	self.itemTitle.text = [item objectForKey:@"title"];
    
  	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
  	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
  	self.itemDate.text = [dateFormatter stringFromDate:[item objectForKey:@"date"]];
    
  	[self.itemSummary loadHTMLString:[item objectForKey:@"summary"] baseURL:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [itemSummary release];
    itemSummary = nil;
    
    [super viewDidUnload];
}
@end
