//
//  PFLanguageViewController.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 2/12/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFApi.h"

@protocol PFLanguageViewControllerDelegate <NSObject>

- (void)BackSetting;

@end

@interface PFLanguageViewController : UIViewController

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) PFApi *Api;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *thai;
@property (strong, nonatomic) IBOutlet UILabel *english;
@property (strong, nonatomic) IBOutlet UIImageView *checkTH;
@property (strong, nonatomic) IBOutlet UIImageView *checkEN;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSString *statusSetting;
@property (strong, nonatomic) NSString *statusLanguage;

- (IBAction)ThaiTapped:(id)sender;
- (IBAction)EnglishTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end
