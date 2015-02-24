//
//  PFNowViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/20/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFNowViewController.h"

@interface PFNowViewController ()

@end

@implementation PFNowViewController

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
    
    self.navigationItem.title = @"Today";
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"See all" style:UIBarButtonItemStylePlain target:self action:@selector(seeAll)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"20 มกราคม 2558";
}

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
