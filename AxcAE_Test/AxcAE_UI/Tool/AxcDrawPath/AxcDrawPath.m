//
//  AxcAE_BezierDrawBrush.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcDrawPath.h"

#define DefaultStartAngle -90.f

@implementation AxcDrawPath
#pragma mark - 线段/折线相关
#pragma mark 传入一组点，将其按顺序连接起来
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray{// 坐标
    return [self AxcDrawLineArray:lineArray clockwise:YES]; // 默认顺时针
}
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray
                         clockwise:(BOOL)clockwise{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (!lineArray.count) return bezierPath;
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
#pragma mark 绘制刻度线
+ (UIBezierPath *)AxcDrawScaleStartPoint:(CGPoint )startPoint
                                   count:(NSInteger )count
                              groupCount:(NSInteger )groupCount
                          bigScaleHeight:(CGFloat )bigScaleHeight
                        smallScaleHeight:(CGFloat )smallScaleHeight
                                 spacing:(CGFloat )spacing{
    return [self AxcDrawScaleStartPoint:startPoint
                                  count:count
                             groupCount:groupCount
                         bigScaleHeight:bigScaleHeight
                       smallScaleHeight:smallScaleHeight
                                spacing:spacing
                                 upward:YES];
}
+ (UIBezierPath *)AxcDrawScaleStartPoint:(CGPoint )startPoint
                                   count:(NSInteger )count
                              groupCount:(NSInteger )groupCount
                          bigScaleHeight:(CGFloat )bigScaleHeight
                        smallScaleHeight:(CGFloat )smallScaleHeight
                                 spacing:(CGFloat )spacing
                                  upward:(BOOL )upward{
    return [self AxcDrawScaleStartPoint:startPoint
                                  count:count
                             groupCount:groupCount
                         bigScaleHeight:bigScaleHeight
                       smallScaleHeight:smallScaleHeight
                                spacing:spacing
                                 upward:YES
                               sequence:YES];
}
+ (UIBezierPath *)AxcDrawScaleStartPoint:(CGPoint )startPoint
                                   count:(NSInteger )count
                              groupCount:(NSInteger )groupCount
                          bigScaleHeight:(CGFloat )bigScaleHeight
                        smallScaleHeight:(CGFloat )smallScaleHeight
                                 spacing:(CGFloat )spacing
                                  upward:(BOOL )upward
                                sequence:(BOOL)sequence{
    NSMutableArray *pointers = @[].mutableCopy;
    CGPoint point = startPoint;
    for (int i = 0; i <= count; i ++) { // 绘制大刻度
        [pointers addObject:[NSValue valueWithCGPoint:point]];
        [pointers addObject:[NSValue valueWithCGPoint:CGPointMake(point.x , point.y + bigScaleHeight)]];
        [pointers addObject:[NSNull null]];
        if (i == count) break;
        for (int j = 1; j < groupCount; j ++) { // 小刻度
            point = CGPointMake(point.x + spacing, point.y);
            if (upward) {
                [pointers addObject:[NSValue valueWithCGPoint:CGPointMake(point.x , point.y + bigScaleHeight - smallScaleHeight)]];
                [pointers addObject:[NSValue valueWithCGPoint:CGPointMake(point.x , point.y + bigScaleHeight)]];
            }else{
                [pointers addObject:[NSValue valueWithCGPoint:point]];
                [pointers addObject:[NSValue valueWithCGPoint:CGPointMake(point.x , point.y + smallScaleHeight)]];
            }
            [pointers addObject:[NSNull null]];
        }
        point = CGPointMake(point.x + spacing, point.y);
    }
    return [self AxcDrawLineArray:pointers clockwise:sequence];
}
#pragma mark - 多边形相关
#pragma mark 圆周多边形
+ (UIBezierPath *)AxcDrawParallelogramCenter:(CGPoint )center
                                  pointCount:(NSInteger )pointCount
                                      radius:(CGFloat )radius{
    return [self AxcDrawParallelogramCenter:center
                                 pointCount:pointCount
                                     radius:radius
                                 startAngle:DefaultStartAngle];
}
+ (UIBezierPath *)AxcDrawParallelogramCenter:(CGPoint )center
                                  pointCount:(NSInteger )pointCount
                                      radius:(CGFloat )radius
                                  startAngle:(CGFloat )startAngle{
    return [self AxcDrawParallelogramCenter:center
                                 pointCount:pointCount
                                     radius:radius
                                 startAngle:startAngle
                                  openingAngle:0];
}
+ (UIBezierPath *)AxcDrawParallelogramCenter:(CGPoint )center
                                  pointCount:(NSInteger )pointCount
                                      radius:(CGFloat )radius
                                  startAngle:(CGFloat )startAngle
                                openingAngle:(CGFloat )openingAngle{
    return [self AxcDrawParallelogramCenter:center
                                 pointCount:pointCount
                                     radius:radius
                                 startAngle:startAngle
                               openingAngle:openingAngle
                                  clockwise:YES];
}
+ (UIBezierPath *)AxcDrawParallelogramCenter:(CGPoint )center
                                  pointCount:(NSInteger )pointCount
                                      radius:(CGFloat )radius
                                  startAngle:(CGFloat )startAngle
                                openingAngle:(CGFloat )openingAngle
                                   clockwise:(BOOL)clockwise{
    NSMutableArray *points = @[].mutableCopy;
    // 间隔角度
    CGFloat intervalAngle = (360.f - openingAngle) / pointCount;
    for (int i = 0; i < pointCount; i ++) {
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center distance:radius radian:startAngle + intervalAngle*i]]];
    }
    [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center distance:radius radian:startAngle]]];
    UIBezierPath *bezierPath = [self AxcDrawLineArray:points clockwise:clockwise];
    [bezierPath closePath];   // 闭合
    return bezierPath;
}
#pragma mark 四边形
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect{
    return [self AxcDrawParallelogramRect:rect clockwise:YES];
}
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect
                                 clockwise:(BOOL)clockwise{
    return [self AxcDrawParallelogramRect:rect offset:CGPointZero clockwise:clockwise];
}
#pragma mark 平行四边形
+ (UIBezierPath *)AxcDrawParallelogramRect:(CGRect )rect
                                    offset:(CGPoint )offset{
    return [self AxcDrawParallelogramRect:rect offset:offset clockwise:YES];
}
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
                      startAngle:AxcAE_Angle(startAngle)
                        endAngle:AxcAE_Angle(endAngle)
                       clockwise:clockwise]; // 这函数个人感觉不需要封，完全没用嘛擦..
    return bezierPath;
}

