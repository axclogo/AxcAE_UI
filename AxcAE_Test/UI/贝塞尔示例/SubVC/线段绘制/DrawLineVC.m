//
//  AxcAE_DrawLineVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "DrawLineVC.h"

@interface DrawLineVC ()
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;
@end

@implementation DrawLineVC

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
}

- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        // 先设置需要绘制的点位
        NSMutableArray *drawPoints = @[[NSValue valueWithCGPoint:CGPointMake(10, 10)],
                                       [NSValue valueWithCGPoint:CGPointMake(200, 10)],
                                       [NSNull null], // 代表上个点位和下个点位不需要连接,只要不是 NSValue 类型的都会判断为断点
                                       [NSValue valueWithCGPoint:CGPointMake(10, 30)],
                                       [NSValue valueWithCGPoint:CGPointMake(200, 30)],
                                       [NSNull null] // 断点
                                       ].mutableCopy;
        // 示例完毕，后边就直接循环创建吧
        for (int i = 0 ; i < 20; i ++) {
            [drawPoints addObject:[NSValue valueWithCGPoint:CGPointMake(10, i * 10 + 50)]];
            [drawPoints addObject:[NSValue valueWithCGPoint:CGPointMake(200, i * 10 + 50)]];
            [drawPoints addObject:[NSNull null]]; // 断点
        }
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawLineArray:drawPoints // 绘制的点位
                                                       clockwise:YES];       // 是否顺时针绘制
        // 创建画笔 虚线
        /*
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:5                      // 画笔宽度
                                                 strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                  bezierPath:bezierPath             // 画笔动作路径
                                             lineDashPattern:@[@(1),@(2)]];         // 画笔虚线间隔设置 *** 虚线多设置一个参数就可以，传nil同样代表实线
         */
        // 创建画笔 实线
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:5                      // 画笔宽度
                                                 strokeColor:[UIColor orangeColor]  // 画笔颜色
                                                  bezierPath:bezierPath];           // 画笔动作路径
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
