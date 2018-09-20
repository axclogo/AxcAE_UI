//
//  AETestViewController.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController.h"

#import "UIViewController+AxcAE_ViewControllerExtension.h"

#import "AxcAE_UI.h"

@interface AETestViewController () 

@property(nonatomic , strong)AxcAE_ArrowDrawView *parallelogram_reverse_left;


@end

@implementation AETestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
    [self createUI];
}
- (void)createUI{
    [self.parallelogram_reverse_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    [self AxcAE_BaseOpenAccelerometer];
}
- (void)AxcAE_BaseStartDeviceGyroscope:(AxcAE_Gyroscope)gyroscope motion:(CMDeviceMotion *)motion{
    self.parallelogram_reverse_left.gyroscope = gyroscope;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.parallelogram_reverse_left startAnimation];
}

// 平行四边形 - 翻转2 向左
- (AxcAE_ArrowDrawView *)parallelogram_reverse_left{
    if (!_parallelogram_reverse_left) {
        _parallelogram_reverse_left = [AxcAE_ArrowDrawView new];
        // 实例化配置器模型
        NSMutableArray *bodys = @[].mutableCopy;
        for (int i = 0; i < 10; i ++) {
            AxcAE_ArrowBody *arrowBody = [AxcAE_ArrowBody new];
            arrowBody.image = [UIImage imageNamed:@"parallelogram_left"];
            arrowBody.tintColor = KScienceTechnologyBlue;
            arrowBody.width = 30;
            arrowBody.distance = -15; // 因为间距为负，所以计算绘制区域会向前一部分
            arrowBody.animationBlock = ^CAAnimation *{
                CABasicAnimation *animation = [AxcCAAnimation AxcBreathingWithDuration:1 maxOpacity:1.0 minOpacity:0.1];
                animation.beginTime = CACurrentMediaTime() + (10 -i) * 0.1 + 0.1; // 逆向动画时差，造成箭头向前
                return animation;
            };
            [bodys addObject:arrowBody];
        }
        _parallelogram_reverse_left.arrowBodys = bodys;
        // 转向180度
        _parallelogram_reverse_left.arrowTowardAngle = AxcAE_Angle(180);
        
        [self.view addSubview:_parallelogram_reverse_left];
    }
    return _parallelogram_reverse_left;
}

@end
