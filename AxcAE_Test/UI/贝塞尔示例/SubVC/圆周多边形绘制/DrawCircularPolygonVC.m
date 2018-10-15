//
//  DrawCircularPolygonVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "DrawCircularPolygonVC.h"

@interface DrawCircularPolygonVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;

@end

@implementation DrawCircularPolygonVC

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
    [self.drawBoard drawSublayer:self.layerBrush];
    // 添加绘制动画 -- 非必选，如果设置绘制动画则能看到绘制效果
    [self.layerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:1] // 使其1秒绘制完
                           forKey:@"123"];
}

- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramCenter:CGPointMake(200, 200)    // 中心
                                                                pointCount:6                        // 角个数
                                                                    radius:100                      // 每个顶点距离心的半径
                                                                startAngle:60                        // 起始绘制角（弧度）
                                                              openingAngle:0                        // 开合角
                                                                 clockwise:YES];                     // 是否顺时针
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:1                      // 画笔宽度
                                                 strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                  bezierPath:bezierPath];
    }
    return _layerBrush;
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
