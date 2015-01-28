//
//  PFUpcomingViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "DLImageLoader.h"

#import "PFUpcomingCell.h"

#import "PFAllEventViewController.h"
#import "PFEventDetailViewController.h"

@interface PFUpcomingViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

- (IBAction)moreTapped:(id)sender;

@end
