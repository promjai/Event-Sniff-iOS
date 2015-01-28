//
//  PFAllEventViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFNowCell.h"

#import "PFEventDetailViewController.h"

@interface PFAllEventViewController : UIViewController <UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
