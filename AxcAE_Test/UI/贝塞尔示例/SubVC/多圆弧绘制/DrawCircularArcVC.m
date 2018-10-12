//
//  DrawCircularArcVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "DrawCircularArcVC.h"

@interface DrawCircularArcVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;

@end

@implementation DrawCircularArcVC

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
    [self.layerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:2] // 使其1秒绘制完
                           forKey:@"123"];
}

- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawCircularArcCenter:CGPointMake(200, 200)  // 中心
                                                                  radius:100                    // 半径
                                                                   count:5                      // 圆弧个数
                                                                  radian:30                     // 圆弧弧度
                                                              startAngle:-90-15                    // 起始角
                                                            openingAngle:0                      // 开放角
                                                              connection:NO];                  // 是否首尾相连
        
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
