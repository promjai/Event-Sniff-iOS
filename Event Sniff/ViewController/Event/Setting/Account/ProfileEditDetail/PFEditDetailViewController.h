//
//  PFEditDetailViewController.h
//  RatreeSamosorn
//
//  Created by Pariwat on 6/30/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFRatreeSamosornApi.h"

@protocol PFEditDetailViewControllerDelegate <NSObject>

- (void)PFEditDetailViewControllerBack;

@end

@interface PFEditDetailViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFRatreeSamosornApi *RatreeSamosornApi;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *displaynameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *websiteView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *genderView;
@property (strong, nonatomic) IBOutlet UIView *birthdayView;

@property (strong, nonatomic) IBOutlet UITextField *displayname;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *newpassword;
@property (strong, nonatomic) IBOutlet UITextField *confirmpassword;

@property (strong, nonatomic) IBOutlet UITextField *website;
@property (strong, nonatomic) IBOutlet UITextField *phone;

@property (strong, nonatomic) IBOutlet UIButton *displayname_bt;
@property (strong, nonatomic) IBOutlet UIButton *password_bt;
@property (strong, nonatomic) IBOutlet UIButton *email_bt;
@property (strong, nonatomic) IBOutlet UIButton *website_bt;
@property (strong, nonatomic) IBOutlet UIButton *phone_bt;
@property (strong, nonatomic) IBOutlet UIButton *gender_bt;
@property (strong, nonatomic) IBOutlet UIButton *birthday_bt;

@property (strong, nonatomic) IBOutlet UIButton *male_bt;
@property (strong, nonatomic) IBOutlet UIButton *female_bt;

@property (strong, nonatomic) NSDictionary *obj;
@property (strong, nonatomic) NSString *checkstatus;
@property (strong, nonatomic) NSString *checkgender;
@property (strong, nonatomic) IBOutlet UIDatePicker *Date;

- (IBAction)maleTapped:(id)sender;
- (IBAction)femaleTapped:(id)sender;

- (IBAction)displaynameTapped:(id)sender;
- (IBAction)passwordTapped:(id)sender;
- (IBAction)emailTapped:(id)sender;
- (IBAction)websiteTapped:(id)sender;
- (IBAction)phoneTapped:(id)sender;
- (IBAction)genderTapped:(id)sender;
- (IBAction)birthdayTapped:(id)sender;

@end
