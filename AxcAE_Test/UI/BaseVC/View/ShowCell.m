//
//  ShowCell.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ShowModel *)model{
    _model = model;
    self.titleLabel.text = _model.title;
    self.disTitleLabel.text = _model.disTitle;
}

@end
