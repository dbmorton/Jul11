//
//  Example1AppDelegate.h
//  Example1
//
//  Created by david morton on 7/7/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
@class BigView;

@interface ClassicRockAppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>{
	//AVAudioPlayer *player;
	NSMutableArray *bandAVAudioPlayers;
	
	BigView *viewA;
}

- (void) switchPlayer: (NSInteger) playerNum;


@property (strong, nonatomic) UIWindow *window;
@property NSInteger currentIndex;

@end




