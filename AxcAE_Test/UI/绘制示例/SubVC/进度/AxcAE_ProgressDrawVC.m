//
//  AxcAE_ProgressDrawVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/21.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ProgressDrawVC.h"
@interface AxcAE_ProgressDrawVC ()
@property(nonatomic , strong)NSMutableArray <AxcAE_ProgressDrawView *>*progressDrawViews;
@end
@implementation AxcAE_ProgressDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCBackColor;
}
- (void)createUI{
    AxcAE_ProgressDrawView *movePoint = nil;
    NSInteger rowCount = 8;
    for (int i = 1; i <= 16; i ++) {
        AxcAE_ProgressDrawView *progressDrawView = [AxcAE_ProgressDrawView new];
        progressDrawView.style = (i-1)/2;
        progressDrawView.gridSpacing = i%2 ? 0 : 3;                    // 格子间距 为零时自动全填充
        [self.view addSubview:progressDrawView];
        [progressDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat height = 150;
            if (!movePoint) { // 排头
                make.left.mas_equalTo(20);
            }else{
                make.left.mas_equalTo(movePoint.mas_right).offset(10);
            }
            make.top.mas_equalTo((height + 20) * ((i-1)/rowCount) + 100);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(height);
        }];
        if (progressDrawView.style == AxcAE_ProgressDrawStyleThermometer||
            progressDrawView.style == AxcAE_ProgressDrawStyleDialGauge) {
            progressDrawView.contentSpacing = 0;
        }
        progressDrawView.proportion = arc4random() %100 / 100.0f; // 比率 0-1
        movePoint = !(i%rowCount) ? nil : progressDrawView;
        [self.progressDrawViews addObject:progressDrawView];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.progressDrawViews enumerateObjectsUsingBlock:^(AxcAE_ProgressDrawView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.proportion = arc4random() %100 / 100.0f; // 比率 0-1
        UIColor *arcColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
        obj.tintColor = arcColor;       // 渲染颜色
        obj.gridFillColor = arcColor;   // 格子填充色
        obj.gridBorderColor = arcColor; // 格子边框色
    }];
}
- (NSMutableArray *)progressDrawViews{
    if (!_progressDrawViews) _progressDrawViews = @[].mutableCopy;
    return _progressDrawViews;
}
@end
