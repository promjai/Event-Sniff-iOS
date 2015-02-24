//
//  PFProfileViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/31/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFProfileSettingViewController.h"

@interface PFProfileSettingViewController ()

@end

@implementation PFProfileSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
        self.meOffline = [NSUserDefaults standardUserDefaults];
        self.settingOffline = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* NavigationBar */
    [self setNavigationBar];
    
    [self.view addSubview:self.waitView];
    
    [self.Api me];
    
    [self setLayerView];
    
    self.objAccount = [[NSDictionary alloc] init];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/* Set NavigationBar */

- (void)setNavigationBar {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.navigationItem.title = @"Profile Setting";
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editProfile)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        
    } else {
        
        self.navigationItem.title = @"ตั้งค่าโปรไฟล์";
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"แก้ไข" style:UIBarButtonItemStylePlain target:self action:@selector(editProfile)];
        self.navigationItem.rightBarButtonItem = anotherButton;
        
    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
}

/* Edit Profile Tap */

- (void)editProfile {

    PFProfileEditViewController *profileEditView = [[PFProfileEditViewController alloc] init];
    if(IS_WIDESCREEN) {
        profileEditView = [[PFProfileEditViewController alloc] initWithNibName:@"PFProfileEditViewController_Wide" bundle:nil];
    } else {
        profileEditView = [[PFProfileEditViewController alloc] initWithNibName:@"PFProfileEditViewController" bundle:nil];
    }
    profileEditView.delegate = self;
    [self presentModalViewController:profileEditView animated:YES];
    
}

/* Set LayerView */

- (void)setLayerView {
    
    CALayer *facebook_bt = [self.facebook_bt layer];
    [facebook_bt setMasksToBounds:YES];
    [facebook_bt setCornerRadius:5.0f];
    
    CALayer *website_bt = [self.website_bt layer];
    [website_bt setMasksToBounds:YES];
    [website_bt setCornerRadius:5.0f];
    
    CALayer *tel_bt = [self.tel_bt layer];
    [tel_bt setMasksToBounds:YES];
    [tel_bt setCornerRadius:5.0f];
    
    CALayer *gender_bt = [self.gender_bt layer];
    [gender_bt setMasksToBounds:YES];
    [gender_bt setCornerRadius:5.0f];
    
    CALayer *birthday_bt = [self.birthday_bt layer];
    [birthday_bt setMasksToBounds:YES];
    [birthday_bt setCornerRadius:5.0f];

}

/* Full image Tap */

- (IBAction)fullimgTapped:(id)sender {
    
    NSString *picStr = [[NSString alloc] initWithString:[[[self.meOffline objectForKey:@"meOffline"] objectForKey:@"picture"] objectForKey:@"url"]];
    [self.delegate PFAccountViewController:self viewPicture:picStr];
    
}

/* me API */

- (void)PFApi:(id)sender meResponse:(NSDictionary *)response {
    self.objAccount = response;
    
    [self.waitView removeFromSuperview];
    
    [self.meOffline setObject:response forKey:@"meOffline"];
    [self.meOffline synchronize];
    
    self.display_name.text = [response objectForKey:@"display_name"];
    
    NSString *picStr = [[response objectForKey:@"picture"] objectForKey:@"url"];
    
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.layer.cornerRadius = self.thumUser.frame.size.width / 2;
    self.thumUser.clipsToBounds = YES;

    [DLImageLoader loadImageFromURL:picStr
                          completed:^(NSError *error, NSData *imgData) {
                              self.thumUser.image = [UIImage imageWithData:imgData];
                          }];
    
    self.facebook.text = [response objectForKey:@"fb_name"];
    self.email.text = [response objectForKey:@"email"];
    self.website.text = [response objectForKey:@"website"];
    self.tel.text = [response objectForKey:@"mobile"];
    self.gender.text = [response objectForKey:@"gender"];
    
    NSString *myString = [[NSString alloc] initWithFormat:@"%@",[response objectForKey:@"birth_date"]];
    NSString *mySmallerString = [myString substringToIndex:10];
    
    self.birthday.text = mySmallerString;
    
    //[self.RatreeSamosornApi getUserSetting];
    
}

