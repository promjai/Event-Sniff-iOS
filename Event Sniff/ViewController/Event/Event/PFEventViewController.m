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
    
    [self.headerView addSubview:self.searchBar];
    
    self.tableView.tableHeaderView = self.headerView;
    
    //
    _scrollView.clipsToBounds = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat contentOffset = 0.0f;
    NSArray *imageFilenames = [NSArray arrayWithObjects:@"mborsten.jpg",
                               @"arepty.jpg",
                               @"bmf.jpg",
                               @"mgprot.jpg",
                               @"sgaw.jpg",
                               @"tarasis.jpg",
                               @"uliwitness.jpg",
                               @"cgodefroy.jpg",
                               nil];
    
    for (NSString *singleImageFilename in imageFilenames) {
        CGRect viewFrame = CGRectMake(contentOffset, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        UIView *todayView = [[UIView alloc] initWithFrame:viewFrame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 230.0f, 150.0f)];
        imageView.image = [UIImage imageNamed:singleImageFilename];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UILabel *todayName = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 120.0f, 100.0f, 21.0f)];
        todayName.text = @"Promotion";
        todayName.textColor = [UIColor whiteColor];
        
        UILabel *todayDate = [[UILabel alloc] initWithFrame:CGRectMake(130.0f, 120.0f, 100.0f, 21.0f)];
        todayDate.text = @"27/1/2015";
        todayDate.textColor = [UIColor whiteColor];
        todayDate.textAlignment = NSTextAlignmentRight;
        
        UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 230.0f, 150.0f)];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = gradientView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
        [gradientView.layer insertSublayer:gradient atIndex:0];
        gradientView.alpha = 0.5;
        
        [todayView addSubview:imageView];
        [todayView addSubview:gradientView];
        [todayView addSubview:todayName];
        //[todayView addSubview:todayDate];
        [_scrollView addSubview:todayView];
        
        contentOffset += todayView.frame.size.width;
        _scrollView.contentSize = CGSizeMake(contentOffset, _scrollView.frame.size.height);
    }
    
    //
    
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
    
    cell.categoryImage.layer.masksToBounds = YES;
    cell.categoryImage.contentMode = UIViewContentModeScaleAspectFill;
    
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"]];
    
    [DLImageLoader loadImageFromURL:urlimg
                          completed:^(NSError *error, NSData *imgData) {
                              cell.categoryImage.image = [UIImage imageWithData:imgData];
                          }];
    
    cell.categoryName.text = [[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    //image circle
    //cell.categoryImage.layer.cornerRadius = cell.categoryImage.frame.size.width / 2;
    //cell.categoryImage.clipsToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
