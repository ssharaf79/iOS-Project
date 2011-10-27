//
//  CityChurchMedia.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityChurchMedia.h"
#import "FeedParser.h"
#import "PlaySermon.h"
#import "ServiceLocations.h"
#import "ChurchCalendar.h"


@implementation CityChurchMedia

@synthesize activityView, items;

-(id)init 
{
    //so basically here we need to get hold of the window or view object and add the tab bar controller to it
    
    
    
    
    [super initWithNibName:nil bundle:nil];
    UITabBarItem *tbi = [self tabBarItem];
    [tbi setTitle:@"PodCasts"];
    UIImage *image = [UIImage imageNamed:@"speaker.png"];
    [tbi setImage:image];
    
    [[self navigationItem]setTitle:@"City Church Sermons"];
    
    return self;
    
}
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
    [activityView release];
    //[activityView nil];
    [items release];
    //[items nil];
    [super dealloc];
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
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] 
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = YES;
    [indicator stopAnimating];
    self.activityView = indicator;
    [indicator release];
        
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    

}

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




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
 	 
      PlaySermon *nextController = [[PlaySermon alloc] initWithItem:theItem];
      
      //NSLog(@"NavigationController object is %@", self.navigationController);
 	 
      [[self navigationController] pushViewController:nextController animated:YES];
 	 
      //[nextController release];
  }

            


@end
