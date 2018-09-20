//
//  DrawQuadrilateralVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/20.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "DrawQuadrilateralVC.h"

@interface DrawQuadrilateralVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明正方形画笔对象
@property(nonatomic , strong)CAShapeLayer *squareLayerBrush;
// 声明圆角正方形画笔对象
@property(nonatomic , strong)CAShapeLayer *squareLayerBrush2;
// 声明平行四边形画笔对象
@property(nonatomic , strong)CAShapeLayer *parallelogramLayerBrush;
// 声明平行四边形画笔对象2
@property(nonatomic , strong)CAShapeLayer *parallelogramLayerBrush2;
@end

@implementation DrawQuadrilateralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCBackColor;
    [self createStartAnimationBtn];
}
// 添加到界面上
- (void)createUI{
    [self.drawBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
    }];
}
// 当点击按钮触发
- (void)click_startAnimationBtn{
    // 使画笔在画板上开始绘制
    [self.drawBoard drawSublayer:self.squareLayerBrush];
    // 添加绘制动画 -- 非必选，如果设置绘制动画则能看到绘制效果
    [self.squareLayerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                                 forKey:@"123"];
    [self.drawBoard drawSublayer:self.squareLayerBrush2];
    [self.squareLayerBrush2 addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                                        forKey:@"122322"];
    
    [self.drawBoard drawSublayer:self.parallelogramLayerBrush];
    [self.parallelogramLayerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                                        forKey:@"1223"];
    [self.drawBoard drawSublayer:self.parallelogramLayerBrush2];
    [self.parallelogramLayerBrush2 addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                                        forKey:@"12233"];
    
    /* 可以多个画笔同时执行动画，也就是多个独立的Layer层 */
}

///// 注：以下为了方便研究所以一个个分开写的，如果有明白基本原理的可以使用循环实现多个画笔，这样代码会更简洁

// 平行四边形画笔2
- (CAShapeLayer *)parallelogramLayerBrush2{
    if (!_parallelogramLayerBrush2) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramRect:CGRectMake(170, 150,110, 100) // 四边形大小
                                                                  offset:CGPointMake(0, 20)   // 四边形双坐标偏移量 X为正向右偏移，反之向左；Y为正向下偏移，反之向上
                                                               clockwise:YES];                // 顺时针绘制
        [bezierPath closePath]; // 使其闭合
        // 创建画笔
        _parallelogramLayerBrush2 = [AxcLayerBrush AxcLayerDottedLineWidth:2                      // 画笔宽度
                                                               strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                                bezierPath:bezierPath             // 画笔动作路径
                                                           lineDashPattern:@[@(1),@(2)]];         // 虚线
        _parallelogramLayerBrush2.lineJoin = kCALineJoinBevel;
    }
    return _parallelogramLayerBrush2;
}

// 平行四边形画笔
- (CAShapeLayer *)parallelogramLayerBrush{
    if (!_parallelogramLayerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramRect:CGRectMake(20, 150,110, 100) // 四边形大小
                                                                  offset:CGPointMake(20, 0)             // 四边形双坐标偏移量
                                                               clockwise:YES];                           // 顺时针绘制
        [bezierPath closePath]; // 使其闭合
        // 创建画笔
        _parallelogramLayerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:2                      // 画笔宽度
                                                              strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                               bezierPath:bezierPath             // 画笔动作路径
                                                          lineDashPattern:@[@(1),@(2)]];         // 虚线
        _parallelogramLayerBrush.lineJoin = kCALineJoinBevel;
    }
    return _parallelogramLayerBrush;
}

// 正方形画笔
- (CAShapeLayer *)squareLayerBrush{
    if (!_squareLayerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramRect:CGRectMake(20, 20,110, 100)];
        [bezierPath closePath]; // 使其闭合
        // 创建画笔 实线
        _squareLayerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:5                      // 画笔宽度
                                                       strokeColor:KScienceTechnologyBlue // 画笔颜色
                                                        bezierPath:bezierPath];           // 画笔动作路径
        _squareLayerBrush.lineJoin = kCALineJoinMiter;
    }
    return _squareLayerBrush;
}

// 圆角正方形画笔
- (CAShapeLayer *)squareLayerBrush2{
    if (!_squareLayerBrush2) {
        UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight;
        // 直接用系统自带的即可
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(170, 20,110, 100) byRoundingCorners:corners cornerRadii:CGSizeMake(10, 10)];
        // 创建绘制动作路径
//        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramRect:CGRectMake(170, 20,110, 100)];
//        [bezierPath closePath]; // 使其闭合
        // 创建画笔 实线
        _squareLayerBrush2 = [AxcLayerBrush AxcLayerDottedLineWidth:5                      // 画笔宽度
                                                       strokeColor:KScienceTechnologyBlue // 画笔颜色
                                                        bezierPath:path];           // 画笔动作路径
        //线条之间
        _squareLayerBrush2.lineJoin = kCALineJoinRound;
        //线条结尾
        _squareLayerBrush2.lineCap = kCALineCapRound;
    }
    return _squareLayerBrush2;
}


- (AxcAE_DrawBoard *)drawBoard{
    if (!_drawBoard) {
        _drawBoard = [AxcAE_DrawBoard new];
        _drawBoard.backgroundColor = kBackColor;
        [self.view addSubview:_drawBoard];
    }
    return _drawBoard;
}



@end
