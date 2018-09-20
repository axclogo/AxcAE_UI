//
//  AxcLayerBrush.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CAShapeLayer+AxcAE_LayerAttribute.h"

/**
 绘制画笔
 */
@interface AxcLayerBrush : NSObject


/**
 实线的方式绘制
 @param lineWidth 线宽
 @param strokeColor 线颜色
 @param bezierPath 绘制路径动作
 @return CAShapeLayer
 */
+ (CAShapeLayer *)AxcLayerDottedLineWidth:(CGFloat )lineWidth
                              strokeColor:(UIColor *)strokeColor
                               bezierPath:(UIBezierPath *)bezierPath;

/**
 虚线的方式绘制
 @param lineWidth 线宽
 @param strokeColor 线颜色
 @param bezierPath 绘制路径动作
 @param lineDashPattern 虚线参数
 @return CAShapeLayer
 */
+ (CAShapeLayer *)AxcLayerDottedLineWidth:(CGFloat )lineWidth
                              strokeColor:(UIColor *)strokeColor
                               bezierPath:(UIBezierPath *)bezierPath
                          lineDashPattern:(NSArray <NSNumber *>*)lineDashPattern;

@end
