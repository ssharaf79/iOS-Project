//
//  PlaySermon.h
//  CityChurchSF
//
//  Created by Samuel Sharaf on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface PlaySermon : UIViewController <AVAudioPlayerDelegate, AVAudioSessionDelegate> {
    
    NSDictionary *item;
    AVAudioPlayer *audioPlayer;
  	AVAudioSession *audioSession;
    IBOutlet UILabel *itemTitle;
  	IBOutlet UILabel *itemDate;
  	IBOutlet UIWebView *itemSummary;
    IBOutlet UISlider *volumeControl;
    IBOutlet UIButton *playPauseButton;
    IBOutlet UILabel *alertLabel;
    IBOutlet UIActivityIndicatorView *activityView;
    
    BOOL interruptedOnPlayback;
    BOOL playing;
    
    NSData *sermonFile;
}

@property (retain, nonatomic) NSDictionary *item;
@property (retain, nonatomic) IBOutlet UILabel *itemTitle;
@property (retain, nonatomic) IBOutlet UILabel *itemDate;
@property (retain, nonatomic) IBOutlet UIWebView *itemSummary;
@property (retain, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioSession *audioSession;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (retain, nonatomic) UIButton *playPauseButton;
@property (retain, nonatomic) UILabel *alertLabel;
@property (retain, nonatomic) UISlider *volumeControl;
@property (retain, nonatomic) NSData *sermonFile;
@property (readwrite) BOOL interruptedOnPlayback;
@property (readwrite) BOOL playing;
- (id)initWithItem:(NSDictionary *)theItem;



- (IBAction)volumeDidChange:(id)slider; //handle the slider movement
- (IBAction)togglePlayingState:(id)button; //handle the button tapping

- (void)playAudio; //play the audio
- (void)pauseAudio; //pause the audio
- (void)togglePlayPause; //toggle the state of the audio
    


@end
