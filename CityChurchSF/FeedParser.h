//
//  FeedParser.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParserDelegate <NSObject>
- (void)receivedItems:(NSArray *)theItems;
@end

@interface FeedParser : NSObject <NSXMLParserDelegate> {
	id _delegate;
	
	NSMutableData *responseData;
	NSMutableArray *items;
	
	NSMutableDictionary *item;
	NSString *currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink, * currentPodcastLink;
}

@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSMutableArray *items;
@property (retain, nonatomic) NSMutableString *currentTitle;
@property (retain, nonatomic) NSMutableString *currentDate;
@property (retain, nonatomic) NSMutableString *currentSummary;
@property (retain, nonatomic) NSMutableString *currentLink;
@property (retain, nonatomic) NSMutableString *currentPodcastLink;

- (void)parseRssFeed:(NSString *)url withDelegate:(id)aDelegate;

- (id)delegate;
- (void)setDelegate:(id)new_delegate;

@end



