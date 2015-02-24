//
//  PFIntroViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/9/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "PFApi.h"

#import "PFLocationViewController.h"

@interface PFIntroViewController : UIViewController <FBLoginViewDelegate,UIScrollViewDelegate>

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) IBOutlet UIScrollView *introScrollView;
@property (strong, nonatomic) IBOutlet UIView *introDetailView;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UILabel *pleaseloginLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourthDetailLabel;

@property (strong, nonatomic) IBOutlet UIButton *skipButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *loginIntroButton;

//login
@property (strong, nonatomic) IBOutlet UIView *loginView;

@property (strong, nonatomic) IBOutlet UIButton *loginwithfacebookButton;
@property (strong, nonatomic) IBOutlet UIButton *loginwithemailButton;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIImageView *bgemailTextFieldView;
@property (strong, nonatomic) IBOutlet UIImageView *bgpasswordTextFieldView;

@property (strong, nonatomic) IBOutlet UIButton *logInButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;

//Button Tap
- (IBAction)loginwithfacebookTapped:(id)sender;
- (IBAction)loginwithemailTapped:(id)sender;
- (IBAction)skipTapped:(id)sender;
- (IBAction)nextTapped:(id)sender;
- (IBAction)loginTapped:(id)sender;

@end
