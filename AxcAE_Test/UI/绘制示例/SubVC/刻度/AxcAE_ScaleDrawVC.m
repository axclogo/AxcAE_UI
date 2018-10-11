//
//  AxcAE_ScaleDrawVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/11.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ScaleDrawVC.h"
#import "AxcAE_Scale.h"

@interface AxcAE_ScaleDrawVC ()<AxcAE_ScaleDelegate>
@property(nonatomic , strong)AxcAE_Scale *scale;
@property(nonatomic , strong)UILabel *label;
@end

@implementation AxcAE_ScaleDrawVC

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
        make.top.mas_equalTo(self.scale.mas_bottom).offset(10);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIColor *arcColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    self.scale.tintColor = arcColor;
    self.scale.textColor = arcColor;
    self.scale.indicatorColor = arcColor;
    self.scale.value = arc4random()%1000;
    [self.scale reloadTextLayer]; // 刷新文字，执行代理方法
}
#pragma mark - 代理
- (void)AxcAE_Scale:(AxcAE_Scale *)scale value:(CGFloat )value{
    self.label.text = [NSString stringWithFormat:@"%.2f",value];
}
- (void)AxcAE_Scale:(AxcAE_Scale *)scale textLayer:(CATextLayer *)textLayer idx:(NSInteger)idx{
    if (idx == 3) { // 第四个文字Layer设置
        textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    }
}

- (AxcAE_Scale *)scale{
    if (!_scale) {
        _scale = [AxcAE_Scale new];
        _scale.delegate = self;
        _scale.backgroundColor = kVCBackColor;
        
        _scale.lineWidth = 1;   // 刻度线宽
        _scale.count = 20;      // 一共几个大刻度
        _scale.maxValue = 1000; // 最大值
        _scale.unit = @"kg";    // 文字单位
        //        _scale.fontSize = 10;         // 文字字号
        
        _scale.isScrollAlign = YES;   // 开启自动对齐
        _scale.isGradient = NO;                 // 关闭渐变效果
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
