//
//  ARScrollViewEnhancer.m
//  ScrollViewPagingExample
//
//  Created by Alexander Repty on 12.02.10.
//  Copyright 2010 Enough Software. All rights reserved.
//

#import "ARScrollViewEnhancer.h"

@implementation ARScrollViewEnhancer

#pragma mark -
#pragma mark UIView methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if ([self pointInside:point withEvent:event]) {
		return _scrollView;
	}
	return nil;
}

@end
