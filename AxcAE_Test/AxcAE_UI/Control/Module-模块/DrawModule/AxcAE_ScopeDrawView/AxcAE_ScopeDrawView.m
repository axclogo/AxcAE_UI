//
//  AxcAE_ScopeDrawView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/16.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcAE_ScopeDrawView.h"

@interface AxcAE_ScopeDrawView ()
@property(nonatomic , assign)CGFloat radius;
@property(nonatomic , assign)CGPoint drawCenter;
@property(nonatomic , strong)NSArray <CAShapeLayer *>*layers;
@end
@implementation AxcAE_ScopeDrawView

- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.style = AxcAE_ScopeDrawStyleXArrow;
    self.shapeLayer_1.strokeColor = self.shapeLayer_2.strokeColor =
    self.shapeLayer_3.strokeColor = self.shapeLayer_4.strokeColor
    = self.tintColor.CGColor;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.shapeLayer_1.frame = self.shapeLayer_2.frame = self.shapeLayer_3.frame = self.shapeLayer_4.frame
    = CGRectMake(0, 0, self.axcAE_Width, self.axcAE_Height);
    self.radius = MIN(self.axcAE_Width, self.axcAE_Height)/2 - self.lineWidth/2;
    self.drawCenter = CGPointMake(self.axcAE_Width/2, self.axcAE_Height/2);
    self.layer.masksToBounds = NO; // 永远不切边
}
-(void)setStyle:(AxcAE_ScopeDrawStyle)style{
    _style = style;
    [self removeBezierPath];
    [self stopAnimation];
    [self redraw]; // 重绘
}
- (void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self redraw]; // 重绘
}
- (void)redraw{
    switch (self.style) {
        case AxcAE_ScopeDrawStyleThreePhase:{
            [self drawThreePhase];
        }break;
        case AxcAE_ScopeDrawStyleX:{
            [self drawX];
        }break;
        case AxcAE_ScopeDrawStyleXArrow:{
            [self drawXArrow];
        }break;
        case AxcAE_ScopeDrawStyleXArrowRectangular:{
            [self drawXArrowRectangular];
        }break;
           
        default:{
            
        }break;
    }
}
#pragma mark - 类型
#pragma mark 三相瞄准
- (void)drawThreePhase{
    // 1外沿圆
    UIBezierPath *bezierPath_1 = [AxcDrawPath AxcDrawArcCenter:self.drawCenter
                                                        radius:self.radius];
    // 十字准星
    [bezierPath_1 appendPath:[AxcDrawPath AxcDrawReticleCenter:self.drawCenter
                                                          size:CGSizeMake(self.radius/8, self.radius/8)]];
    self.shapeLayer_1.path = bezierPath_1.CGPath;
    // 三相点位角
    UIBezierPath *bezierPath_2 = [AxcDrawPath AxcDrawCircularRadiationCenter:self.drawCenter
                                                                      radius:self.radius -5
                                                                 lineHeights:@[@(self.radius - self.radius/5), @(self.radius - self.radius/5),
                                                                               @(self.radius - self.radius/5)]
                                                                     outside:NO];
    self.shapeLayer_2.path = bezierPath_2.CGPath;
    self.shapeLayer_2.lineWidth = self.radius/20;
    // 3虚线圆弧
    UIBezierPath *bezierPath_3 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius/2
                                                                 count:3
                                                                radian:60
                                                            startAngle:-60];
    self.shapeLayer_3.path = bezierPath_3.CGPath;
    self.shapeLayer_3.lineDashPattern = @[@(1),@(2)];
    self.shapeLayer_3.lineWidth = self.radius/20;
    // 4圆弧块状
    UIBezierPath *bezierPath_4 = [AxcDrawPath AxcDrawBlockArcRingCenter:self.drawCenter
                                                          outsideRadius:self.radius-10
                                                            blockRadius:self.radius/10
                                                             blockCount:3
                                                           angleSpacing:60
                                                             startAngle:-60];
    self.shapeLayer_4.path = bezierPath_4.CGPath;
    self.shapeLayer_4.lineWidth = 1;
}
#pragma mark X型瞄具
- (void)drawX{
    // 1外沿圆
    UIBezierPath *bezierPath_1 = [AxcDrawPath AxcDrawArcCenter:self.drawCenter
                                                        radius:self.radius - self.radius/40];
    self.shapeLayer_1.path = bezierPath_1.CGPath;
    self.shapeLayer_1.lineWidth = self.radius/20;
    // 1内圆
    CGFloat spacing_1_2 = self.radius / 10;
    UIBezierPath *bezierPath_2 = [AxcDrawPath AxcDrawArcCenter:self.drawCenter
                                                        radius:self.radius - spacing_1_2];
    // 十字准星
    [bezierPath_2 appendPath:[AxcDrawPath AxcDrawReticleCenter:self.drawCenter
                                                          size:CGSizeMake(self.radius/10, self.radius/10)]];
    self.shapeLayer_2.path = bezierPath_2.CGPath;
    self.shapeLayer_2.lineWidth = 1;
    // 3虚线圆弧
    CGFloat spacing_2_3 = spacing_1_2 *3;
    UIBezierPath *bezierPath_3 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius - spacing_2_3
                                                                 count:2
                                                                radian:60
                                                            startAngle:-30 ];
    self.shapeLayer_3.path = bezierPath_3.CGPath;
    self.shapeLayer_3.lineDashPattern = @[@(1),@(2)];
    self.shapeLayer_3.lineWidth = self.radius/20;
    // 4X型锁
    UIBezierPath *bezierPath_4 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius/2
                                                                 count:4
                                                                radian:2
                                                            startAngle:-46];
    self.shapeLayer_4.path = bezierPath_4.CGPath;
    self.shapeLayer_4.lineWidth = self.radius/2;

}
#pragma mark X型指向箭头瞄具
#define XArrow_SpacingAngle (self.radius/5)
#define XArrow_SpacingHeight (XArrow_SpacingAngle - 3)
- (void)drawXArrow{
    // 绘制4圆弧
    UIBezierPath *bezierPath_1 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                              radius:self.radius
                                                               count:4
                                                              radian:90 - XArrow_SpacingAngle
                                                          startAngle:-90+XArrow_SpacingAngle/2];
    // 4个向外的箭头
    [bezierPath_1 appendPath:[AxcDrawPath AxcDrawPointArrowCenter:self.drawCenter
                                                         radius:self.radius
                                                    arrowRadius:XArrow_SpacingHeight
                                                    arrowRadian:15
                                                     arrowCount:4
                                                    connections:YES
                                                 arcConnections:YES
                                                        outSide:YES
                                                     startAngle:-45-15/2
                                                   openingAngle:0
                                                      clockwise:YES]];
    self.shapeLayer_1.path = bezierPath_1.CGPath;
    // 2向内圆弧
    CGFloat spacing_1_2 = self.radius / 8;
    UIBezierPath *bezierPath_2 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius - spacing_1_2
                                                                 count:2
                                                                radian:60
                                                            startAngle:-30
                                                          openingAngle:0
                                                            connection:NO];
    [bezierPath_2 appendPath:[AxcDrawPath AxcDrawPointArrowCenter:self.drawCenter
                                                           radius:self.radius - spacing_1_2
                                                      arrowRadius:XArrow_SpacingHeight/2
                                                      arrowRadian:XArrow_SpacingAngle/2
                                                       arrowCount:2
                                                      connections:YES
                                                   arcConnections:YES
                                                          outSide:NO
                                                       startAngle:-XArrow_SpacingAngle/4
                                                     openingAngle:0
                                                        clockwise:YES]];
    self.shapeLayer_2.path = bezierPath_2.CGPath;
    // 3虚线圆弧
    CGFloat spacing_2_3 = self.radius / 4;
    UIBezierPath *bezierPath_3 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius - spacing_1_2 - spacing_2_3
                                                                 count:4
                                                                radian:90 - XArrow_SpacingAngle
                                                            startAngle:-(90 - XArrow_SpacingAngle)/2
                                                          openingAngle:0];
    self.shapeLayer_3.path = bezierPath_3.CGPath;
    self.shapeLayer_3.lineDashPattern = @[@(1),@(2)];
    self.shapeLayer_3.lineWidth = self.radius/20;
    // 4X型锁
    CGFloat spacing_3_4 = 5;
    UIBezierPath *bezierPath_4 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius - spacing_1_2 - spacing_2_3 - spacing_3_4
                                                                 count:4
                                                                radian:1
                                                            startAngle:-((90 - XArrow_SpacingAngle)/2 + XArrow_SpacingAngle/2)];
    self.shapeLayer_4.path = bezierPath_4.CGPath;
    self.shapeLayer_4.lineWidth = self.radius/2;
}
#pragma mark X型指向矩形瞄具
- (void)drawXArrowRectangular{
    // 1外沿的同心圆
    UIBezierPath *bezierPath_1 = [AxcDrawPath AxcDrawArcCenter:self.drawCenter
                                                      radius:self.radius];
    [bezierPath_1 appendPath:[AxcDrawPath AxcDrawArcCenter:self.drawCenter
                                                  radius:self.radius - 5]];
    [bezierPath_1 appendPath:[AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                            radius:self.radius - 10
                                                             count:4
                                                            radian:15
                                                        startAngle:-90-15/2]];
    self.shapeLayer_1.path = bezierPath_1.CGPath;
    self.shapeLayer_1.lineWidth = 1;
    // 2矩形
    CGFloat spacing_1_2 = self.radius/4;
    UIBezierPath *bezierPath_2 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius - spacing_1_2
                                                                 count:6
                                                                radian:2
                                                            startAngle:-1];
    // 十字准星
    [bezierPath_2 appendPath:[AxcDrawPath AxcDrawReticleCenter:self.drawCenter
                                                          size:CGSizeMake(self.radius/8, self.radius/8)]];
    self.shapeLayer_2.path = bezierPath_2.CGPath;
    self.shapeLayer_2.lineWidth = 4;
    
    CGFloat distance = self.radius - spacing_1_2*2; // 离外圆距离
    CGFloat angle = 20; // 开合角
    CGFloat longSideLength = self.radius/4/2; // 长边
    CGFloat shortSideLength = longSideLength/2; // 短边
    NSMutableArray *points = @[].mutableCopy; // 直接运用极坐标换算XY坐标系
    // 左上角
    CGPoint point_1 = [AxcPolarAxis AxcPolarAxisCenter:self.drawCenter distance:distance radian:-180+angle];
    [points addObject:[NSValue valueWithCGPoint:point_1]];
    CGPoint point_2 = [AxcPolarAxis AxcPolarAxisCenter:point_1 distance:shortSideLength radian:-90];
    [points addObject:[NSValue valueWithCGPoint:point_2]];
    CGPoint point_3 = [AxcPolarAxis AxcPolarAxisCenter:point_2 distance:longSideLength radian:0];
    [points addObject:[NSValue valueWithCGPoint:point_3]];
    [points addObject:[NSNull null]];
    // 右上角
    CGPoint point_4 = [AxcPolarAxis AxcPolarAxisCenter:self.drawCenter distance:distance radian:0-angle];
    [points addObject:[NSValue valueWithCGPoint:point_4]];
    CGPoint point_5 = [AxcPolarAxis AxcPolarAxisCenter:point_4 distance:shortSideLength radian:-90];
    [points addObject:[NSValue valueWithCGPoint:point_5]];
    CGPoint point_6 = [AxcPolarAxis AxcPolarAxisCenter:point_5 distance:longSideLength radian:180];
    [points addObject:[NSValue valueWithCGPoint:point_6]];
    [points addObject:[NSNull null]];
    // 左下角
    CGPoint point_7 = [AxcPolarAxis AxcPolarAxisCenter:self.drawCenter distance:distance radian:-180-angle];
    [points addObject:[NSValue valueWithCGPoint:point_7]];
    CGPoint point_8 = [AxcPolarAxis AxcPolarAxisCenter:point_7 distance:shortSideLength radian:90];
    [points addObject:[NSValue valueWithCGPoint:point_8]];
    CGPoint point_9 = [AxcPolarAxis AxcPolarAxisCenter:point_8 distance:longSideLength radian:0];
    [points addObject:[NSValue valueWithCGPoint:point_9]];
    [points addObject:[NSNull null]];
    // 右下角
    CGPoint point_10 = [AxcPolarAxis AxcPolarAxisCenter:self.drawCenter distance:distance radian:angle];
    [points addObject:[NSValue valueWithCGPoint:point_10]];
    CGPoint point_11 = [AxcPolarAxis AxcPolarAxisCenter:point_10 distance:shortSideLength radian:90];
    [points addObject:[NSValue valueWithCGPoint:point_11]];
    CGPoint point_12 = [AxcPolarAxis AxcPolarAxisCenter:point_11 distance:longSideLength radian:180];
    [points addObject:[NSValue valueWithCGPoint:point_12]];
    [points addObject:[NSNull null]];
    // 绘制
    UIBezierPath *bezierPath_3 = [AxcDrawPath AxcDrawLineArray:points];
    // 箭头
    [bezierPath_3 appendPath:[AxcDrawPath AxcDrawPointArrowCenter:self.drawCenter
                                                           radius:self.radius/2
                                                      arrowRadius:XArrow_SpacingHeight/2
                                                      arrowRadian:XArrow_SpacingAngle/2
                                                       arrowCount:2
                                                      connections:NO
                                                   arcConnections:NO
                                                          outSide:NO
                                                       startAngle:-XArrow_SpacingAngle/4-90
                                                     openingAngle:0
                                                        clockwise:YES]];
    self.shapeLayer_3.path = bezierPath_3.CGPath;
    self.shapeLayer_3.lineWidth = 2;
    // 4X型锁
    UIBezierPath *bezierPath_4 = [AxcDrawPath AxcDrawCircularArcCenter:self.drawCenter
                                                                radius:self.radius/2 - 5
                                                                 count:4
                                                                radian:1
                                                            startAngle:-((90 - XArrow_SpacingAngle)/2 + XArrow_SpacingAngle/2)];
    self.shapeLayer_4.path = bezierPath_4.CGPath;
    self.shapeLayer_4.lineWidth = self.radius/2;
}

