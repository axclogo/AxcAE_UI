//
//  DrawGridVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/27.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "DrawGridVC.h"

@interface DrawGridVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;

@end

@implementation DrawGridVC

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
    [self.layerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:1 timingFunction:kCAMediaTimingFunctionEaseInEaseOut] // 使其1秒绘制完
                           forKey:@"123"];
}

- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawRectangularGridRect:CGRectMake(10, 10, 350, 200) // frame
                                                                 gridCount:AxcAE_GridMake(50, 20)       // 横向格子数和纵向格子数
                                                           firstHorizontal:NO                           // 是否先手横向动作 否则先手纵向动作
                                                                    border:NO                           // 外框是否要
                                                                   forward:YES];                        // 正向顺序绘制
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:0.5                      // 画笔宽度
                                                 strokeColor:KScienceTechnologyBlue   // 画笔颜色
                                                  bezierPath:bezierPath];
        
        // 用Layer制作成扫描网络
        // 渐变图层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(10, 10, 350, 200);
        // 设置颜色
        gradientLayer.colors = @[ (id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor ,
                                 (id)[KScienceTechnologyBlue colorWithAlphaComponent:1].CGColor ];
        gradientLayer.locations = @[[NSNumber numberWithFloat:0.1f],
                                    [NSNumber numberWithFloat:1.0f]];
        _layerBrush.mask = gradientLayer;
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
