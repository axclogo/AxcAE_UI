//
//  AxcAE_BezierDrawBrush.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxcAE_HeaderDefine.h"


/**
 绘制动作路径
 */
@interface AxcDrawPath : UIBezierPath

#pragma mark - 线段/折线相关
#pragma mark  传入一组点，将其按顺序连接起来
/**
 传入一组点，将其按顺序连接起来 - 1
 @param lineArray 数组点
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray;

/**
 传入一组点，将其按顺序连接起来 - 1
 @param lineArray 数组点
 @param clockwise 是否顺时针绘制
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawLineArray:(NSArray <NSValue *> *)lineArray
                         clockwise:(BOOL)clockwise;
#pragma mark - 四边形相关
#pragma mark 四边形
/**
 绘制一个四边形
 @param startPoint 起始点
 @param size 大小
 @param clockwise 是否顺时针绘制
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawParallelogramStartPoint:(CGPoint )startPoint
                                            size:(CGSize )size
                                       clockwise:(BOOL)clockwise;
#pragma mark 平行四边形
/**
 绘制一个四边形
 @param startPoint 起始点
 @param size 大小
 @param clockwise 是否顺时针绘制
 @param offset 偏移量
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawParallelogramStartPoint:(CGPoint )startPoint
                                            size:(CGSize )size
                                          offset:(CGPoint )offset
                                       clockwise:(BOOL)clockwise;
#pragma mark - 圆环相关
/**
 画圆 。。我自己都觉得这个封有点迷
 @param center 中心点
 @param radius 半径
 @param startAngle 起始角度
 @param endAngle 终止角度
 @param clockwise 是否顺时针顺序
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawArcCenter:(CGPoint )center
                            radius:(CGFloat)radius
                        startAngle:(CGFloat)startAngle
                          endAngle:(CGFloat)endAngle
                         clockwise:(BOOL)clockwise;

#pragma mark 绘制双圆弧
/**
 绘制双圆弧 - 1
 @param center 中心点
 @param radius 半径
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                                     radius:(CGFloat)radius;

/**
 绘制双圆弧 - 2
 @param center 中心点
 @param radius 半径
 @param radian 弧度
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                                     radius:(CGFloat)radius
                                     radian:(CGFloat )radian;

#pragma mark 绘制块状圆弧
/**
 绘制块状圆弧 -1
 @param center 中心点
 @param outsideRadius 外圆半径
 @param blockRadius 圆弧块弧半径
 @param blockCount 块个数
 @param angleSpacing 间距角度
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing;

/**
 绘制块状圆弧 -2
 @param center 中心点
 @param outsideRadius 外圆半径
 @param blockRadius 圆弧块弧半径
 @param blockCount 块个数
 @param angleSpacing 间距角度
 @param startAngle 起始角度
 @param openingAngle 开口度数
 @return 贝塞尔曲线
 */
+ (UIBezierPath *)AxcDrawBlockArcRingCenter:(CGPoint )center
                              outsideRadius:(CGFloat )outsideRadius
                                blockRadius:(CGFloat )blockRadius
                                 blockCount:(NSInteger )blockCount
                               angleSpacing:(CGFloat )angleSpacing
                                 startAngle:(CGFloat )startAngle
                               openingAngle:(CGFloat )openingAngle;
@end

