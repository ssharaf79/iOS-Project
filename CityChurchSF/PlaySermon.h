//
//  PlaySermon.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaySermon : UIViewController {
    
    NSDictionary *item;
  	IBOutlet UILabel *itemTitle;
  	IBOutlet UILabel *itemDate;
  	IBOutlet UIWebView *itemSummary;
}

@property (retain, nonatomic) NSDictionary *item;
@property (retain, nonatomic) IBOutlet UILabel *itemTitle;
@property (retain, nonatomic) IBOutlet UILabel *itemDate;
@property (retain, nonatomic) IBOutlet UIWebView *itemSummary;

- (id)initWithItem:(NSDictionary *)theItem;

- (IBAction)playPodcast:(id)sender;
    


@end
