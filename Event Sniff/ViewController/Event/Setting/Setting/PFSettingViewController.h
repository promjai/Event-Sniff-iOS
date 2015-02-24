//
//  PFSettingViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/31/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "PFApi.h"

#import "PFIntroViewController.h"
#import "PFProfileSettingViewController.h"
#import "PFLanguageViewController.h"

@protocol PFSettingViewControllerDelegate <NSObject>

- (void)PFSettingViewControllerBack;

@end

@interface PFSettingViewController : UIViewController <UITableViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) PFIntroViewController *introView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *ProfileSettingLabel;
@property (strong, nonatomic) IBOutlet UILabel *ProfileLabel;

@property (strong, nonatomic) IBOutlet UILabel *LocationSettingLabel;
@property (strong, nonatomic) IBOutlet UILabel *LandLabel;
@property (strong, nonatomic) IBOutlet UILabel *TownLabel;

@property (strong, nonatomic) IBOutlet UILabel *NotificationSettingLabel;
@property (strong, nonatomic) IBOutlet UILabel *EventLabel;
@property (strong, nonatomic) IBOutlet UILabel *AlarmLabel;

@property (strong, nonatomic) IBOutlet UILabel *LanguageSettingLabel;
@property (strong, nonatomic) IBOutlet UILabel *AppLanguageLabel;

@property (strong, nonatomic) IBOutlet UILabel *IntroductionLabel;

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;

//Button Tap
- (IBAction)profileTapped:(id)sender;
- (IBAction)applanguageTapped:(id)sender;
- (IBAction)introductionTapped:(id)sender;
- (IBAction)logoutTapped:(id)sender;

@end
