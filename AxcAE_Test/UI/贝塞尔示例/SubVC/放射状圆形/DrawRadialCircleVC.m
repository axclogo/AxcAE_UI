//
//  DrawRadialCircleVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/15.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "DrawRadialCircleVC.h"

@interface DrawRadialCircleVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;

@end

@implementation DrawRadialCircleVC

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
        // 创建绘制动作路径
        NSMutableArray *arr = @[].mutableCopy;
        for (int i = 0; i < 200; i ++) {
            [arr addObject:@(arc4random()%99+1)];
        }
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawCircularRadiationCenter:CGPointMake(200, 200)    // 圆心
                                                                        radius:50                       // a半径
                                                                   lineHeights:arr                      // 每条线的长度
                                                                       outside:YES                      // 向外辐射？
                                                                    startAngle:-90                      // 起始角
                                                                  openingAngle:0                        // 开合角
                                                                     clockwise:YES];                    // 顺时针绘制？
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
