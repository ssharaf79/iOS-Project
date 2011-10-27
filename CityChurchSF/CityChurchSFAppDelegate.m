//
//  CityChurchSFAppDelegate.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CityChurchSFAppDelegate.h"
#import "CityHomePage.h"
#import "ServiceLocations.h"
#import "CityChurchMedia.h"
#import "ChurchCalendar.h"
#import "CityHomePage.h"

@implementation CityChurchSFAppDelegate


@synthesize window=_window, splashView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    

    //instantiating the splash screen controller here
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    splashView.image = [UIImage imageNamed:@"Default.png"];
    [window addSubview:splashView];
    [window bringSubviewToFront:splashView];
    
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:2.0];

    
    //here we create the tabbarview controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
	tabBarController.view.frame = CGRectMake(0, 0, 320, 480);
    
    ////////////////////////View Controllers///////////////////
    //creating the view controllers here
    UIViewController *vc1 = [[CityChurchMedia alloc]init];
    UINavigationController *mediaNavController = [[[UINavigationController alloc]initWithRootViewController:vc1]autorelease];
    
    UIViewController *vc_events = [[ChurchCalendar alloc]init];
    UINavigationController *eventsNavController = [[[UINavigationController alloc]initWithRootViewController:vc_events]autorelease];
    
    
    
    
    
    UIViewController *locViewController = [[ServiceLocations alloc]init];
    UINavigationController *locNavController = [[[UINavigationController alloc]initWithRootViewController:locViewController]autorelease];
    
    
    ///////////////////////////////////////////////////////////
    //make an array containing the view controllers
    NSArray *viewControllers = [NSArray arrayWithObjects:mediaNavController,eventsNavController, locNavController, nil];
    
    //add the view controller to the root view controller i.e. tabBar Controller
    [tabBarController setViewControllers:viewControllers];
    
    
    
    
    //
    // Finally, add the tab controller view to the parent view
    //[self.view addSubview:tabBarController.view];
    //since we added the view controllers to NSArray, lets release them
    //[vc1 release];
    [locViewController release];
    //TODO -- see if releasing the nav controllers here is OK ??
    [mediaNavController release];
    [eventsNavController release];
    [locViewController release];
    
    //set tabbar controller as the root view controller of window
    [_window setRootViewController:tabBarController];
    
    //the window is retaining the tabbar controller so we can release it
    [tabBarController release];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)removeSplash;
{
    [splashView removeFromSuperview];
    [splashView release];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    //[splash release];
    [super dealloc];
}

@end
