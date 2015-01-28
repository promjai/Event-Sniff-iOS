//
//  PFUpcomingViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFUpcomingViewController.h"

@interface PFUpcomingViewController ()

@end

@implementation PFUpcomingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"See all" style:UIBarButtonItemStylePlain target:self action:@selector(seeAll)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
    self.tableView.tableFooterView = self.footerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)seeAll {
    
    PFAllEventViewController *alleventView = [[PFAllEventViewController alloc] init];
    if(IS_WIDESCREEN) {
        alleventView = [[PFAllEventViewController alloc] initWithNibName:@"PFAllEventViewController_Wide" bundle:nil];
    } else {
        alleventView = [[PFAllEventViewController alloc] initWithNibName:@"PFAllEventViewController" bundle:nil];
    }
    alleventView.delegate = self;
    alleventView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:alleventView animated:YES];
    
}

- (IBAction)moreTapped:(id)sender {
    
    PFAllEventViewController *alleventView = [[PFAllEventViewController alloc] init];
    if(IS_WIDESCREEN) {
        alleventView = [[PFAllEventViewController alloc] initWithNibName:@"PFAllEventViewController_Wide" bundle:nil];
    } else {
        alleventView = [[PFAllEventViewController alloc] initWithNibName:@"PFAllEventViewController" bundle:nil];
    }
    alleventView.delegate = self;
    alleventView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:alleventView animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUpcomingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFUpcomingCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFUpcomingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.upcomingImage.layer.masksToBounds = YES;
    cell.upcomingImage.contentMode = UIViewContentModeScaleAspectFill;
    
//    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"]];
//    
//    [DLImageLoader loadImageFromURL:urlimg
//                          completed:^(NSError *error, NSData *imgData) {
//                              cell.upcomingImage.image = [UIImage imageWithData:imgData];
//                          }];
    
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
