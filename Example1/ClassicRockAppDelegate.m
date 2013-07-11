//
//  Example1AppDelegate.m
//  Example1
//
//  Created by david morton on 7/7/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "ClassicRockAppDelegate.h"
#import "BigView.h"
#import "BandView.h"


@implementation ClassicRockAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
    UIScreen *screen = [UIScreen mainScreen];
    viewA = [[BigView alloc] initWithFrame: screen.applicationFrame];
    self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window addSubview: viewA];
    [self.window makeKeyAndVisible];
	
	//viewA.bandViews;
	bandAVAudioPlayers=[[NSMutableArray alloc] initWithCapacity:[viewA.bandViews count]];
	
	// Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];
	//NSLog(@"bundle.bundelPath == \"%@\"", bundle.bundlePath);
	NSError *error = nil;
	
	//We will create an AVAudioPlayer for each song
	for (NSUInteger i = 0; i < [viewA.bandViews count]; ++i) {
		BandView *thisBandView=[viewA.bandViews objectAtIndex:i];
		NSArray *mp3Breakdown = [thisBandView.bandData.mp3Name componentsSeparatedByString: @"."];
		NSString *filename = [bundle pathForResource: mp3Breakdown[0] ofType: mp3Breakdown[1]];
		NSURL *url = [NSURL fileURLWithPath: filename isDirectory: NO];
		AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
	
		if (player == nil) {
			NSLog(@"could not initialize player:  %@", error);
			return YES;
		}
	
		player.volume = 1.0;		//the default
		player.numberOfLoops = -1;	//negative for infinite loop
		player.delegate = self;
	
		if (![player prepareToPlay]) {
			NSLog(@"prepareToPlay failed");
			return YES;
		}
		[bandAVAudioPlayers addObject: player];
	}
	
	_currentIndex=0;
	[[bandAVAudioPlayers objectAtIndex:_currentIndex] play];
	
	//Because I'm not good at using targets yet :)
	viewA.myDelegate=self;
    return YES;


}

//This is method that is called after band change swipe
- (void) switchPlayer: (NSInteger) playerNum{
	//We use pause and setCurrentTime to start the track back at beginning
	[[bandAVAudioPlayers objectAtIndex:_currentIndex] pause];
	[[bandAVAudioPlayers objectAtIndex:_currentIndex] setCurrentTime:0];
	
	//start newly selected track
	[[bandAVAudioPlayers objectAtIndex:playerNum] play];
	_currentIndex=playerNum;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
