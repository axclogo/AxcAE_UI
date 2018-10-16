//
//  ScopeCell.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/16.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "ScopeCell.h"

@implementation ScopeCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor lightGrayColor];
    
    [self.scopeDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.bottom.mas_equalTo(-15);
    }];
}

- (AxcAE_ScopeDrawView *)scopeDrawView{
    if (!_scopeDrawView) {
        _scopeDrawView = [AxcAE_ScopeDrawView new];
        _scopeDrawView.backgroundColor = kVCBackColor;
        [self addSubview:_scopeDrawView];
    }
    return _scopeDrawView;
}

@end
