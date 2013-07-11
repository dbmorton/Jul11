//
//  ViewA.h
//  Example1
//
//  Created by david morton on 7/7/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassicRockAppDelegate.h"

@interface BigView : UIView {
}


//holds the band subviews we transtion between
@property (strong, nonatomic) NSMutableArray *bandViews;


//index in current view
@property  NSInteger index;

@property ClassicRockAppDelegate *myDelegate;


@end
