//
//  PFIntroViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/9/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFIntroViewController.h"

@interface PFIntroViewController ()

@end

@implementation PFIntroViewController

FBLoginView *fbloginview;
NSString *removeBreckets;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* Button */
    [self setButton];
    
    /* Label */
    [self setLabel];
    
    removeBreckets = [[NSString alloc] init];
    removeBreckets = @"0";
    
    /* Facebook */
    [self setLoginFacebook];
    
    /* ScrollView */
    [self setScrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/* Button */

- (void)setButton {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        [self.skipButton setTitle:@"Skip" forState:UIControlStateNormal];
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.loginIntroButton setTitle:@"Log In" forState:UIControlStateNormal];
        
    } else {
        
        [self.skipButton setTitle:@"ข้าม" forState:UIControlStateNormal];
        [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
        [self.loginIntroButton setTitle:@"เข้าสู่ระบบ" forState:UIControlStateNormal];
        
    }
    
    [self.loginIntroButton.layer setMasksToBounds:YES];
    [self.loginIntroButton.layer setCornerRadius:5.0f];
    
    [self.loginwithfacebookButton.layer setMasksToBounds:YES];
    [self.loginwithfacebookButton.layer setCornerRadius:5.0f];
    
    [self.loginwithemailButton.layer setMasksToBounds:YES];
    [self.loginwithemailButton.layer setCornerRadius:5.0f];
    
    [self.logInButton.layer setMasksToBounds:YES];
    [self.logInButton.layer setCornerRadius:5.0f];
    
    [self.signUpButton.layer setMasksToBounds:YES];
    [self.signUpButton.layer setCornerRadius:5.0f];
    
}

/* Label */

- (void)setLabel {

    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.pleaseloginLabel.text = @"Please log in";
        
        self.firstDetailLabel.text = @"Sniff Out Great Events around you.";
        self.secondDetailLabel.text = @"Easy Sniff & Share.";
        self.thirdDetailLabel.text = @"Missed no more.";
        self.fourthDetailLabel.text = @"Keep you best Moment.";
        
    } else {
        
        self.pleaseloginLabel.text = @"ลงทะเบียนฟรี";
        
        self.firstDetailLabel.text = @"ติดตามกิจกรรมดีๆ รอบตัวคุณ";
        self.secondDetailLabel.text = @"ส่งต่อและแนะนำเพื่อน";
        self.thirdDetailLabel.text = @"แจ้งเตือนเมื่อถึงกำหนด";
        self.fourthDetailLabel.text = @"เก็บความประทับใจของคุณ";
        
    }

}

- (void)setLoginFacebook {

    fbloginview = [[FBLoginView alloc]init];
    fbloginview.readPermissions = @[@"public_profile",@"email",@"user_birthday"];
    fbloginview.frame = CGRectMake(0, 0, 0, 0);
    fbloginview.delegate = self;
    [self.view addSubview:fbloginview];
    
    FBSession *session = [[FBSession alloc] initWithPermissions:[[NSArray alloc] initWithObjects:@"basic_info",@"email",@"user_birthday", nil]];
    [FBSession setActiveSession:session];

}

/* ScrollView */

- (void)setScrollView {

    self.introScrollView.delegate = self;
    self.introScrollView.contentSize = CGSizeMake(self.introDetailView.frame.size.width,self.introDetailView.frame.size.height);
    [self.introScrollView addSubview:self.introDetailView];
    
}

/* Done Tap */

- (IBAction)nextTapped:(id)sender {
    
    if ([removeBreckets intValue] <= 0) {
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
            
        }
        
        [self.introScrollView setContentOffset:CGPointMake(320,0) animated:YES];
        self.pageControl.currentPage = 1;
        removeBreckets = @"32";
        
    } else if ([removeBreckets intValue] == 32) {
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
            
        }
        
        [self.introScrollView setContentOffset:CGPointMake(640,0) animated:YES];
        self.pageControl.currentPage = 2;
        removeBreckets = @"64";
        
    } else if ([removeBreckets intValue] == 64) {
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Done" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ตกลง" forState:UIControlStateNormal];
            
        }
        
        [self.introScrollView setContentOffset:CGPointMake(960,0) animated:YES];
        self.pageControl.currentPage = 3;
        removeBreckets = @"96";
        
    } else if ([removeBreckets intValue] == 96) {
        [self.Api saveStatusIntro:@"close"];
        
        PFLocationViewController *locationView = [[PFLocationViewController alloc] init];
        if(IS_WIDESCREEN) {
            locationView = [[PFLocationViewController alloc] initWithNibName:@"PFLocationViewController_Wide" bundle:nil];
        } else {
            locationView = [[PFLocationViewController alloc] initWithNibName:@"PFLocationViewController" bundle:nil];
        }
        [self presentModalViewController:locationView animated:YES];
        
    }

}

