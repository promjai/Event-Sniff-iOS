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

BOOL loadUpcoming;
BOOL noDataUpcoming;
BOOL refreshDataUpcoming;

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
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"See all" style:UIBarButtonItemStylePlain target:self action:@selector(seeAll)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    loadUpcoming = NO;
    noDataUpcoming = NO;
    refreshDataUpcoming = NO;
    
    self.arrObj = [[NSMutableArray alloc] init];
    
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    [self.Api getCategoryList:self.category_id];
    
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

- (void)PFApi:(id)sender getCategoryListResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    
    self.obj= response;
    
    if (!refreshDataUpcoming) {
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
    self.tableView.tableFooterView = self.footerView;
    
}

- (void)PFApi:(id)sender getCategoryListErrorResponse:(NSString *)errorResponse {
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
    PFUpcomingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFUpcomingCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFUpcomingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.upcomingImage.layer.masksToBounds = YES;
    cell.upcomingImage.contentMode = UIViewContentModeScaleAspectFill;
    
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"]];
    
    [DLImageLoader loadImageFromURL:urlimg
                          completed:^(NSError *error, NSData *imgData) {
                              cell.upcomingImage.image = [UIImage imageWithData:imgData];
                          }];
    
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
    eventdetailView.event_id = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"id"];
    eventdetailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eventdetailView animated:YES];
    
}


@end
