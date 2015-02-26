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
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    /* NavigationBar */
    [self setNavigationBar];
    
    /* Library code */
    self.shyNavBarManager.scrollView = self.tableView;
    
    /* Pull to refresh */
    /*
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
     */
    
    /* parameter */
    loadEvent = NO;
    noDataEvent = NO;
    refreshDataEvent = NO;
    
    self.arrObjNow = [[NSMutableArray alloc] init];
    self.arrObjUpcoming = [[NSMutableArray alloc] init];
    self.arrObjCategory = [[NSMutableArray alloc] init];
    
    [self.Api getNow];
    [self.Api getUpcoming];
    [self.Api getCategory];
    
    /* END */
    
    if (![[self.Api getStatusIntro] isEqualToString:@"close"]) {
        
        self.introView = [[PFIntroViewController alloc] initWithNibName:@"PFIntroViewController_Wide" bundle:nil];
        self.introView.delegate = self;
        [self presentModalViewController:self.introView animated:YES];
        
    }
    
    self.tableView.tableHeaderView = self.headerView;
    UIView *fv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    self.tableView.tableFooterView = fv;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

/* pull to refresh */
/*
- (void)refresh:(UIRefreshControl *)refreshControl {
    

    
}
 */

/* Set NavigationBar */

- (void)setNavigationBar {
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        
        self.navigationItem.title = @"Event";
    
    } else {
        
        self.navigationItem.title = @"กิจกรรม";
    
    }
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_notification"] style:UIBarButtonItemStyleDone target:self action:@selector(account)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

/* Setting Onclick */

- (void)setting {
    
    PFSettingViewController *settingView = [[PFSettingViewController alloc] init];
    if(IS_WIDESCREEN) {
        settingView = [[PFSettingViewController alloc] initWithNibName:@"PFSettingViewController_Wide" bundle:nil];
    } else {
        settingView = [[PFSettingViewController alloc] initWithNibName:@"PFSettingViewController" bundle:nil];
    }
    settingView.delegate = self;
    settingView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingView animated:YES];
    
}

/* Account Onclick */

- (void)account {
    
}

/* Now API */

- (void)PFApi:(id)sender getNowResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    _scrollView.clipsToBounds = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat contentOffset = 0.0f;
    
    for (int i=0; i<[[response objectForKey:@"length"] integerValue]; i++)
    {
        [self.arrObjNow addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        
        CGRect viewFrame = CGRectMake(contentOffset, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        UIView *todayView = [[UIView alloc] initWithFrame:viewFrame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 230.0f, 150.0f)];
        
        [DLImageLoader loadImageFromURL:[[[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"thumb"] objectForKey:@"url"]
                              completed:^(NSError *error, NSData *imgData) {
                                  imageView.image = [UIImage imageWithData:imgData];
                              }];
        
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageNowTaped:)];
        [todayView setTag:i];
        tap.cancelsTouchesInView = YES;
        tap.numberOfTapsRequired = 1;
        [todayView addGestureRecognizer:tap];
        
        UILabel *todayName = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 120.0f, 220.0f, 21.0f)];
        todayName.text = [[[response objectForKey:@"data"] objectAtIndex:i] objectForKey:@"name"];
        todayName.textColor = [UIColor whiteColor];
        
        UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 230.0f, 150.0f)];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = gradientView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
        [gradientView.layer insertSublayer:gradient atIndex:0];
        gradientView.alpha = 0.5;
        
        [todayView addSubview:imageView];
        [todayView addSubview:gradientView];
        [todayView addSubview:todayName];
        [_scrollView addSubview:todayView];
        
        contentOffset += todayView.frame.size.width;
        _scrollView.contentSize = CGSizeMake(contentOffset, _scrollView.frame.size.height);
    }
    
}

- (void)PFApi:(id)sender getNowErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* Now ShowAll Onclick */

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

/* Now Onclick */

- (void)imageNowTaped:(UIGestureRecognizer *)sender {
    
    //NSLog(@"%@", [self.arrObjNow objectAtIndex:sender.view.tag]);
    
    if ([[[self.arrObjNow objectAtIndex:sender.view.tag] objectForKey:@"type"] isEqualToString:@"category"]) {
        
        PFUpcomingViewController *upcomingView = [[PFUpcomingViewController alloc] init];
        if(IS_WIDESCREEN) {
            upcomingView = [[PFUpcomingViewController alloc] initWithNibName:@"PFUpcomingViewController_Wide" bundle:nil];
        } else {
            upcomingView = [[PFUpcomingViewController alloc] initWithNibName:@"PFUpcomingViewController" bundle:nil];
        }
        upcomingView.delegate = self;
        upcomingView.category_id = [[self.arrObjNow objectAtIndex:sender.view.tag] objectForKey:@"id"];
        upcomingView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:upcomingView animated:YES];
    
    } else {
        
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
    
}

/* Upcoming API */
- (void)PFApi:(id)sender getUpcomingResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    /* Gradient Image */
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.upcomingGradientView1.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.upcomingGradientView1.layer insertSublayer:gradient atIndex:0];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = self.upcomingGradientView2.bounds;
    gradient1.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.upcomingGradientView2.layer insertSublayer:gradient1 atIndex:0];
}

- (void)PFApi:(id)sender getUpcomingErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* Upcoming More Onclick */

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

/* Category API */

- (void)PFApi:(id)sender getCategoryResponse:(NSDictionary *)response {
    //NSLog(@"%@",response);
    
    self.objCategory = response;
    
    if (!refreshDataEvent) {
        [self.arrObjCategory removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjCategory addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObjCategory removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObjCategory addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self.tableView reloadData];
    
}

- (void)PFApi:(id)sender getCategoryErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

/* Table */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObjCategory count];
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
    
    NSString *urlimg = [[NSString alloc] initWithFormat:@"%@",[[[self.arrObjCategory objectAtIndex:indexPath.row] objectForKey:@"thumb"] objectForKey:@"url"]];
    
    [DLImageLoader loadImageFromURL:urlimg
                          completed:^(NSError *error, NSData *imgData) {
                              cell.categoryImage.image = [UIImage imageWithData:imgData];
                          }];
    
    cell.categoryName.text = [[self.arrObjCategory objectAtIndex:indexPath.row] objectForKey:@"name"];
    
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
    upcomingView.category_id = [[self.arrObjCategory objectAtIndex:indexPath.row] objectForKey:@"id"];
    upcomingView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:upcomingView animated:YES];
    
}

/* Setting Back */

- (void)PFSettingViewControllerBack {
    
    if ([[self.Api getReset] isEqualToString:@"YES"]) {

        [self.delegate tabbar];
        
    }
    
}

/* END */

@end
