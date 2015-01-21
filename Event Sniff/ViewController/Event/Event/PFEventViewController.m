//
//  PFEventViewController.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFEventViewController.h"

@interface PFEventViewController ()

@end

@implementation PFEventViewController

BOOL loadEvent;
BOOL noDataEvent;
BOOL refreshDataEvent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Event";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(account)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_notification"] style:UIBarButtonItemStyleDone target:self action:@selector(account)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
    self.tableView.tableHeaderView = self.headerView;
    self.headerScrollView.contentSize = CGSizeMake(self.headerDetailView.frame.size.width,self.headerDetailView.frame.size.height);
    [self.headerScrollView addSubview:self.headerDetailView];
    
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    self.tableView.tableFooterView = fv;
    
    loadEvent = NO;
    noDataEvent = NO;
    refreshDataEvent = NO;
    
    self.arrObj = [[NSMutableArray alloc] init];
    
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    [self.Api getCategory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)showAllTapped:(id)sender {
    
    PFNowViewController *nowView = [[PFNowViewController alloc] init];
    if(IS_WIDESCREEN) {
        nowView = [[PFNowViewController alloc] initWithNibName:@"PFNowViewController_Wide" bundle:nil];
    } else {
        nowView = [[PFNowViewController alloc] initWithNibName:@"PFNowViewController" bundle:nil];
    }
    nowView.delegate = self;
    nowView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nowView animated:YES];
    
}

- (IBAction)moreTapped:(id)sender {
    
    PFUpcomingViewController *upcomingView = [[PFUpcomingViewController alloc] init];
    if(IS_WIDESCREEN) {
        upcomingView = [[PFUpcomingViewController alloc] initWithNibName:@"PFUpcomingViewController_Wide" bundle:nil];
    } else {
        upcomingView = [[PFUpcomingViewController alloc] initWithNibName:@"PFUpcomingViewController" bundle:nil];
    }
    upcomingView.delegate = self;
    upcomingView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:upcomingView animated:YES];
    
}

- (void)account {
    
}

- (void)PFApi:(id)sender getCategoryResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    
    self.obj = response;
    
    if (!refreshDataEvent) {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)PFApi:(id)sender getCategoryErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFEventCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFEventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.categoryName.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFCategoryViewController *categoryView = [[PFCategoryViewController alloc] init];
    if(IS_WIDESCREEN) {
        categoryView = [[PFCategoryViewController alloc] initWithNibName:@"PFCategoryViewController_Wide" bundle:nil];
    } else {
        categoryView = [[PFCategoryViewController alloc] initWithNibName:@"PFCategoryViewController" bundle:nil];
    }
    categoryView.delegate = self;
    categoryView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryView animated:YES];
    
}

@end