- (void)PFApi:(id)sender meErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    
    [self.waitView removeFromSuperview];
    
    self.objAccount = [self.meOffline objectForKey:@"meOffline"];
    
    self.display_name.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"display_name"];
    
    NSString *picStr = [[[self.meOffline objectForKey:@"meOffline"] objectForKey:@"picture"] objectForKey:@"url"];
    self.thumUser.layer.masksToBounds = YES;
    self.thumUser.contentMode = UIViewContentModeScaleAspectFill;
    self.thumUser.layer.cornerRadius = self.thumUser.frame.size.width / 2;
    self.thumUser.clipsToBounds = YES;
    
    [DLImageLoader loadImageFromURL:picStr
                          completed:^(NSError *error, NSData *imgData) {
                              self.thumUser.image = [UIImage imageWithData:imgData];
                          }];
    
    self.facebook.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"fb_name"];
    self.email.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"email"];
    self.website.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"website"];
    self.tel.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"mobile"];
    self.gender.text = [[self.meOffline objectForKey:@"meOffline"] objectForKey:@"gender"];
    
    NSString *myString = [[NSString alloc] initWithFormat:@"%@",[[self.meOffline objectForKey:@"meOffline"] objectForKey:@"birth_date"]];
    NSString *mySmallerString = [myString substringToIndex:10];
    
    self.birthday.text = mySmallerString;
    
    //[self.RatreeSamosornApi getUserSetting];
}

- (void)PFApi:(id)sender getUserSettingResponse:(NSDictionary *)response {
    //NSLog(@"getUserSetting %@",response);
    
    [self.settingOffline setObject:response forKey:@"settingOffline"];
    [self.settingOffline synchronize];
    
    //switch
    if ([[response objectForKey:@"show_facebook"] intValue] == 1) {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        } else {
            [self.facebook_bt setTitle:@"แสดง" forState:UIControlStateNormal];
        }
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    } else {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        } else {
            [self.facebook_bt setTitle:@"ซ่อน" forState:UIControlStateNormal];
        }
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    }
    if ([[response objectForKey:@"show_website"] intValue] == 1) {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        } else {
            [self.website_bt setTitle:@"แสดง" forState:UIControlStateNormal];
        }
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    } else {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        } else {
            [self.website_bt setTitle:@"ซ่อน" forState:UIControlStateNormal];
        }
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    }
    if ([[response objectForKey:@"show_mobile"] intValue] == 1) {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        } else {
            [self.tel_bt setTitle:@"แสดง" forState:UIControlStateNormal];
        }
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    } else {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        } else {
            [self.tel_bt setTitle:@"ซ่อน" forState:UIControlStateNormal];
        }
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    }
    if ([[response objectForKey:@"show_gender"] intValue] == 1) {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        } else {
            [self.gender_bt setTitle:@"แสดง" forState:UIControlStateNormal];
        }
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    } else {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        } else {
            [self.gender_bt setTitle:@"ซ่อน" forState:UIControlStateNormal];
        }
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    }
    if ([[response objectForKey:@"show_birth_date"] intValue] == 1) {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        } else {
            [self.birthday_bt setTitle:@"แสดง" forState:UIControlStateNormal];
        }
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    } else {
        if (![[self.Api getLanguage] isEqualToString:@"th"]) {
            [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        } else {
            [self.birthday_bt setTitle:@"ซ่อน" forState:UIControlStateNormal];
        }
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    }
    
}

- (void)PFApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    
}

- (IBAction)facebookTapped:(id)sender {
    if ([self.facebook_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.facebook_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(167, 169, 172)];
        self.facebookSetting = @"0";
    } else {
        [self.facebook_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.facebook_bt setTintColor:RGB(0, 174, 239)];
        self.facebookSetting = @"1";
    }
    [self.Api settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)websiteTapped:(id)sender {
    if ([self.website_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.website_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(167, 169, 172)];
        self.websiteSetting = @"0";
    } else {
        [self.website_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.website_bt setTintColor:RGB(0, 174, 239)];
        self.websiteSetting = @"1";
    }
    [self.Api settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)telTapped:(id)sender {
    if ([self.tel_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.tel_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(167, 169, 172)];
        self.telSetting = @"0";
    } else {
        [self.tel_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.tel_bt setTintColor:RGB(0, 174, 239)];
        self.telSetting = @"1";
    }
    [self.Api settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)genderTapped:(id)sender {
    if ([self.gender_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.gender_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(167, 169, 172)];
        self.genderSetting = @"0";
    } else {
        [self.gender_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.gender_bt setTintColor:RGB(0, 174, 239)];
        self.genderSetting = @"1";
    }
    [self.Api settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (IBAction)birthdayTapped:(id)sender {
    if ([self.birthday_bt.titleLabel.text isEqualToString:@"Show"]) {
        [self.birthday_bt setTitle:@"Hide" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(167, 169, 172)];
        self.birthdaySetting = @"0";
    } else {
        [self.birthday_bt setTitle:@"Show" forState:UIControlStateNormal];
        [self.birthday_bt setTintColor:RGB(0, 174, 239)];
        self.birthdaySetting = @"1";
    }
    [self.Api settingUser:self.facebookSetting email:self.emailSetting website:self.websiteSetting tel:self.telSetting gender:self.genderSetting birthday:self.birthdaySetting];
}

- (void) PFEditViewControllerBack {
    [self viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFProfileViewControllerBack)]){
            [self.delegate PFProfileViewControllerBack];
        }
    }
    
}

@end
