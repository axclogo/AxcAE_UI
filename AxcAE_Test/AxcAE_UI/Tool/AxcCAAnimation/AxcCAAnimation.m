//
//  AxcCAAnimation.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcCAAnimation.h"

@implementation AxcCAAnimation

#pragma mark - 线性绘制/贝塞尔绘制
+(CABasicAnimation *)AxcDrawLineDuration:(CGFloat )duration{
    return [self AxcDrawLineDuration:duration timingFunction:kCAMediaTimingFunctionLinear];
}
+(CABasicAnimation *)AxcDrawLineDuration:(CGFloat )duration
                          timingFunction:(NSString *)timingFunction{
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = duration;// 时间
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1];// 划线段的百分之多少
    pathAniamtion.autoreverses = NO;
    return pathAniamtion;
}

#pragma mark - 旋转动画
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration{
    return [self AxcRotatingDuration:duration
                           clockwise:YES];
}
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration
                                clockwise:(BOOL )clockwise{
    return [self AxcRotatingDuration:duration
                           clockwise:clockwise
                      timingFunction:kCAMediaTimingFunctionLinear];
}
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration
                                clockwise:(BOOL )clockwise
                           timingFunction:(NSString *)timingFunction{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [self settingCABasicAnimation:animation
                        fromValue:@(0)
                          toValue:clockwise? @(2*M_PI) : @(-2*M_PI)
                         duration:duration
                   timingFunction:timingFunction];
    animation.autoreverses = NO; // 不用反复旋转
    return animation;
}

#pragma mark - 呼吸/闪烁效果动画
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration{
    return [self AxcBreathingWithDuration:duration
                               maxOpacity:1.0
                               minOpacity:0];
}
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration
                                   maxOpacity:(CGFloat )maxOpacity
                                   minOpacity:(CGFloat )minOpacity{
    return [self AxcBreathingWithDuration:duration
                               maxOpacity:maxOpacity
                               minOpacity:minOpacity
                           timingFunction:kCAMediaTimingFunctionEaseIn];
}
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration
                                   maxOpacity:(CGFloat )maxOpacity
                                   minOpacity:(CGFloat )minOpacity
                               timingFunction:(NSString *)timingFunction{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    [self settingCABasicAnimation:animation
                        fromValue:@(maxOpacity)
                          toValue:@(minOpacity)
                         duration:duration
                   timingFunction:timingFunction];
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark - 共用函数
+ (void)settingCABasicAnimation:(CABasicAnimation *)animation
                      fromValue:(NSNumber *)fromValue
                        toValue:(NSNumber *)toValue
                       duration:(CGFloat )duration
                 timingFunction:(NSString *)timingFunction{
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:timingFunction];
}


@end
