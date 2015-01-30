//
//  PFAllEventViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/28/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFAllEventViewController.h"

@interface PFAllEventViewController ()

@end

@implementation PFAllEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"All Event";
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Location" style:UIBarButtonItemStylePlain target:self action:@selector(location)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)location {
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"20 มกราคม 2558";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFNowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFNowCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFNowCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFEventDetailViewController *eventdetailView = [[PFEventDetailViewController alloc] init];
    if(IS_WIDESCREEN) {
        eventdetailView = [[PFEventDetailViewController alloc] initWithNibName:@"PFEventDetailViewController_Wide" bundle:nil];
    } else {
        eventdetailView = [[PFEventDetailViewController alloc] initWithNibName:@"PFEventDetailViewController" bundle:nil];
    }
    eventdetailView.delegate = self;
    eventdetailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eventdetailView animated:YES];
    
}

@end
