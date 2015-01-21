//
//  PFNowViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFNowCell.h"

@interface PFNowViewController : UIViewController <UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
