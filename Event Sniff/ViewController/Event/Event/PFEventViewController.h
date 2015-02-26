//
//  PFEventViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "DLImageLoader.h"

#import "PFApi.h"

#import "PFEventCell.h"

#import "PFIntroViewController.h"
#import "PFSettingViewController.h"
#import "PFNowViewController.h"
#import "PFUpcomingViewController.h"
#import "PFEventDetailViewController.h"

@protocol PFEventViewControllerDelegate <NSObject>

- (void)tabbar;

@end

@interface PFEventViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UIScrollView	*_scrollView;

}

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) NSMutableArray *arrObjNow;
@property (strong, nonatomic) NSDictionary *objNow;

@property (strong, nonatomic) PFIntroViewController *introView;

@property (strong, nonatomic) NSMutableArray *arrObjUpcoming;
@property (strong, nonatomic) NSDictionary *objUpcoming;

@property (strong, nonatomic) NSMutableArray *arrObjCategory;
@property (strong, nonatomic) NSDictionary *objCategory;

//header
@property (strong, nonatomic) IBOutlet UIView *headerView;

//search bar
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

//now
@property (strong, nonatomic) IBOutlet UILabel *showAllLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *headerScrollView;

//upcoming
@property (strong, nonatomic) IBOutlet UILabel *moreLabel;

@property (strong, nonatomic) IBOutlet UIImageView *upcomingImage1;
@property (strong, nonatomic) IBOutlet UIImageView *upcomingImage2;

@property (strong, nonatomic) IBOutlet UIView *upcomingGradientView1;
@property (strong, nonatomic) IBOutlet UIView *upcomingGradientView2;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

//pull to refresh
@property (strong, nonatomic) UIRefreshControl *refreshControl;

- (IBAction)showAllTapped:(id)sender;
- (IBAction)moreTapped:(id)sender;

@end
