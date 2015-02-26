//
//  AppDelegate.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

#import "PFEventViewController.h"
#import "PFSniffViewController.h"
#import "PFProfileViewController.h"

@interface AppDelegate : UIResponder <UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) PFEventViewController *event;
@property (strong, nonatomic) PFSniffViewController *sniff;
@property (strong, nonatomic) PFProfileViewController *profile;

@end

