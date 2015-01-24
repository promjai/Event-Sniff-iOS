//
//  PFEventViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

#import "PFApi.h"

#import "PFEventCell.h"

#import "PFNowViewController.h"
#import "PFUpcomingViewController.h"
#import "PFCategoryViewController.h"

@interface PFEventViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

//header
@property (strong, nonatomic) IBOutlet UIView *headerView;

//search bar
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

//now
@property (strong, nonatomic) IBOutlet UILabel *showAllLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (strong, nonatomic) IBOutlet UIView *headerDetailView;

//upcoming
@property (strong, nonatomic) IBOutlet UILabel *moreLabel;

@property (strong, nonatomic) IBOutlet UIImageView *upcomingImage1;
@property (strong, nonatomic) IBOutlet UIImageView *upcomingImage2;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)showAllTapped:(id)sender;
- (IBAction)moreTapped:(id)sender;

@end
