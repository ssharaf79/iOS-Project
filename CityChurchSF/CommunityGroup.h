//
//  CommunityGroup.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 12/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityGroup : UIViewController<UIWebViewDelegate> {
    
    IBOutlet UIWebView *commView;
}
@property(nonatomic, retain)UIWebView *commView;

@end
