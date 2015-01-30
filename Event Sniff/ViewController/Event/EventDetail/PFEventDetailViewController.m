//
//  PFEventDetailViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFEventDetailViewController.h"

@interface PFEventDetailViewController ()

@end

@implementation PFEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share"] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    self.sniffImage1.layer.masksToBounds = YES;
    self.sniffImage1.contentMode = UIViewContentModeScaleAspectFill;
    self.sniffImage1.layer.cornerRadius = self.sniffImage1.frame.size.width / 2;
    self.sniffImage1.clipsToBounds = YES;
    
    self.sniffImage2.layer.masksToBounds = YES;
    self.sniffImage2.contentMode = UIViewContentModeScaleAspectFill;
    self.sniffImage2.layer.cornerRadius = self.sniffImage2.frame.size.width / 2;
    self.sniffImage2.clipsToBounds = YES;
    
    self.sniffImage3.layer.masksToBounds = YES;
    self.sniffImage3.contentMode = UIViewContentModeScaleAspectFill;
    self.sniffImage3.layer.cornerRadius = self.sniffImage3.frame.size.width / 2;
    self.sniffImage3.clipsToBounds = YES;
    
    self.sniffImage4.layer.masksToBounds = YES;
    self.sniffImage4.contentMode = UIViewContentModeScaleAspectFill;
    self.sniffImage4.layer.cornerRadius = self.sniffImage4.frame.size.width / 2;
    self.sniffImage4.clipsToBounds = YES;
    
    self.sniffImage5.layer.masksToBounds = YES;
    self.sniffImage5.contentMode = UIViewContentModeScaleAspectFill;
    self.sniffImage5.layer.cornerRadius = self.sniffImage5.frame.size.width / 2;
    self.sniffImage5.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)share {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 103;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFCommentEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFCommentEventCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFCommentEventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
