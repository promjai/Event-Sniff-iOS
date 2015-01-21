//
//  PFEventViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFEventCell.h"

#import "PFNowViewController.h"
#import "PFUpcomingViewController.h"
#import "PFCategoryViewController.h"

@interface PFEventViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (strong, nonatomic) IBOutlet UIView *headerDetailView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *showAllLabel;
@property (strong, nonatomic) IBOutlet UILabel *moreLabel;

- (IBAction)showAllTapped:(id)sender;
- (IBAction)moreTapped:(id)sender;

@end
