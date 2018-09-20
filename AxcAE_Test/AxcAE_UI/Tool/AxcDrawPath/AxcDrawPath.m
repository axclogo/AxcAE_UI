//
//  AxcAE_BezierDrawBrush.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcDrawPath.h"

@implementation AxcDrawPath
#pragma mark - 线段/折线相关
#pragma mark 传入一组点，将其按顺序连接起来
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray{// 坐标
    return [self AxcDrawLineArray:lineArray clockwise:YES]; // 默认顺时针
}
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray
                         clockwise:(BOOL)clockwise{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint point1 = [lineArray[0] CGPointValue];
    [bezierPath moveToPoint:point1];
    __block BOOL isMovePoint = NO;
    [lineArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSValue class]]) {
            if (isMovePoint) {
                [bezierPath moveToPoint: [obj CGPointValue]];
                isMovePoint = NO; // 置空判断
            }else{
                [bezierPath addLineToPoint: [obj CGPointValue]];
            }
        }else{ // 记录下一个点需要移动
            isMovePoint = YES;
        }
    }];
    if (!clockwise) bezierPath = [bezierPath bezierPathByReversingPath];// 逆时针绘制
    return bezierPath;
}
#pragma mark - 多边形相关
#pragma mark 四边形
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect{
    return [self AxcDrawParallelogramRect:rect
                                clockwise:YES];
}
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect
                                 clockwise:(BOOL)clockwise{
    return [self AxcDrawParallelogramRect:rect
                                   offset:CGPointZero
                                clockwise:clockwise];
}
#pragma mark 平行四边形
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect
                                    offset:(CGPoint )offset
                                 clockwise:(BOOL)clockwise{
    UIBezierPath *bezierPath =
    [self AxcDrawLineArray:
     @[[NSValue valueWithCGPoint: rect.origin],
       [NSValue valueWithCGPoint: CGPointMake(rect.origin.x + rect.size.width , rect.origin.y + offset.y)],
       [NSValue valueWithCGPoint: CGPointMake(rect.origin.x + rect.size.width + offset.x , rect.origin.y + rect.size.height + offset.y)],
       [NSValue valueWithCGPoint: CGPointMake(rect.origin.x + offset.x , rect.origin.y + rect.size.height)],
       [NSValue valueWithCGPoint: rect.origin]]
                 clockwise:clockwise];
    return bezierPath;
}
#pragma mark - 圆环相关
#pragma mark 画圆
+ (UIBezierPath *)AxcDrawArcCenter:(CGPoint )center
                            radius:(CGFloat)radius
                        startAngle:(CGFloat)startAngle
                          endAngle:(CGFloat)endAngle
                         clockwise:(BOOL)clockwise{
    AxcDrawPath *bezierPath = [AxcDrawPath bezierPath];
    [bezierPath addArcWithCenter:center
                          radius:radius
                      startAngle:startAngle
                        endAngle:endAngle
                       clockwise:clockwise]; // 这函数个人感觉不需要封，完全没用嘛擦..
    return bezierPath;
}

#pragma mark 绘制双圆弧
+ (UIBezierPath *)AxcDrawArcRingCenter:(CGPoint )center
                                radius:(CGFloat)radius{
    return [self AxcDrawArcRingCenter:center
                               radius:radius
                               radian: M_PI / 4];
}
+ (UIBezierPath *)AxcDrawArcRingCenter:(CGPoint )center
                                radius:(CGFloat)radius
                                radian:(CGFloat )radian{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:center radius:radius startAngle:-3 * radian endAngle:-radian clockwise:true];
    [circlePath moveToPoint:CGPointMake(center.x - radius * cosf(radian),radius * sinf(radian) + center.y)];
    [circlePath addArcWithCenter:center radius:radius startAngle:-5 * radian endAngle:-7 * radian clockwise:false];
    return circlePath;
}

#pragma mark 绘制块状圆弧
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing{
    return [self AxcDrawBlockArcRingCenter:center
                             outsideRadius:outsideRadius
                               blockRadius:blockRadius
                                blockCount:blockCount
                              angleSpacing:angleSpacing
                                startAngle:-90
                              openingAngle:360];
}
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing
                                 startAngle:(CGFloat )startAngle
                               openingAngle:(CGFloat )openingAngle{
    // 创建绘制对象
    AxcDrawPath *circlePath = [AxcDrawPath bezierPath];
    CGFloat angle = (360.f - openingAngle) / blockCount - angleSpacing; // 度
    for (int i = 0; i < blockCount; i ++) {
        CGFloat cycleStartAngle = AxcAE_Angle(startAngle);
        [circlePath addArcWithCenter:center
                              radius:outsideRadius
                          startAngle:cycleStartAngle
                            endAngle:cycleStartAngle + AxcAE_Angle(angle)
                           clockwise:YES];
        [circlePath addArcWithCenter:center
                              radius:outsideRadius - blockRadius
                          startAngle:cycleStartAngle + AxcAE_Angle(angle)
                            endAngle:cycleStartAngle
                           clockwise:NO];
        [circlePath addLineToPoint:CGPointMake(center.x + outsideRadius * cosf(cycleStartAngle),
                                               center.y + outsideRadius * sinf(cycleStartAngle))];
        [circlePath closePath]; // 闭合
        startAngle += ((angle + angleSpacing));
        [circlePath moveToPoint:CGPointMake(outsideRadius * cosf(AxcAE_Angle(startAngle))+ center.x,
                                            outsideRadius * sinf(AxcAE_Angle(startAngle))+ center.y)];
    }
    return circlePath;
}



@end


