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
    
    /* NavigationBar */
    [self setNavigationBar];
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /*
    if ([self.Api checkLogin] == 0){
        
        self.loginView = [PFLoginViewController alloc];
        [self.view addSubview:self.loginView.view];
        
    }
     */
    
    /* END */
    
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
    
    self.navigationItem.title = @"Profile";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add_event)];
    
}

/* Add Event Onclick */

- (void)add_event {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event Sniff"
                                                    message:@"Add Event Sniff."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

/* Table */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

/* END */

@end
