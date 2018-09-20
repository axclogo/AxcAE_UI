//
//  AxcLayerBrush.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcLayerBrush.h"

/*
 设置线段的链接方式
 棱角
 NSString *const kCALineJoinMiter;
 平滑
 NSString *const kCALineJoinRound;
 折线
 NSString *const kCALineJoinBevel;
 */

@implementation AxcLayerBrush

// 实线
+ (CAShapeLayer *)AxcLayerDottedLineWidth:(CGFloat )lineWidth
                              strokeColor:(UIColor *)strokeColor
                               bezierPath:(UIBezierPath *)bezierPath{
    return [self AxcLayerDottedLineWidth:lineWidth
                             strokeColor:strokeColor
                              bezierPath:bezierPath
                         lineDashPattern:nil];
}
// 虚线Layer
+ (CAShapeLayer *)AxcLayerDottedLineWidth:(CGFloat )lineWidth
                              strokeColor:(UIColor *)strokeColor
                               bezierPath:(UIBezierPath *)bezierPath
                          lineDashPattern:(NSArray <NSNumber *>*)lineDashPattern{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = lineWidth;
    layer.fillColor = nil;
    layer.strokeColor = strokeColor.CGColor;
    if (lineDashPattern) layer.lineDashPattern = lineDashPattern;
    layer.anchorPoint = CGPointZero;
    layer.drawPath = bezierPath; // 将绘制路径保存关联给Layer层，方便画板进行布局
    return layer;
}


@end
