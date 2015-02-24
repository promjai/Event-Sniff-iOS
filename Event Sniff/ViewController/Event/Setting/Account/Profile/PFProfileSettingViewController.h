//
//  PFProfileSettingViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/31/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"

#import "PFApi.h"

#import "PFProfileEditViewController.h"

@protocol PFProfileSettingViewControllerDelegate <NSObject>

- (void)PFAccountViewController:(id)sender viewPicture:(NSString *)link;
- (void)PFProfileViewControllerBack;

@end

@interface PFProfileSettingViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property NSUserDefaults *meOffline;
@property NSUserDefaults *settingOffline;

@property (strong, nonatomic) IBOutlet UIView *waitView;

@property (strong, nonatomic) NSDictionary *objAccount;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UITextField *display_name;

@property (strong, nonatomic) IBOutlet UIImageView *thumUser;

@property (strong, nonatomic) IBOutlet UITextField *facebook;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *website;
@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *birthday;

@property (strong, nonatomic) NSString *facebookSetting;
@property (strong, nonatomic) NSString *emailSetting;
@property (strong, nonatomic) NSString *websiteSetting;
@property (strong, nonatomic) NSString *telSetting;
@property (strong, nonatomic) NSString *genderSetting;
@property (strong, nonatomic) NSString *birthdaySetting;

@property (strong, nonatomic) IBOutlet UIButton *facebook_bt;
@property (strong, nonatomic) IBOutlet UIButton *website_bt;
@property (strong, nonatomic) IBOutlet UIButton *tel_bt;
@property (strong, nonatomic) IBOutlet UIButton *gender_bt;
@property (strong, nonatomic) IBOutlet UIButton *birthday_bt;

//- (IBAction)fullimgTapped:(id)sender;
//- (IBAction)facebookTapped:(id)sender;
//- (IBAction)emailTapped:(id)sender;
//- (IBAction)websiteTapped:(id)sender;
//- (IBAction)telTapped:(id)sender;
//- (IBAction)genderTapped:(id)sender;
//- (IBAction)birthdayTapped:(id)sender;

@end
