//
//  ViewA.m
//  Example1
//
//  Created by david morton on 7/7/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "BigView.h"
#import "BandData.h"
#import "BandView.h"

@implementation BigView

- (id)initWithFrame:(CGRect)frame
{
	//NSLog(@"initWithFrame");
    self = [super initWithFrame: frame];
    if (self) {
		//We will create array of band data as specified in info.txt
		//Will start with first in array
		_index=0;
		
		//Note: When clearColor, touchesBegan is not called
        //self.backgroundColor = [UIColor clearColor];
		self.backgroundColor = [UIColor redColor];
			
		//Initialize Array for all band views
		_bandViews=[[NSMutableArray alloc] init];
		
		//Loading in Data 
		
		//Error Holder
		NSError *error = nil;
		
		//info.txt stores all the necessary information
		//<band name>,<band pic>,<Example Song Name>,<audio file>,<bio file>
		//ie. Led Zepplin,led.png,Stairway To Heaven,sth.mp3,led.txt
		NSString *path = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"txt"];
		NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
		
		//how do i get this to work?
		//NSString *content=[getContents @"info.txt"];
		NSArray *b =[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
		
		//what should i have used for NSUInteger?
		//NSLog(@"[b count]=%u",[b count]);
		
		if(error) NSLog(@"ERROR while loading from file: %@", error);
		else{
			//NSLog(@"%@",content);
			
			for (NSUInteger j = 0; j < [b count]; ++j) {
				 NSArray* foo = [b[j] componentsSeparatedByString: @","];
				//Format of File is: name of band ,name of image,Song Title,audio file,name of bio text file
				BandData *dataSet=[[BandData alloc] init];
				dataSet.bandName=foo[0];dataSet.bandImage=[UIImage imageNamed: foo[1]];
				dataSet.songTitle=foo[2];dataSet.mp3Name=foo[3];
				
				//switch this to utility method
				NSArray *fileBreakdown = [foo[4] componentsSeparatedByString: @"."];
				path = [[NSBundle mainBundle] pathForResource:fileBreakdown[0] ofType:fileBreakdown[1]];
				dataSet.bio=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
				
				BandView *bandView=[[BandView alloc] initWithFrame: self.bounds];
				bandView.bandData=dataSet;
				[_bandViews addObject:bandView];
				
			}

		}
		
		//NSLog(@"%i bands found",[_bandViews count]);

		//NSArray *b = [content componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
		
		
		
		UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]
												initWithTarget: self action: @selector(swipe:)
												];
		recognizer.direction = UISwipeGestureRecognizerDirectionRight;
		[self addGestureRecognizer: recognizer];
		
		recognizer = [[UISwipeGestureRecognizer alloc]
					  initWithTarget: self action: @selector(swipe:)
					  ];
		recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
		[self addGestureRecognizer: recognizer];
		
		recognizer = [[UISwipeGestureRecognizer alloc]
					  initWithTarget: self action: @selector(swipe:)
					  ];
		recognizer.direction = UISwipeGestureRecognizerDirectionUp;
		[self addGestureRecognizer: recognizer];
		
		recognizer = [[UISwipeGestureRecognizer alloc]
					  initWithTarget: self action: @selector(swipe:)
					  ];
		recognizer.direction = UISwipeGestureRecognizerDirectionDown;
		[self addGestureRecognizer: recognizer];
		
		[self addSubview: [_bandViews objectAtIndex: _index]];
		
		/*
		[[_bandViews objectAtIndex: _index] addTarget: [UIApplication sharedApplication].delegate
					 action: @selector(valueChanged:)
		   forControlEvents: UIControlEventValueChanged
		 ];
*/
		
    }
    return self;

}

- (void) swipe: (UISwipeGestureRecognizer *) recognizer {

	NSString *direction = @"unknown";
	if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
		direction = @"→";
		NSInteger newIndex = _index+1;
		newIndex=newIndex%[_bandViews count];
		
		[UIView transitionFromView: [_bandViews objectAtIndex: _index]
							toView: [_bandViews objectAtIndex: newIndex]
						  duration: 1.25
						   options: UIViewAnimationOptionTransitionFlipFromLeft
						completion: NULL
		 ];
		_index=newIndex;
		[_myDelegate switchPlayer: newIndex];
	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
		direction = @"←";
		
		NSInteger newIndex;
		if(_index==0)newIndex=[_bandViews count]-1;
		else newIndex=_index-1;
		
		[UIView transitionFromView: [_bandViews objectAtIndex: _index]
							toView: [_bandViews objectAtIndex: newIndex]
						  duration: 1.25
						   options: UIViewAnimationOptionTransitionFlipFromLeft
						completion: NULL
		 ];
		_index=newIndex;
		[_myDelegate switchPlayer: newIndex];
	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
		direction = @"↑";
	} else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
		direction = @"↓";
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


/*
 - (NSString*) getContents: (NSString *) filePath {
 
 //Error Holder
 NSError *error = nil;
 
 NSArray *fileBreakdown = [filePath componentsSeparatedByString: @"."];
 NSLog(@"%@ %@",fileBreakdown[0],fileBreakdown[1]);
 NSString *path = [[NSBundle mainBundle] pathForResource:fileBreakdown[0] ofType:fileBreakdown[1]];
 NSString *result = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
 if(error) NSLog(@"ERROR while loading from file \"%@\": %@", filePath,error);
 NSLog(@"result=%@",result);
 return result;
 }
 */




@end
