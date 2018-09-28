//
//  HexagonCell.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "HexagonCell.h"

@implementation HexagonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 添加画板
    [self.drawBoard drawSublayer:self.layerBrush];
    [self.drawBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (CAShapeLayer *)layerBrush{
    if (!_layerBrush) {
        // 创建绘制动作路径
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramCenter:CGPointMake(25, 25)    // 中心
                                                                pointCount:6                        // 角个数
                                                                    radius:25                      // 每个顶点距离心的半径
                                                                startAngle:0];                        // 起始绘制角（弧度）
        // 创建画笔
        _layerBrush = [AxcLayerBrush AxcLayerDottedLineWidth:0.5                      // 画笔宽度
                                                 strokeColor:KScienceTechnologyBlue  // 画笔颜色
                                                  bezierPath:bezierPath];
        _layerBrush.fillColor = kVCBackColor.CGColor;
    }
    return _layerBrush;
}
- (AxcAE_DrawBoard *)drawBoard{
    if (!_drawBoard) {
        _drawBoard = [AxcAE_DrawBoard new];
        [self addSubview:_drawBoard];
    }
    return _drawBoard;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = KScienceTechnologyBlue;
        [self addSubview:_label];
    }
    return _label;
}

@end
