//
//  PagedImageScrollView.m
//  Test
//
//  Created by jianpx on 7/11/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "PagedImageScrollView.h"

@interface PagedImageScrollView() <UIScrollViewDelegate>
@property (nonatomic) BOOL pageControlIsChangingPage;
@end

@implementation PagedImageScrollView

NSString *removeBreckets;

#define PAGECONTROL_DOT_WIDTH 20
#define PAGECONTROL_HEIGHT 20

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.pageControl = [[UIPageControl alloc] init];
        [self setDefaults];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        self.scrollView.delegate = self;
    }
    return self;
}


- (void)setPageControlPos:(enum PageControlPosition)pageControlPos
{
    CGFloat width = PAGECONTROL_DOT_WIDTH * self.pageControl.numberOfPages;
    _pageControlPos = pageControlPos;
    if (pageControlPos == PageControlPositionRightCorner)
    {
        self.pageControl.frame = CGRectMake(self.scrollView.frame.size.width - width, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT, width, PAGECONTROL_HEIGHT);
    }else if (pageControlPos == PageControlPositionCenterBottom)
    {
        self.pageControl.frame = CGRectMake((self.scrollView.frame.size.width - width) / 2, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT, width, PAGECONTROL_HEIGHT);
    }else if (pageControlPos == PageControlPositionLeftCorner)
    {
        self.pageControl.frame = CGRectMake(0, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT, width, PAGECONTROL_HEIGHT);
    }
}

- (void)setDefaults
{
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:146.0f/255.0f green:90.0f/255.0f blue:202.0f/255.0f alpha:1.0f];
    self.pageControl.hidesForSinglePage = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.pageControlPos = PageControlPositionRightCorner;
}


- (void)setScrollViewContents:(NSArray *)images
{
    //remove original subviews first.
    for (UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    if (images.count <= 0) {
        self.pageControl.numberOfPages = 0;
        return;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count, self.scrollView.frame.size.height);
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [DLImageLoader loadImageFromURL:images[i]
                              completed:^(NSError *error, NSData *imgData) {
                                  imageView.image = [UIImage imageWithData:imgData];
                              }];
        
        [self.scrollView addSubview:imageView];
    }
    self.pageControl.numberOfPages = images.count;
    //call pagecontrolpos setter.
    self.pageControlPos = self.pageControlPos;
}

- (void)changePage:(UIPageControl *)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    self.pageControlIsChangingPage = YES;
}

#pragma scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.pageControlIsChangingPage) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    //switch page at 50% across
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControlIsChangingPage = NO;
    
    removeBreckets = @"0";
    
    NSString *contentOffSet = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.scrollView.contentOffset)];
    
    NSString *newStr;
    if (contentOffSet.length == 8) {
        newStr = [contentOffSet substringWithRange:NSMakeRange(contentOffSet.length -7, 2)];
    } else if (contentOffSet.length == 9) {
        newStr = [contentOffSet substringWithRange:NSMakeRange(contentOffSet.length -8, 3)];
    } else if (contentOffSet.length == 10) {
        newStr = [contentOffSet substringWithRange:NSMakeRange(contentOffSet.length -9, 4)];
    }
    
    removeBreckets = newStr;
    
    [self.delegate PagedImageScrollView:self current:removeBreckets];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.pageControlIsChangingPage = NO;
}

@end
