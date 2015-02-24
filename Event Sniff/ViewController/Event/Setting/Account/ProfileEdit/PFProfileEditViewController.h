//
//  PFProfileEditViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/11/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

@interface PFProfileEditViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic  ) IBOutlet UINavigationItem *navItem;

@end
