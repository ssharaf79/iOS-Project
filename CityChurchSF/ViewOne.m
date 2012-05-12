//
//  ViewOne.m
//  TestApp
//
//  Created by Samuel Sharaf on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewOne.h"
#import "FeedParser.h"
#import "PlaySermon.h"
@implementation ViewOne
@synthesize items, activityView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        
       // NSLog(@"Inside load Data %@", rssParser);
        [rssParser parseRssFeed:@"http://feeds.feedburner.com/Citychurchsf" withDelegate:self];
        
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc 
{
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
    
        
    NSDictionary *theItem = [items objectAtIndex:indexPath.row];
    
    PlaySermon *pController = [[PlaySermon alloc] initWithItem:theItem];
    //avTouchViewController pController = [[avTouchViewController alloc]init];
    [[self navigationController] pushViewController:pController animated:YES];
    
    [pController release];
}

@end
