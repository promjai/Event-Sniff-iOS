//
//  PFEventDetailViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFEventDetailViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate>

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end
