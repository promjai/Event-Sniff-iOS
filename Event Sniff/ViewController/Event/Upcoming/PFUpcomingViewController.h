//
//  PFUpcomingViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFUpcomingViewController : UIViewController <UIScrollViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
