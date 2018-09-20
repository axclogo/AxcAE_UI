//
//  DrawBlockRingVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/20.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "DrawBlockRingVC.h"

@interface DrawBlockRingVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush2;

@end

@implementation DrawBlockRingVC

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
    [self.layerBrush addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                           forKey:@"123"];
    
    [self.drawBoard drawSublayer:self.layerBrush2];
    [self.layerBrush2 addAnimation:[AxcCAAnimation AxcDrawLineDuration:3] // 使其3秒绘制完
                           forKey:@"12123"];
    // 假装画完图才填色=。=
    self.layerBrush2.fillColor = [UIColor clearColor].CGColor;
    [self performSelector:@selector(change_fillColor) withObject:nil afterDelay:3];
}
- (void)change_fillColor{
    self.layerBrush2.fillColor = rgb(237, 189, 101).CGColor;
}

- (CAShapeLayer *)layerBrush2{
    if (!_layerBrush2) {
        // 画个辐射危险的标志吧=。=
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawBlockArcRingCenter:CGPointMake(110, 310) // 绘制中心
                                                            outsideRadius:100                   // 外圆半径
                                                              blockRadius:80                    // 环块距离外部距离
                                                               blockCount:3                    // 环块个数
                                                             angleSpacing:60                     // 环块间距弧度
                                                               startAngle:180                   // 起始角弧度
                                                             openingAngle:0];                   // 开合角度
        _layerBrush2 = [AxcLayerBrush AxcLayerDottedLineWidth:3                      // 画笔宽度
                                                  strokeColor:[UIColor whiteColor]  // 画笔颜色
                                                   bezierPath:bezierPath];
    }
    return _layerBrush2;
}
- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawBlockArcRingCenter:CGPointMake(110, 110) // 绘制中心
                                                            outsideRadius:100                   // 外圆半径
                                                              blockRadius:30                    // 环块距离外部距离
                                                               blockCount:10                    // 环块个数
                                                             angleSpacing:5                     // 环块间距弧度
                                                               startAngle:-90                   // 起始角弧度
                                                             openingAngle:0];                   // 开合角度
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:3                      // 画笔宽度
                                                 strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                  bezierPath:bezierPath             // 画笔动作路径
                                             lineDashPattern:@[@(1),@(2)]];         // 画笔虚线间隔设置 *** 虚线多设置一个参数就可以，传nil同样代表实线
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
