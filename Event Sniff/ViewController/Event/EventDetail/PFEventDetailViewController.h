//
//  PFEventDetailViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagedImageScrollView.h"

#import "PFApi.h"

#import "PFCommentEventCell.h"

@interface PFEventDetailViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;
@property (strong, nonatomic) NSMutableArray *arrObj;
@property (strong, nonatomic) NSDictionary *obj;

@property NSString *event_id;

@property (strong, nonatomic) IBOutlet PagedImageScrollView *pageScrollView;

@property (strong, nonatomic) IBOutlet UIView *imgscrollview;
@property (strong, nonatomic) NSMutableArray *ArrImgs;
@property (retain, nonatomic) NSMutableArray *arrcontactimg;
@property (strong, nonatomic) NSString *current;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIImageView *sniffImage1;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage2;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage3;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage4;
@property (strong, nonatomic) IBOutlet UIImageView *sniffImage5;

@end
