//
//  PFCommentEventCell.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/29/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "PFCommentEventCell.h"

@implementation PFCommentEventCell

- (void)awakeFromNib {
    // Initialization code
    
    self.commentImage.layer.masksToBounds = YES;
    self.commentImage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.commentImage.layer.cornerRadius = self.commentImage.frame.size.width / 2;
    self.commentImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
