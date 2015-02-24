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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share"] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
    
    self.arrObj = [[NSMutableArray alloc] init];
    
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    [self.Api getEvent:self.event_id];
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

- (void)PFApi:(id)sender getEventResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    
    self.obj = response;
    
    self.ArrImgs = [[NSMutableArray alloc] init];
    self.arrcontactimg = [[NSMutableArray alloc] init];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.imgscrollview addGestureRecognizer:singleTap];
    
    self.current = @"0";
    
    for (int i=0; i<[[self.obj objectForKey:@"pictures"] count]; ++i) {
        [self.arrcontactimg addObject:[[[self.obj objectForKey:@"pictures"] objectAtIndex:i] objectForKey:@"url"]];
    }
    
    self.pageScrollView = [[PagedImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    self.pageScrollView.delegate = self;
    [self.pageScrollView setScrollViewContents:[self imageToArray:self.obj]];
    self.pageScrollView.pageControlPos = PageControlPositionCenterBottom;
    [self.imgscrollview addSubview:self.pageScrollView];
    
}

- (void)PFApi:(id)sender getEventErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
    
}

- (void)PagedImageScrollView:(id)sender current:(NSString *)current{
    self.current = current;
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    int sum;
    sum = [self.current intValue]/32;
    NSString *num = [NSString stringWithFormat:@"%d",sum];
    //[self.delegate PFGalleryViewController:self sum:self.arrcontactimg current:num];
    
}

- (NSArray *)imageToArray:(NSDictionary *)images {
    int countPicture = [[images objectForKey:@"pictures"] count];
    for (int i = 0; i < countPicture; i++) {
        NSString *urlStr = [[NSString alloc] initWithFormat:@"%@",[[[images objectForKey:@"pictures"] objectAtIndex:i] objectForKey:@"url"]];
        
        [self.ArrImgs addObject:urlStr];
    }
    return self.ArrImgs;
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
