//
//  AETestViewController3.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/10.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController3.h"

#import "AxcAE_Scale.h"


@interface AETestViewController3 ()<AxcAE_ScaleDelegate>
@property(nonatomic , strong)AxcAE_Scale *scale;
@property(nonatomic , strong)UILabel *label;
@end

@implementation AETestViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.scale.mas_bottom).offset(0);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIColor *arcColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    self.scale.tintColor = arcColor;
    self.scale.textColor = arcColor;
    self.scale.indicatorColor = arcColor;
    self.scale.value = arc4random()%1000;
}
- (void)AxcAE_Scale:(AxcAE_Scale *)scale value:(CGFloat )value{
    self.label.text = [NSString stringWithFormat:@"%.2f",value];
}

- (AxcAE_Scale *)scale{
    if (!_scale) {
        _scale = [AxcAE_Scale new];
        _scale.backgroundColor = kVCBackColor;
        _scale.lineWidth = 1;
        _scale.delegate = self;
        _scale.count = 20;
        _scale.maxValue = 1000;
        _scale.unit = @"kg";
//        _scale.textColor = [UIColor redColor];
//        _scale.fontSize = 10;
//        _scale.isScrollAlign = YES;
        [self.view addSubview:_scale];
    }
    return _scale;
}
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_label];
    }
    return _label;
}

@end
