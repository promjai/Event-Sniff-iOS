//
//  PagedImageScrollView.h
//  Test
//
//  Created by jianpx on 7/11/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"

enum PageControlPosition {
    PageControlPositionRightCorner = 0,
    PageControlPositionCenterBottom = 1,
    PageControlPositionLeftCorner = 2,
};

@protocol PagedImageScrollViewDelegate <NSObject>

- (void)PagedImageScrollView:(id)sender current:(NSString *)current;

@end
@interface PagedImageScrollView : UIView

@property (assign, nonatomic) id delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) enum PageControlPosition pageControlPos; //default is PageControlPositionRightCorner

- (void)setScrollViewContents: (NSArray *)images;
@end
