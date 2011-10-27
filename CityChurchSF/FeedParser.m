//
//  FeedParser.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedParser.h"

@implementation FeedParser

@synthesize items, responseData;
@synthesize currentTitle;
@synthesize currentDate;
@synthesize currentSummary;
@synthesize currentLink;
@synthesize currentPodcastLink;

- (void)parseRssFeed:(NSString *)url withDelegate:(id)aDelegate {
	[self setDelegate:aDelegate];
    
	responseData = [[NSMutableData data] retain];
	NSURL *baseURL = [[NSURL URLWithString:url] retain];
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
	
	[[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //here we are receiving data...so to inspect the received data put log statement here
    //NSLog(@"---inside feedParser:didReceiveData: %@", data);
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString * errorString = [NSString stringWithFormat:@"Unable to download xml data (Error code %i )", [error code]];
	
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.items = [[NSMutableArray alloc] init];
	
	NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:responseData];
	
	[rssParser setDelegate:self];
	
	[rssParser parse];
}

#pragma mark rssParser methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
    currentElement = [elementName copy];
	
    if ([elementName isEqualToString:@"item"]) {
        //here we initialize our dictionary and the respective keys which are of NSMutableString type
        item = [[NSMutableDictionary alloc] init];
        self.currentTitle = [[NSMutableString alloc] init];
        self.currentDate = [[NSMutableString alloc] init];
        self.currentSummary = [[NSMutableString alloc] init];
        self.currentLink = [[NSMutableString alloc] init];
		self.currentPodcastLink = [[NSMutableString alloc] init];
    }
	
	// podcast url is an attribute of the element enclosure
	if ([currentElement isEqualToString:@"enclosure"]) {
		[currentPodcastLink appendString:[attributeDict objectForKey:@"url"]];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
    //here we check if we got a particular item - if yes, lets set our discionary with objects
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:self.currentTitle forKey:@"title"];
        [item setObject:self.currentLink forKey:@"link"];
        [item setObject:self.currentSummary forKey:@"summary"];
		[item setObject:self.currentPodcastLink forKey:@"podcastLink"];
		[item setObject:self.currentDate forKey:@"pubDate"];
        NSLog(@"-----Setting self.currentDate to: %@", self.currentDate);
        //Parse date here
		
		////
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];

        ////
        
        
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"]; 
		
        NSLog(@"------------The dateformatter is: %@", dateFormatter);
           
        NSDate *date = [dateFormatter dateFromString:self.currentDate];
            
        NSLog(@"------------The date object is: %@", date);
            
        [item setObject:date forKey:@"date"];
   

       // [item setObject:date forKey:@"date"];  
		
        [items addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([currentElement isEqualToString:@"title"]) {
        //NSLog(@"***the title is: %@", string);
        [self.currentTitle appendString:string];
    } else if ([currentElement isEqualToString:@"link"]) {
        [self.currentLink appendString:string];
    } else if ([currentElement isEqualToString:@"description"]) {
        [self.currentSummary appendString:string];
    } else if ([currentElement isEqualToString:@"pubDate"]) {
		[self.currentDate appendString:string];
        //NSLog(@"******the date before trimming is: %@", string);
		NSCharacterSet* charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@" \n"];
		[self.currentDate setString: [self.currentDate stringByTrimmingCharactersInSet: charsToTrim]];
        //NSLog(@"---the date is: %@", string);
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if ([_delegate respondsToSelector:@selector(receivedItems:)])
        [_delegate receivedItems:items];
    else
    { 
        [NSException raise:NSInternalInconsistencyException
					format:@"Delegate doesn't respond to receivedItems:"];
    }
}

#pragma mark Delegate methods

- (id)delegate {
	return _delegate;
}

- (void)setDelegate:(id)new_delegate {
	_delegate = new_delegate;
}

- (void)dealloc {
	[items release];
	[responseData release];
	[super dealloc];
}
@end
