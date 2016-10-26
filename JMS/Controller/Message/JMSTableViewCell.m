//
//  JMSTableViewCell.m
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import "JMSTableViewCell.h"

@implementation JMSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _innerView.layer.cornerRadius = 5;
    _innerView.layer.shadowColor = [UIColor grayColor].CGColor;
    _innerView.layer.shadowOffset = CGSizeMake(10, 10);
    _innerView.layer.shadowOpacity = 0.5;
    _innerView.layer.shadowRadius = 5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
