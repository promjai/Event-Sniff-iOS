//
//  PFProfileViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFProfileViewController.h"

@interface PFProfileViewController ()

@end

@implementation PFProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Profile";
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.scrollView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add_event)];
    
    if ([self.Api checkLogin] == 0){
        
        self.loginView = [PFLoginViewController alloc];
        [self.view addSubview:self.loginView.view];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = self.scrollView.bounds.size;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)add_event {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event Sniff"
                                                    message:@"Add Event Sniff."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
