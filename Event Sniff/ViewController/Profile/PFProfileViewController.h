//
//  PFProfileViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

#import "PFLoginViewController.h"

@interface PFProfileViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) PFLoginViewController *loginView;

@end
