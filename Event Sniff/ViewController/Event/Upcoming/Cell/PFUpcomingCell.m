//
//  PFUpcomingCell.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/13/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFUpcomingCell.h"

@implementation PFUpcomingCell

- (void)awakeFromNib {
    // Initialization code
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
