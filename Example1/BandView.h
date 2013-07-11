//
//  BandView.h
//  Example1
//
//  Created by david morton on 7/7/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BandData.h"

@interface BandView : UIView{
	UILabel *label;
	UITextView *textView;
}

@property (strong, nonatomic) BandData *bandData;



@end
