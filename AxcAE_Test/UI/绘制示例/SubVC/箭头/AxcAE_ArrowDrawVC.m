//
//  AxcAE_ArrowDrawVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ArrowDrawVC.h"

@interface AxcAE_ArrowDrawVC ()
@property(nonatomic , strong)AxcAE_ArrowDrawView *arrowDrawView_headless;
@property(nonatomic , strong)AxcAE_ArrowDrawView *arrowDrawView_head;
@property(nonatomic , strong)AxcAE_ArrowDrawView *parallelogram;
@property(nonatomic , strong)AxcAE_ArrowDrawView *parallelogram_reverse;
@property(nonatomic , strong)AxcAE_ArrowDrawView *parallelogram_reverse_left;
@end

@implementation AxcAE_ArrowDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCBackColor;
    [self createStartAnimationBtn];
}
- (void)createUI{
    [self.arrowDrawView_headless mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    [self.arrowDrawView_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.arrowDrawView_headless.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    [self.parallelogram mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.arrowDrawView_head.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    [self.parallelogram_reverse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.parallelogram.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    [self.parallelogram_reverse_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.parallelogram_reverse.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    
}
- (void)click_startAnimationBtn{
    [self.arrowDrawView_headless startAnimation];
    [self.arrowDrawView_head startAnimation];
    [self.parallelogram startAnimation];
    [self.parallelogram_reverse startAnimation];
    [self.parallelogram_reverse_left startAnimation];
}

#pragma mark - 懒加载
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
// 平行四边形 - 翻转
- (AxcAE_ArrowDrawView *)parallelogram_reverse{
    if (!_parallelogram_reverse) {
        _parallelogram_reverse = [AxcAE_ArrowDrawView new];
        // 实例化配置器模型
        NSMutableArray *bodys = @[].mutableCopy;
        for (int i = 0; i < 10; i ++) {
            AxcAE_ArrowBody *arrowBody = [AxcAE_ArrowBody new];
            arrowBody.image = [UIImage imageNamed:@"parallelogram"];
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
        _parallelogram_reverse.arrowBodys = bodys;
        // 转向180度
        _parallelogram_reverse.arrowTowardAngle = AxcAE_Angle(180);
        
        [self.view addSubview:_parallelogram_reverse];
    }
    return _parallelogram_reverse;
}
// 平行四边形
- (AxcAE_ArrowDrawView *)parallelogram{
    if (!_parallelogram) {
        _parallelogram = [AxcAE_ArrowDrawView new];
        // 实例化配置器模型
        NSMutableArray *bodys = @[].mutableCopy;
        for (int i = 0; i < 10; i ++) {
            AxcAE_ArrowBody *arrowBody = [AxcAE_ArrowBody new];
            arrowBody.image = [UIImage imageNamed:@"parallelogram"];
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
        _parallelogram.arrowBodys = bodys;
        
        [self.view addSubview:_parallelogram];
    }
    return _parallelogram;
}
// 带头箭头
- (AxcAE_ArrowDrawView *)arrowDrawView_head{
    if (!_arrowDrawView_head) {
        _arrowDrawView_head = [AxcAE_ArrowDrawView new];
        
        
        NSMutableArray *bodys = @[].mutableCopy;
        for (int i = 0; i < 6; i ++) {
            AxcAE_ArrowBody *arrowBody = [AxcAE_ArrowBody new];
            arrowBody.tintColor = KScienceTechnologyBlue;
            if (!i) { // 第一个
                arrowBody.image = [UIImage imageNamed:@"double_right"];
                arrowBody.width = 40;
                arrowBody.distance = -20;
            }else{
                arrowBody.image = [UIImage imageNamed:@"point"];
                arrowBody.width = 5;
                arrowBody.distance = 5;
                arrowBody.layer.contentsGravity = kCAGravityResizeAspect; // 设置图片不失真等比绘制
            }
            arrowBody.animationBlock = ^CAAnimation *{
                CABasicAnimation *animation = [AxcCAAnimation AxcBreathingWithDuration:0.5 maxOpacity:1.0 minOpacity:0.1];
                animation.beginTime = CACurrentMediaTime() + (10 -i) * 0.1; // 逆向动画时差，造成箭头向前
                return animation;
            };
            [bodys addObject:arrowBody];
        }
        _arrowDrawView_head.arrowBodys = bodys;
        
        [self.view addSubview:_arrowDrawView_head];
    }
    return _arrowDrawView_head;
}
// 无头箭头
- (AxcAE_ArrowDrawView *)arrowDrawView_headless{
    if (!_arrowDrawView_headless) {
        _arrowDrawView_headless = [AxcAE_ArrowDrawView new];
        // 实例化配置器模型
        NSMutableArray *bodys = @[].mutableCopy;
        for (int i = 0; i < 10; i ++) {
            AxcAE_ArrowBody *arrowBody = [AxcAE_ArrowBody new];
            arrowBody.image = [UIImage imageNamed:@"ae_right2"];
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
        _arrowDrawView_headless.arrowBodys = bodys;
        
        [self.view addSubview:_arrowDrawView_headless];
    }
    return _arrowDrawView_headless;
}

@end


