//
//  PFEventDetailViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFCommentEventCell.h"

@interface PFEventDetailViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate>

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIImageView *sniffImage1;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage2;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage3;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage4;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage5;

@end