#pragma mark 绘制圆弧
+ (UIBezierPath *)AxcDrawCircularArcCenter:(CGPoint )center
                                    radius:(CGFloat)radius
                                     count:(CGFloat)count
                                    radian:(CGFloat )radian{
    return [self AxcDrawCircularArcCenter:center
                                   radius:radius
                                    count:count
                                   radian:radian
                               startAngle:DefaultStartAngle];
}
+ (UIBezierPath *)AxcDrawCircularArcCenter:(CGPoint )center
                                    radius:(CGFloat)radius
                                     count:(CGFloat)count
                                    radian:(CGFloat )radian
                                startAngle:(CGFloat )startAngle{
    return [self AxcDrawCircularArcCenter:center
                                   radius:radius
                                    count:count
                                   radian:radian
                               startAngle:startAngle
                             openingAngle:0];
}
+ (UIBezierPath *)AxcDrawCircularArcCenter:(CGPoint )center
                                    radius:(CGFloat)radius
                                     count:(CGFloat)count
                                    radian:(CGFloat )radian
                                startAngle:(CGFloat )startAngle
                              openingAngle:(CGFloat )openingAngle{
    return [self AxcDrawCircularArcCenter:center
                                   radius:radius
                                    count:count
                                   radian:radian
                               startAngle:startAngle
                             openingAngle:openingAngle
                               connection:NO];
}
+ (UIBezierPath *)AxcDrawCircularArcCenter:(CGPoint )center
                                    radius:(CGFloat)radius
                                     count:(CGFloat)count
                                    radian:(CGFloat )radian
                                startAngle:(CGFloat )startAngle
                              openingAngle:(CGFloat )openingAngle
                                connection:(BOOL )connection{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    CGFloat spacingAngle = AxcAE_Angle((360.f - openingAngle)/count);
    for (int i = 0 ; i < count; i ++) {
        CGFloat _startAngle = AxcAE_Angle(startAngle)+(i*spacingAngle);
        CGFloat _endAngle = _startAngle + AxcAE_Angle(radian);
        [circlePath addArcWithCenter:center radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
        if (!connection){
            CGFloat moveAngle = _endAngle + spacingAngle - AxcAE_Angle(radian);
            [circlePath moveToPoint:[AxcPolarAxis AxcPolarAxisCenter:center distance:radius angle:moveAngle]];
        }
    }
    if (connection) [circlePath closePath];
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
                                startAngle:DefaultStartAngle];
}
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing
                                 startAngle:(CGFloat )startAngle{
    return [self AxcDrawBlockArcRingCenter:center
                             outsideRadius:outsideRadius
                               blockRadius:blockRadius
                                blockCount:blockCount
                              angleSpacing:angleSpacing
                                startAngle:startAngle
                              openingAngle:0];
}
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing
                                 startAngle:(CGFloat )startAngle
                               openingAngle:(CGFloat )openingAngle{
    return [self AxcDrawArrowBlockArcRingCenter:center          // 其实就是箭头状圆弧的变种
                                  outsideRadius:outsideRadius
                                    blockRadius:blockRadius
                                     blockCount:blockCount
                                   angleSpacing:angleSpacing
                                     arrowAngle:0
                                     startAngle:startAngle
                                   openingAngle:openingAngle
                                      clockwise:YES];
}
#pragma mark 绘制箭头块状圆弧
+ (UIBezierPath *)AxcDrawArrowBlockArcRingCenter:(CGPoint )center
                                   outsideRadius:(CGFloat )outsideRadius
                                     blockRadius:(CGFloat )blockRadius
                                      blockCount:(NSInteger )blockCount
                                    angleSpacing:(CGFloat )angleSpacing
                                      arrowAngle:(CGFloat )arrowAngle{
    return [self AxcDrawArrowBlockArcRingCenter:center
                                  outsideRadius:outsideRadius
                                    blockRadius:blockRadius
                                     blockCount:blockCount
                                   angleSpacing:angleSpacing
                                     arrowAngle:arrowAngle
                                     startAngle:DefaultStartAngle];
}
+ (UIBezierPath *)AxcDrawArrowBlockArcRingCenter:(CGPoint )center
                                   outsideRadius:(CGFloat )outsideRadius
                                     blockRadius:(CGFloat )blockRadius
                                      blockCount:(NSInteger )blockCount
                                    angleSpacing:(CGFloat )angleSpacing
                                      arrowAngle:(CGFloat )arrowAngle
                                      startAngle:(CGFloat )startAngle{
    return [self AxcDrawArrowBlockArcRingCenter:center
                                  outsideRadius:outsideRadius
                                    blockRadius:blockRadius
                                     blockCount:blockCount
                                   angleSpacing:angleSpacing
                                     arrowAngle:arrowAngle
                                     startAngle:startAngle
                                   openingAngle:0];
}
+ (UIBezierPath *)AxcDrawArrowBlockArcRingCenter:(CGPoint )center
                                   outsideRadius:(CGFloat )outsideRadius
                                     blockRadius:(CGFloat )blockRadius
                                      blockCount:(NSInteger )blockCount
                                    angleSpacing:(CGFloat )angleSpacing
                                      arrowAngle:(CGFloat )arrowAngle
                                      startAngle:(CGFloat )startAngle
                                    openingAngle:(CGFloat )openingAngle{
    return [self AxcDrawArrowBlockArcRingCenter:center
                                  outsideRadius:outsideRadius
                                    blockRadius:blockRadius
                                     blockCount:blockCount
                                   angleSpacing:angleSpacing
                                     arrowAngle:arrowAngle
                                     startAngle:startAngle
                                   openingAngle:openingAngle
                                      clockwise:YES];
}
+ (UIBezierPath *)AxcDrawArrowBlockArcRingCenter:(CGPoint )center
                                   outsideRadius:(CGFloat )outsideRadius
                                     blockRadius:(CGFloat )blockRadius
                                      blockCount:(NSInteger )blockCount
                                    angleSpacing:(CGFloat )angleSpacing
                                      arrowAngle:(CGFloat )arrowAngle
                                      startAngle:(CGFloat )startAngle
                                    openingAngle:(CGFloat )openingAngle
                                       clockwise:(BOOL )clockwise{
    // 创建绘制对象
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    CGFloat angle = (360.f - openingAngle) / blockCount - angleSpacing; // 度
    for (int i = 0; i < blockCount; i ++) {
        CGFloat cycleStartAngle = AxcAE_Angle(startAngle);
        CGFloat arrowHeaderAngle = cycleStartAngle + AxcAE_Angle(angle+arrowAngle);
        CGFloat arrowHeaderAngle2 = cycleStartAngle + AxcAE_Angle(angle-arrowAngle);
        CGFloat arrowTailAngle = cycleStartAngle + AxcAE_Angle(arrowAngle);
        CGFloat arrowTailAngle2 = cycleStartAngle - AxcAE_Angle(arrowAngle);
        [circlePath addArcWithCenter:center
                              radius:outsideRadius
                          startAngle:cycleStartAngle
                            endAngle:cycleStartAngle + AxcAE_Angle(angle)
                           clockwise:YES];
        [circlePath addLineToPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                           distance: outsideRadius-blockRadius + blockRadius/2
                                                              angle:clockwise?arrowHeaderAngle:arrowHeaderAngle2]];
        [circlePath addArcWithCenter:center
                              radius:outsideRadius - blockRadius
                          startAngle:cycleStartAngle + AxcAE_Angle(angle)
                            endAngle:cycleStartAngle
                           clockwise:NO];
        [circlePath addLineToPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                           distance:outsideRadius-blockRadius + blockRadius/2
                                                              angle:clockwise?arrowTailAngle:arrowTailAngle2]];
        [circlePath addLineToPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                           distance:outsideRadius
                                                              angle:cycleStartAngle]];
        [circlePath closePath]; // 闭合
        startAngle += ((angle + angleSpacing));
        [circlePath moveToPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                        distance:outsideRadius
                                                          radian:startAngle]];
    }
    return circlePath;
}
#pragma mark 绘制梯形块状圆形
+ (UIBezierPath *)AxcDrawTrapezoidalBlockArcRingCenter:(CGPoint )center
                                         outsideRadius:(CGFloat )outsideRadius
                                           blockRadius:(CGFloat )blockRadius
                                            blockCount:(NSInteger )blockCount
                                          angleSpacing:(CGFloat )angleSpacing{
    return [self AxcDrawTrapezoidalBlockArcRingCenter:center
                                        outsideRadius:outsideRadius
                                          blockRadius:blockRadius
                                           blockCount:blockCount
                                         angleSpacing:angleSpacing
                                           startAngle:DefaultStartAngle];
}
+ (UIBezierPath *)AxcDrawTrapezoidalBlockArcRingCenter:(CGPoint )center
                                         outsideRadius:(CGFloat )outsideRadius
                                           blockRadius:(CGFloat )blockRadius
                                            blockCount:(NSInteger )blockCount
                                          angleSpacing:(CGFloat )angleSpacing
                                            startAngle:(CGFloat )startAngle{
    return [self AxcDrawTrapezoidalBlockArcRingCenter:center
                                        outsideRadius:outsideRadius
                                          blockRadius:blockRadius
                                           blockCount:blockCount
                                         angleSpacing:angleSpacing
                                           startAngle:startAngle
                                         openingAngle:0];
}
+ (UIBezierPath *)AxcDrawTrapezoidalBlockArcRingCenter:(CGPoint )center
                                         outsideRadius:(CGFloat )outsideRadius
                                           blockRadius:(CGFloat )blockRadius
                                            blockCount:(NSInteger )blockCount
                                          angleSpacing:(CGFloat )angleSpacing
                                            startAngle:(CGFloat )startAngle
                                          openingAngle:(CGFloat )openingAngle{
    return [self AxcDrawTrapezoidalBlockArcRingCenter:center
                                        outsideRadius:outsideRadius
                                          blockRadius:blockRadius
                                           blockCount:blockCount
                                         angleSpacing:angleSpacing
                                           startAngle:startAngle
                                         openingAngle:openingAngle
                                            clockwise:YES];
}
+ (UIBezierPath *)AxcDrawTrapezoidalBlockArcRingCenter:(CGPoint )center
                                         outsideRadius:(CGFloat )outsideRadius
                                           blockRadius:(CGFloat )blockRadius
                                            blockCount:(NSInteger )blockCount
                                          angleSpacing:(CGFloat )angleSpacing
                                            startAngle:(CGFloat )startAngle
                                          openingAngle:(CGFloat )openingAngle
                                             clockwise:(BOOL )clockwise{
    CGFloat angle = (360.f - openingAngle) / blockCount - angleSpacing; // 度
    NSMutableArray *points = @[].mutableCopy;
    for (int i = 0; i < blockCount; i ++) {
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                                            distance:outsideRadius
                                                                              radian:startAngle]]];
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                                            distance:outsideRadius
                                                                              radian:startAngle + angle]]] ;
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                                            distance:outsideRadius - blockRadius
                                                                              radian:startAngle + angle]]] ;
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                                            distance:outsideRadius - blockRadius
                                                                              radian:startAngle]]] ;
        [points addObject:[NSValue valueWithCGPoint:[AxcPolarAxis AxcPolarAxisCenter:center
                                                                            distance:outsideRadius
                                                                              radian:startAngle]]];
        [points addObject:[NSNull null]];
        startAngle += ((angle + angleSpacing));
    }
    return [self AxcDrawLineArray:points clockwise:clockwise];
}
#pragma mark - 网格相关
#pragma mark 绘制矩形网格
+ (UIBezierPath *)AxcDrawRectangularGridRect:(CGRect )rect
                                   gridCount:(AxcAE_Grid )gridCount{
    return [self AxcDrawRectangularGridRect:rect gridCount:gridCount forward:YES];
}
+ (UIBezierPath *)AxcDrawRectangularGridRect:(CGRect )rect
                                   gridCount:(AxcAE_Grid )gridCount
                                     forward:(BOOL)forward{
    return [self AxcDrawRectangularGridRect:rect gridCount:gridCount border:YES forward:forward];
}
+ (UIBezierPath *)AxcDrawRectangularGridRect:(CGRect )rect
                                   gridCount:(AxcAE_Grid )gridCount
                                      border:(BOOL )border
                                     forward:(BOOL)forward{
    return [self AxcDrawRectangularGridRect:rect gridCount:gridCount firstHorizontal:YES border:border forward:forward];
}
+ (UIBezierPath *)AxcDrawRectangularGridRect:(CGRect )rect
                                   gridCount:(AxcAE_Grid )gridCount
                             firstHorizontal:(BOOL )firstHorizontal
                                      border:(BOOL )border
                                     forward:(BOOL)forward{
    NSMutableArray *gridsPoint = @[].mutableCopy;
    for (int k = 0; k < 2; k ++) { // 代码顺序选择器
        if (firstHorizontal) {
            CGFloat verticalHeight = rect.size.height/gridCount.verticalCount;
            for (int i = 0; i <= gridCount.verticalCount; i ++) { // 纵向遍历，横向绘制
                if (!border &&((!i) || (i == gridCount.verticalCount))) continue;
                [gridsPoint addObject:[NSValue valueWithCGPoint:CGPointMake(rect.origin.x, rect.origin.y + verticalHeight * i)]];
                [gridsPoint addObject:[NSValue valueWithCGPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + verticalHeight * i)]];
                [gridsPoint addObject:[NSNull null]];
            }
            firstHorizontal = NO;
        }else{
            CGFloat horizontalCount = rect.size.width/gridCount.horizontalCount;
            for (int i = 0; i <= gridCount.horizontalCount; i ++) { // 横向遍历，纵向绘制
                if (!border &&((!i) || (i == gridCount.horizontalCount))) continue;
                [gridsPoint addObject:[NSValue valueWithCGPoint:CGPointMake(rect.origin.x + horizontalCount * i, rect.origin.y)]];
                [gridsPoint addObject:[NSValue valueWithCGPoint:CGPointMake(rect.origin.x + horizontalCount * i, rect.origin.y + rect.size.height)]];
                [gridsPoint addObject:[NSNull null]];
            }
            firstHorizontal = YES;
        }
    }
    return [self AxcDrawLineArray:gridsPoint clockwise:forward];
}


@end



