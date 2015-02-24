//
//  PFEditViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/31/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLImageLoader.h"

#import "PFApi.h"

@protocol PFEditViewControllerDelegate <NSObject>

- (void)PFEditViewControllerBack;

@end

@interface PFEditViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFRatreeSamosornApi *RatreeSamosornApi;

@property NSUserDefaults *meOffline;

@property (strong, nonatomic) NSDictionary *objEdit;

@property (strong, nonatomic) IBOutlet UIView *waitView;
@property (strong, nonatomic) IBOutlet UIView *popupwaitView;

@property (strong, nonatomic) IBOutlet UINavigationController *navController;
@property (strong, nonatomic) IBOutlet CRGradientNavigationBar *navBar;
@property (strong, nonatomic  ) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *bgprofileView;
@property (strong, nonatomic) IBOutlet UIView *displaynameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;

@property (strong, nonatomic) IBOutlet UIView *bgemailView;
@property (strong, nonatomic) IBOutlet UIView *bgwebsiteView;
@property (strong, nonatomic) IBOutlet UIView *bgphoneView;
@property (strong, nonatomic) IBOutlet UIView *bggenderView;
@property (strong, nonatomic) IBOutlet UIView *bgbirthdayView;

@property (strong, nonatomic) IBOutlet UILabel *displaynameLabel;
@property (strong, nonatomic) IBOutlet UILabel *changepasswordLabel;

@property (strong, nonatomic) IBOutlet UITextField *display_name;

@property (strong, nonatomic) IBOutlet UIImageView *thumUser;

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *website;
@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *birthday;

@property (strong, nonatomic) IBOutlet UIImageView *password;

- (IBAction)uploadPictureTapped:(id)sender;

- (IBAction)displaynameTapped:(id)sender;
- (IBAction)passwordTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)telTapped:(id)sender;
- (IBAction)genderTapped:(id)sender;
- (IBAction)birthdayTapped:(id)sender;

@end
