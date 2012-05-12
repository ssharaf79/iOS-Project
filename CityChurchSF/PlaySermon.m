//
//  PlaySermon.m
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaySermon.h"

#pragma mark Audio session callbacks_______________________

// Audio session callback function for responding to audio route changes. If playing 
//		back application audio when the headset is unplugged, this callback pauses 
//		playback and displays an alert that allows the user to resume or stop playback.
//
//		The system takes care of iPod audio pausing during route changes--this callback  
//		is not involved with pausing playback of iPod audio.
void audioRouteChangeListenerCallback (
                                       void                      *inUserData,
                                       AudioSessionPropertyID    inPropertyID,
                                       UInt32                    inPropertyValueSize,
                                       const void                *inPropertyValue
                                       ) {
	
	// ensure that this callback was invoked for a route change
	if (inPropertyID != kAudioSessionProperty_AudioRouteChange) return;
    
	// This callback, being outside the implementation block, needs a reference to the
	//		MainViewController object, which it receives in the inUserData parameter.
	//		You provide this reference when registering this callback (see the call to 
	//		AudioSessionAddPropertyListener).
	PlaySermon *controller = (PlaySermon *) inUserData;
	
	// if application sound is not playing, there's nothing to do, so return.
	if (controller.audioPlayer.playing == 0 ) {
        
		NSLog (@"Audio route change while application audio is stopped.");
		return;
		
	} else {
        
		// Determines the reason for the route change, to ensure that it is not
		//		because of a category change.
		CFDictionaryRef	routeChangeDictionary = inPropertyValue;
		
		CFNumberRef routeChangeReasonRef =
        CFDictionaryGetValue (
                              routeChangeDictionary,
                              CFSTR (kAudioSession_AudioRouteChangeKey_Reason)
                              );
        
		SInt32 routeChangeReason;
		
		CFNumberGetValue (
                          routeChangeReasonRef,
                          kCFNumberSInt32Type,
                          &routeChangeReason
                          );
		
		// "Old device unavailable" indicates that a headset was unplugged, or that the
		//	device was removed from a dock connector that supports audio output. This is
		//	the recommended test for when to pause audio.
		if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {
            
			[controller.audioPlayer pause];
			NSLog (@"Output device removed, so application audio was paused.");
            
			UIAlertView *routeChangeAlertView = 
            [[UIAlertView alloc]	initWithTitle: NSLocalizedString (@"Playback Paused", @"Title for audio hardware route-changed alert view")
                                       message: NSLocalizedString (@"Audio output was changed", @"Explanation for route-changed alert view")
                                      delegate: controller
                             cancelButtonTitle: NSLocalizedString (@"StopPlaybackAfterRouteChange", @"Stop button title")
                             otherButtonTitles: NSLocalizedString (@"ResumePlaybackAfterRouteChange", @"Play button title"), nil];
			[routeChangeAlertView show];
			// release takes place in alertView:clickedButtonAtIndex: method
            
		} else {
            
			NSLog (@"A route change occurred that does not require pausing of application audio.");
		}
	}
}

@implementation PlaySermon

@synthesize item, sermonFile, itemDate, itemTitle, itemSummary, audioPlayer, activityView, playPauseButton,volumeControl, alertLabel, interruptedOnPlayback, playing, audioSession;

- (void)viewDidLoad {
    [super viewDidLoad];
    
  	self.itemTitle.text = [item objectForKey:@"title"];
    
    ////////////////////////
  	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
  	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
  	self.itemDate.text = [dateFormatter stringFromDate:[item objectForKey:@"date"]];
    
  	[self.itemSummary loadHTMLString:[item objectForKey:@"summary"] baseURL:nil];
    ////////////////////////
    self.audioSession = [AVAudioSession sharedInstance];
    self.audioSession.delegate = self;
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.audioSession setActive:YES error:nil];
    
    /*UInt32 doSetProperty = 0;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
    
    // Registers the audio route change listener callback function
	AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, audioRouteChangeListenerCallback, self);
    
	// Activates the audio session
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive:YES error: &activationError];*/

    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self loadSermonFile];
    [self playPodCast];
}

- (void)loadSermonFile {
 
    NSURL *url = [NSURL URLWithString:[item objectForKey:@"podcastLink"]]; 
    sermonFile = [NSData dataWithContentsOfURL:url]; 
    
    [activityView stopAnimating];
}

- (void)playPodCast {
       
        
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask, YES) objectAtIndex:0] 
                          stringByAppendingPathComponent:@"sound.caf"];
   
    [sermonFile writeToFile:filePath atomically:YES];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];  
    if(audioPlayer)
    {
        [audioPlayer setNumberOfLoops:0];
    
        [[self playPauseButton]setEnabled:YES];
        OSStatus result = AudioSessionInitialize(NULL, NULL, NULL, NULL);
        if (result == 0) {
            NSLog(@"Failed to initialize the audio session");
        }

        [audioPlayer prepareToPlay];
        [audioPlayer setDelegate:self];
        [audioPlayer  play];
        
    }
    
    
}

- (void)pauseAudio {
    //Pause the audio and set the button to represent the audio is paused
    [audioPlayer pause];
    [playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
}

- (void)togglePlayPause {
    if (audioPlayer.playing) {
        [self pauseAudio];
    } 
    else if(!audioPlayer.playing) {
        [self playAudio];
    }
}
- (void)playAudio {
    //Play the audio and set the button to represent the audio is playing
    [audioPlayer play];
    [playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
}

- (IBAction)volumeDidChange:(UISlider *)slider {
    //Handle the slider movement
    [audioPlayer setVolume:[slider value]];
}

- (IBAction)togglePlayingState:(id)button {
    //Handle the button pressing
    [self togglePlayPause];
}


#pragma mark - View lifecycle
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    [self.audioSession setActive:NO error:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark AV Foundation delegate methods____________

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) appSoundPlayer successfully: (BOOL) flag {
    
	playing = NO;
	//[appSoundButton setEnabled: YES];
}

-(void) audioPlayerBeginInterruption: player {
    
	NSLog (@"Interrupted. The system has paused audio playback.");
	
	if (playing) {
        
		playing = NO;
		interruptedOnPlayback = YES;
	}
}

- (void) audioPlayerEndInterruption: player {
    
	NSLog (@"Interruption ended. Resuming audio playback.");
	
	// Reactivates the audio session, whether or not audio was playing
	//		when the interruption arrived.
	[[AVAudioSession sharedInstance] setActive: YES error: nil];
	
	if (interruptedOnPlayback) {
        
		[audioPlayer prepareToPlay];
		[audioPlayer play];
		playing = YES;
		interruptedOnPlayback = NO;
	}
}


- (void)dealloc
{
    [item release];
  	[itemTitle release];
  	[itemDate release];
  	[itemSummary release];
    self.playPauseButton = nil;
    self.volumeControl = nil;
    self.alertLabel = nil;
    self.audioPlayer = nil;
    [activityView release];
    [playPauseButton release];
    [volumeControl release];
    [alertLabel release];
    [audioPlayer release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithItem:(NSDictionary *)theItem {
  	if (self = [super initWithNibName:@"PlaySermon" bundle:nil]) {
  		self.item = theItem;
  		self.title = [item objectForKey:@"title"];
  	}
    
  	return self;
}





@end