#define DrawAimation @"Animation"
- (void)draw{
    [self drawTime:0.7];
}
- (void)drawTime:(CGFloat )time{
    [self drawTime:time timingFunction:kCAMediaTimingFunctionEaseInEaseOut];
}
- (void)drawTime:(CGFloat )time timingFunction:(NSString *)timingFunction{
    [self.layers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addAnimation:[AxcCAAnimation AxcDrawLineDuration:time timingFunction:timingFunction] forKey:DrawAimation];
    }];
}
#define ContinuousAnimation @"ContinuousAnimation"
- (void)startContinuousAnimation{
    CABasicAnimation *animation_1;
    CABasicAnimation *animation_2;
    CABasicAnimation *animation_3;
    CABasicAnimation *animation_4;
    switch (self.style) {
        case AxcAE_ScopeDrawStyleThreePhase:{
            animation_2 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(360))];
            animation_3 = [AxcCAAnimation AxcScaleRepeatDuration:0.6 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7)];
            animation_4 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(-360))];
        }break;
        case AxcAE_ScopeDrawStyleX:{
            animation_3 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(360))];
            animation_4 = [AxcCAAnimation AxcScaleRepeatDuration:0.33 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7)];
        }break;
        case AxcAE_ScopeDrawStyleXArrow:{
            animation_1 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(-90))];
            animation_2 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(360))];
            animation_3 = [AxcCAAnimation AxcScaleRepeatDuration:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7)];
            animation_4 = [AxcCAAnimation AxcScaleRepeatDuration:0.33 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7)];
        }break;
        case AxcAE_ScopeDrawStyleXArrowRectangular:{
            animation_1 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(-90))];
            animation_2 = [AxcCAAnimation AxcRotatingRepeatDuration:2 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(0) toValue:@(AxcAE_Angle(360))];
            animation_3 = [AxcCAAnimation AxcTensileRepeatDuration:0.6 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7) isY:YES];
            animation_4 = [AxcCAAnimation AxcScaleRepeatDuration:0.33 timingFunction:kCAMediaTimingFunctionEaseInEaseOut fromValue:@(1) toValue:@(0.7)];
        }break;
            
        default: break;
    }
    [self.shapeLayer_1 addAnimation:animation_1 forKey:ContinuousAnimation];
    [self.shapeLayer_2 addAnimation:animation_2 forKey:ContinuousAnimation];
    [self.shapeLayer_3 addAnimation:animation_3 forKey:ContinuousAnimation];
    [self.shapeLayer_4 addAnimation:animation_4 forKey:ContinuousAnimation];
}
- (void)stopAnimation{
    [self.layers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllAnimations];
    }];
}
- (void)removeBezierPath{ // 移除所有曲线并重置
    [self.layers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.path = nil; obj.lineDashPattern = nil;
    }];
}
#pragma mark - 懒加载
- (NSArray<CAShapeLayer *> *)layers{
    return @[self.shapeLayer_1,self.shapeLayer_2,self.shapeLayer_3,self.shapeLayer_4];
}
- (CAShapeLayer *)settingLayer:(CAShapeLayer *)layer{
    layer = [CAShapeLayer new];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 2;
    [self.layer addSublayer:layer];
    return layer;
}
- (CAShapeLayer *)shapeLayer_4{
    if (!_shapeLayer_4) _shapeLayer_4 = [self settingLayer:_shapeLayer_4];
    return _shapeLayer_4;
}
- (CAShapeLayer *)shapeLayer_3{
    if (!_shapeLayer_3) _shapeLayer_3 = [self settingLayer:_shapeLayer_3];
    return _shapeLayer_3;
}
- (CAShapeLayer *)shapeLayer_2{
    if (!_shapeLayer_2) _shapeLayer_2 = [self settingLayer:_shapeLayer_2];
    return _shapeLayer_2;
}
- (CAShapeLayer *)shapeLayer_1{
    if (!_shapeLayer_1) _shapeLayer_1 = [self settingLayer:_shapeLayer_1];
    return _shapeLayer_1;
}

@end
