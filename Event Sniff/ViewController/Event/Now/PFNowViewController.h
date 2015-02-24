//
//  PFNowViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

#import "PFNowCell.h"

#import "PFAllEventViewController.h"
#import "PFEventDetailViewController.h"

@interface PFNowViewController : UIViewController <UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
