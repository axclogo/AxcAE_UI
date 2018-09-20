//
//  AxcCAAnimation.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 包含一些预设动画
 */
@interface AxcCAAnimation : NSObject

#pragma mark - 线性绘制/贝塞尔绘制

/**
 线性绘制
 @param duration 绘制时间
 @return 动画对象
 */
+(CABasicAnimation *)AxcDrawLineDuration:(CGFloat )duration;

/**
 线性绘制
 @param duration 绘制时间
 @param timingFunction 时间曲线
 @return 动画对象
 */
+(CABasicAnimation *)AxcDrawLineDuration:(CGFloat )duration
                          timingFunction:(NSString *)timingFunction;

#pragma mark - 旋转动画

/**
 旋转效果动画 -1
 @param duration 周期时间
 @return 动画对象
 */
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration;

/**
 旋转效果动画 -2
 @param duration 周期时间
 @param clockwise 是否顺时针
 @return 动画对象
 */
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration
                                clockwise:(BOOL )clockwise;

/**
 旋转效果动画 -3
 @param duration 周期时间
 @param clockwise 是否顺时针
 @param timingFunction 时间函数
 @return 动画对象
 */
+ (CABasicAnimation *)AxcRotatingDuration:(CGFloat )duration
                                clockwise:(BOOL )clockwise
                           timingFunction:(NSString *)timingFunction;

#pragma mark - 呼吸/闪烁效果动画
/**
 呼吸效果动画 - 1
 @param duration 周期时间
 @return 动画对象
 */
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration;

/**
 呼吸效果动画 - 2
 @param duration 周期时间
 @param maxOpacity 最大透明度
 @param minOpacity 最小透明度
 @return 动画对象
 */
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration
                                   maxOpacity:(CGFloat )maxOpacity
                                   minOpacity:(CGFloat )minOpacity;

/**
 呼吸效果动画 - 3
 @param duration 周期时间
 @param maxOpacity 最大透明度
 @param minOpacity 最小透明度
 @param timingFunction 时间曲线
 @return 动画对象
 */
+(CABasicAnimation *)AxcBreathingWithDuration:(CGFloat )duration
                                   maxOpacity:(CGFloat )maxOpacity
                                   minOpacity:(CGFloat )minOpacity
                               timingFunction:(NSString *)timingFunction;

@end