/* Log In Tap */

- (IBAction)loginTapped:(id)sender {

    [self setLoginView];
    [self.view addSubview:self.loginView];

}

/* SKIP Tap */

- (IBAction)skipTapped:(id)sender {
    
    [self.Api saveStatusIntro:@"close"];    
    PFLocationViewController *locationView = [[PFLocationViewController alloc] init];
    if(IS_WIDESCREEN) {
        locationView = [[PFLocationViewController alloc] initWithNibName:@"PFLocationViewController_Wide" bundle:nil];
    } else {
        locationView = [[PFLocationViewController alloc] initWithNibName:@"PFLocationViewController" bundle:nil];
    }
    //locationView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:locationView animated:YES];
    //[self presentModalViewController:locationView animated:YES];
    
}

/* Set Login View */

- (void)setLoginView {
    
    [self.emailTextField setPlaceholder:@"Username"];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.logInButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.signUpButton setTitle:@"Sign up" forState:UIControlStateNormal];
    
}

/* Log In Facebook Tap */

- (IBAction)loginwithfacebookTapped:(id)sender {

    for (id obj in fbloginview.subviews) {
        if ([obj isKindOfClass:[UIButton class]]){
            [obj sendActionsForControlEvents: UIControlEventTouchUpInside];
            {
            }
        }
    }

}

/* Log In Email Tap */

- (IBAction)loginwithemailTapped:(id)sender {
    
    self.loginwithemailButton.alpha = 0;
    self.logInButton.frame = CGRectMake(30, 350, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
    self.signUpButton.frame = CGRectMake(160, 350, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
    [UIView animateWithDuration:1.0
                          delay:0.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         self.emailTextField.alpha = 1;
                         self.passwordTextField.alpha = 1;
                         
                         self.bgemailTextFieldView.alpha = 1;
                         self.bgpasswordTextFieldView.alpha = 1;
                         
                         self.logInButton.alpha = 1;
                         self.signUpButton.alpha = 1;
                         self.logInButton.frame = CGRectMake(30, 450, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
                         self.signUpButton.frame = CGRectMake(163, 450, self.logInButton.frame.size.width, self.logInButton.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}

#pragma scrollviewdelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSString *contentOffSet = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(self.introScrollView.contentOffset)];
    removeBreckets = [contentOffSet stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"{ ,0}"]];
    
    if ([removeBreckets intValue] <= 0) {
        self.pageControl.currentPage = 0;
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
            
        }
        
    }
    if ([removeBreckets intValue] == 32) {
        self.pageControl.currentPage = 1;
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
            
        }
        
    }
    if ([removeBreckets intValue] == 64) {
        self.pageControl.currentPage = 2;
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ถัดไป" forState:UIControlStateNormal];
            
        }
        
    }
    if ([removeBreckets intValue] == 96) {
        self.pageControl.currentPage = 3;
        
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            
            [self.nextButton setTitle:@"Done" forState:UIControlStateNormal];
            
        } else {
            
            [self.nextButton setTitle:@"ตกลง" forState:UIControlStateNormal];
            
        }
        
    }
    
}

#pragma mark - Facebook Delegate
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    NSString *fbAccessToken = [FBSession activeSession].accessTokenData.accessToken;
    [self.Api loginWithFacebookToken:fbAccessToken];
    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"You're logged in as");
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"You're not logged in!");
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)PFApi:(id)sender loginWithFacebookTokenResponse:(NSDictionary *)response {
    NSLog(@"FacebookResponse %@",response);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[response objectForKey:@"type"] forKey:@"type"];
    [defaults setObject:[response objectForKey:@"access_token"] forKey:@"access_token"];
    [defaults setObject:[response objectForKey:@"user_id"] forKey:@"user_id"];
    [defaults synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)PFApi:(id)sender LoginWithFacebookTokenErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    
    [[[UIAlertView alloc] initWithTitle:@"Login failed"
                                message:errorResponse
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
