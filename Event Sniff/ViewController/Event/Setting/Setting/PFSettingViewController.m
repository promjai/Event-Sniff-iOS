//
//  PFSettingViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/31/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFSettingViewController.h"

@interface PFSettingViewController ()

@end

@implementation PFSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* NavigationBar */
    [self setNavigationBar];
    
    /* Button */
    [self setButton];
    
    /* Parameter */
    [self setParameter];
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/* Set NavigationBar */

- (void)setNavigationBar {

    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.navigationItem.title = @"Setting";
        
    } else {
        
        self.navigationItem.title = @"ตั้งค่า";
    
    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];

}

/* Button */

- (void)setButton {
    
    [self.logoutButton.layer setMasksToBounds:YES];
    [self.logoutButton.layer setCornerRadius:5.0f];

}

/* Parameter */

- (void)setParameter {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.ProfileSettingLabel.text = @"Profile Setting";
        self.ProfileLabel.text = @"Profile";
        
        self.LocationSettingLabel.text = @"Location Setting";
        self.LandLabel.text = @"Country";
        self.TownLabel.text = @"Town";
        
        self.NotificationSettingLabel.text = @"Notification Setting";
        self.EventLabel.text = @"Event Updated";
        self.AlarmLabel.text = @"Alarm";
        
        self.LanguageSettingLabel.text = @"Language Setting";
        self.AppLanguageLabel.text = @"Application Language";
        
        self.IntroductionLabel.text = @"Show introduction";
        
        [self.logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
        
    } else {
        
        self.ProfileSettingLabel.text = @"ตั้งค่าโปรไฟล์";
        self.ProfileLabel.text = @"โปรไฟล์";
        
        self.LocationSettingLabel.text = @"ตั้งค่าสถานที่";
        self.LandLabel.text = @"ประเทศ";
        self.TownLabel.text = @"จังหวัด,เมือง";
        
        self.NotificationSettingLabel.text = @"ตั้งค่าการแจ้งเตือน";
        self.EventLabel.text = @"กิจกรรมมาใหม่";
        self.AlarmLabel.text = @"เตือน";
        
        self.LanguageSettingLabel.text = @"ตั้งค่าภาษา";
        self.AppLanguageLabel.text = @"ภาษาแอพพลิเคชั่น";
        
        self.IntroductionLabel.text = @"แสดงหน้าเริ่มต้น";
        
        [self.logoutButton setTitle:@"ออกจากระบบ" forState:UIControlStateNormal];
        
    }
    
}

/* Profile Tap */

- (IBAction)profileTapped:(id)sender {
    
    PFProfileSettingViewController *profileSettingView = [[PFProfileSettingViewController alloc] init];
    if(IS_WIDESCREEN) {
        profileSettingView = [[PFProfileSettingViewController alloc] initWithNibName:@"PFProfileSettingViewController_Wide" bundle:nil];
    } else {
        profileSettingView = [[PFProfileSettingViewController alloc] initWithNibName:@"PFProfileSettingViewController" bundle:nil];
    }
    profileSettingView.delegate = self;
    [self.navigationController pushViewController:profileSettingView animated:YES];

}

/* App Language Tap */

- (IBAction)applanguageTapped:(id)sender {

    PFLanguageViewController *applanguageView = [[PFLanguageViewController alloc] init];
    if(IS_WIDESCREEN) {
        applanguageView = [[PFLanguageViewController alloc] initWithNibName:@"PFLanguageViewController_Wide" bundle:nil];
    } else {
        applanguageView = [[PFLanguageViewController alloc] initWithNibName:@"PFLanguageViewController" bundle:nil];
    }
    applanguageView.delegate = self;
    [self.navigationController pushViewController:applanguageView animated:YES];

}

/* Intro Tap */

- (IBAction)introductionTapped:(id)sender {

    self.introView = [[PFIntroViewController alloc] initWithNibName:@"PFIntroViewController_Wide" bundle:nil];
    self.introView.delegate = self;
    [self presentModalViewController:self.introView animated:YES];

}

/* Logout Tap */

- (IBAction)logoutTapped:(id)sender {

    [FBSession.activeSession closeAndClearTokenInformation];
    [self.Api logOut];
    
}

- (void)BackSetting {
    
    [self viewDidLoad];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFSettingViewControllerBack)]){
            [self.delegate PFSettingViewControllerBack];
        }
    }
    
}

@end
