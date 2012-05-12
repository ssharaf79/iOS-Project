//
//  ViewTwo.m
//  TestApp
//
//  Created by Samuel Sharaf on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewTwo.h"
#import "FeedParser.h"
#import "ChurchBlog.h"

@implementation ViewTwo
@synthesize items, activityView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    // Do any additional setup after loading the view from its nib.
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] 
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = YES;
    [indicator stopAnimating];
    self.activityView = indicator;
    [indicator release];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    
    [self.navigationController setNavigationBarHidden:NO]; 

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

/////-----/////
///////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
    //NSLog(@"Inside View did appear, calling loadData");
  	[self loadData];
    [super viewDidAppear:animated];
}

- (void)loadData {
  	if (items == nil) {
  		[activityView startAnimating];
        
  		FeedParser *rssParser = [[FeedParser alloc] init];
        
        NSLog(@"Inside load Data %@", rssParser);
        [rssParser parseRssFeed:@"http://feeds.feedburner.com/ccsfnews" withDelegate:self];
        
  		[rssParser release];
        
        
        
        
        
  	} else {
        
  		[self.tableView reloadData];
  	}
    
}

- (void)receivedItems:(NSArray *)theItems {
  	items = theItems;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"date" ascending: NO];
    [items sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    [sortDescriptor release];
    
    
  	[self.tableView reloadData];
  	[activityView stopAnimating];
}


///////////////////////////////////////////////////


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)dealloc {
    [activityView release];
    [items release];
}

#pragma mark - Table view data source



////////////////
/*
 * UITableView Controller methods to load and populate the table
 */
////////////////
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
  	// Configure the cell.
    
  	cell.textLabel.text = [[items objectAtIndex:indexPath.row] objectForKey:@"title"];
    
  	// Format date
  	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
  	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
  	//cell.detailTextLabel.text = [[items objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
  	cell.detailTextLabel.text = [dateFormatter stringFromDate:[[items objectAtIndex:indexPath.row] objectForKey:@"date"]];  
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"selected row on the table: %@", indexPath);
    NSDictionary *theItem = [items objectAtIndex:indexPath.row];
    ChurchBlog *nextController = [[ChurchBlog alloc] initWithItem:theItem];
    
    //NSLog(@"NavigationController object is %@", self.navigationController);
    
    [[self navigationController] pushViewController:nextController animated:YES];
    
    [nextController release];}


////-----//////

@end
