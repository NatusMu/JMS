//
//  JMSTableViewCell.h
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgVIew;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@end
