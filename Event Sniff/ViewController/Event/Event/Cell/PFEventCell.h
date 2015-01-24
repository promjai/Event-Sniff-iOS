//
//  PFEventCell.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/13/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFEventCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *categoryName;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImage;

@end
