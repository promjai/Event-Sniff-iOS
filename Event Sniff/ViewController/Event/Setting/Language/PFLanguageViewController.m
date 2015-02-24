//
//  PFLanguageViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/12/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFLanguageViewController.h"

@interface PFLanguageViewController ()

@end

@implementation PFLanguageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* NavigationBar */
    [self setNavigationBar];
    
    /* Parameter */
    [self setParameter];

    /* Set Layer Button */
    [self setLayerButton];
    
    
    self.tableView.tableHeaderView = self.headerView;
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
        
        self.navigationItem.title = @"Application Language";
        
    } else {
        
        self.navigationItem.title = @"ภาษาแอพพลิเคชั่น";
        
    }
    
}

/* Parameter */

- (void)setParameter {

    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.checkTH.hidden = YES;
        self.thai.textColor = RGB(170, 170, 170);
        self.thai.text = @"Thai (TH)";
        self.english.textColor = RGB(0, 0, 0);
        self.english.text = @"English (EN)";
        self.statusLanguage = @"en";
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        
    } else {
        
        self.checkEN.hidden = YES;
        self.thai.textColor = RGB(0, 0, 0);
        self.thai.text = @"ภาษาไทย (TH)";
        self.english.textColor = RGB(170, 170, 170);
        self.english.text = @"ภาษาอังกฤษ (EN)";
        self.statusLanguage = @"th";
        [self.saveButton setTitle:@"บันทึก" forState:UIControlStateNormal];
        
    }

}

/* Set Layer Button */

- (void)setLayerButton {
    
    CALayer *saveButton = [self.saveButton layer];
    [saveButton setMasksToBounds:YES];
    [saveButton setCornerRadius:5.0f];

}

/* Thai Tap */

- (IBAction)ThaiTapped:(id)sender{
    self.checkEN.hidden = YES;
    self.checkTH.hidden = NO;
    self.thai.textColor = RGB(0, 0, 0);
    self.english.textColor = RGB(170, 170, 170);
    self.statusLanguage = @"th";
}

/* English Tap */

- (IBAction)EnglishTapped:(id)sender{
    self.checkTH.hidden = YES;
    self.checkEN.hidden = NO;
    self.thai.textColor = RGB(170, 170, 170);
    self.english.textColor = RGB(0, 0, 0);
    self.statusLanguage = @"en";
}

/* Save Tap */

- (IBAction)saveTapped:(id)sender{
    [self.Api saveLanguage:self.statusLanguage];
    [self.delegate BackSetting];
    [self.Api saveReset:@"YES"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
