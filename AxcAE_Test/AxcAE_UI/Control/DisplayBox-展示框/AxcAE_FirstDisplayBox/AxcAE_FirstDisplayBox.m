////
////  AxcAE_FirstDisplayBox.m
////  AxcAE_Test
////
////  Created by AxcLogo on 2018/9/14.
////  Copyright © 2018年 AxcLogo. All rights reserved.
////
//
//#import "AxcAE_FirstDisplayBox.h"
//#import "AxcAE_ParallelogramView.h"
//
//@interface AxcAE_FirstDisplayBox ()<CAAnimationDelegate>
//////////////////////// 第一阶段的线
//@property(nonatomic, strong)CAShapeLayer *leftLineLayer;
//@property(nonatomic, strong)CAShapeLayer *rightLineLayer;
//@property(nonatomic, strong)CAShapeLayer *topLineLayer;
//@property(nonatomic, strong)CAShapeLayer *buttomLineLayer;
//// 记录以上四个线坐标的二维数组，分别 左 右 上 下 二维数组
//@property(nonatomic, strong)NSMutableArray <NSArray <NSValue *>*>*fourEdgesArray;
//// 记录以上四个线段的数组指针
//@property(nonatomic, strong)NSMutableArray <CAShapeLayer *>*lineLayersArray;
//// 线段末端的小点View数组
//@property(nonatomic, strong)NSMutableArray <UIView *>*lineExtremeViewsArray;
//////////////////////// 第二阶段的线
//@property(nonatomic, strong)CAShapeLayer *leftTopLineLayer;
//@property(nonatomic, strong)CAShapeLayer *leftButtomLineLayer;
//@property(nonatomic, strong)CAShapeLayer *rightTopLineLayer;
//@property(nonatomic, strong)CAShapeLayer *rightButtomLineLayer;
//// 记录以上四个线坐标的二维数组，分别 左上下 右上下 二维数组
//@property(nonatomic, strong)NSMutableArray <NSArray <NSValue *>*>*phase2FourEdgesArray;
//// 记录以上四个线段的数组指针
//@property(nonatomic, strong)NSMutableArray <CAShapeLayer *>*phase2lineLayersArray;
/////////////////////// 第三阶段平行四边形
//@property(nonatomic, strong)AxcAE_ParallelogramView *topParallelogramView;
//@property(nonatomic, strong)AxcAE_ParallelogramView *buttomParallelogramView;
//// 动画执行前后标记
//@property(nonatomic , assign)BOOL isAnimationEnd;
//
//@end
//
//@implementation AxcAE_FirstDisplayBox
//- (void)AxcAE_BaseConfiguration{
//    [super AxcAE_BaseConfiguration];
//    self.edgesLineHeight = 30;
//    self.edgesLineWidth = 45;
//    self.lineSpacing = 15;
//    self.lineExtremePointSize = CGSizeMake(5, 5);
//    self.bevelLineHeight = 10;
//    self.centerLineWidth = 100;
//}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self reloadLinePoints];
//    [self reloadViewParm];
//    if (self.isAnimationEnd) { // 动画执行后
//        [self reloadPointExtreme];
//        [self reloadParallelogramEndPoint];
//    }else{
//        [self hiddenParallelogram:YES];
//    }
//}
//#define One_AimationTime 0.3
//#define Two_AimationTime 0.5
//#define Three_AimationTime 0.4
//#define Fore_AimationTime 0.3
//- (void)startAnimation{
//    if (!self.isAnimationEnd) {
//        return;
//    }
//    self.isAnimationEnd = NO;
//    [self reloadPointHidden:YES];
//    [self hiddenParallelogram:YES];
//    // 移除二阶的线
//    [self.phase2lineLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
//        [layer removeFromSuperlayer];
//    }];
//    // 绘制边框线
//    [self.lineLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self AxcAE_BaseDrawLineWithLayer:layer time:One_AimationTime];
//    }];
//    [self performSelector:@selector(aimation2) withObject:nil afterDelay:One_AimationTime/2];
//}
//- (void)aimation2{
//    [self reloadPointStart];
//    [UIView animateWithDuration:Two_AimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self reloadPointHidden:NO];
//        [self reloadPointExtreme];
//    } completion:nil];
//    [self performSelector:@selector(aimation3) withObject:nil afterDelay:Two_AimationTime/2];
//    [self performSelector:@selector(aimation4) withObject:nil afterDelay:Two_AimationTime];
//}
//- (void)aimation3{
//    // 绘制边框线2
//    [self.phase2lineLayersArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self AxcAE_BaseDrawLineWithLayer:layer time:Three_AimationTime];
//    }];
//}
//- (void)aimation4{
//    [self hiddenParallelogram:NO];
//    self.topParallelogramView.alpha = 0;
//    self.buttomParallelogramView.alpha = 0;
//    [self reloadParallelogramStartPoint];
//    [UIView animateWithDuration:Fore_AimationTime animations:^{
//        self.topParallelogramView.alpha = 1;
//        self.buttomParallelogramView.alpha = 1;
//        [self reloadParallelogramEndPoint];
//        self.isAnimationEnd = YES;
//    }];
//}
//
//#pragma mark - 复用函数区域
//// 设置四边形到终点
//- (void)reloadParallelogramEndPoint{
//    self.topParallelogramView.axcAE_X = self.axcAE_Width/2 - self.centerLineWidth/2;
//    self.buttomParallelogramView.axcAE_X = self.axcAE_Width/2 - self.centerLineWidth/2;
//}
//// 设置四边形到起点
//- (void)reloadParallelogramStartPoint{
//    CGFloat spacing = 2;
//    self.topParallelogramView.frame = CGRectMake(self.axcAE_Width/2 - self.centerLineWidth/2 + self.insetsMargin.right,
//                                                 self.insetsMargin.top + spacing,
//                                                 self.centerLineWidth - self.lineSpacing,
//                                                 self.bevelLineHeight - 2*spacing);
//    self.buttomParallelogramView.frame = CGRectMake(self.axcAE_Width/2 - self.centerLineWidth/2 - self.insetsMargin.left,
//                                                    self.axcAE_Height - self.insetsMargin.bottom - self.bevelLineHeight + spacing,
//                                                    self.centerLineWidth - self.lineSpacing,
//                                                    self.bevelLineHeight - 2*spacing);
//}
//// 隐藏四边形
//- (void)hiddenParallelogram:(BOOL)hidden{
//    self.topParallelogramView.hidden = hidden;
//    self.buttomParallelogramView.hidden = hidden;
//}
//// 设置小点隐藏
//- (void)reloadPointHidden:(BOOL)hidden{// 隐藏全部末端小点
//    [self.lineExtremeViewsArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.hidden = hidden;
//    }];
//}
//// 设置小点到开始
//- (void)reloadPointStart{
//    // 遍历所有线段，获取其中心点
//    __block int countView_i = 0;
//    [self.fourEdgesArray enumerateObjectsUsingBlock:^(NSArray<NSValue *> * _Nonnull obj_i, NSUInteger idx_i, BOOL * _Nonnull stop_i) {
//        __block CGPoint centerPoint = [self calculateCenterPoint_1:obj_i.firstObject.CGPointValue
//                                                           point_2:obj_i.lastObject.CGPointValue];
//        [obj_i enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj_j, NSUInteger idx_j, BOOL * _Nonnull stop_j) {
//            UIView *pointView = [self.lineExtremeViewsArray objectAtIndex:countView_i];
//            pointView.center = centerPoint;
//            countView_i ++; // 设置所在位置
//        }];
//    }];
//}
//// 设置小点到终点
//- (void)reloadPointExtreme{
//    __block int countView_j = 0;
//    [self.fourEdgesArray enumerateObjectsUsingBlock:^(NSArray<NSValue *> * _Nonnull obj_i, NSUInteger idx_i, BOOL * _Nonnull stop_i) {
//        [obj_i enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj_j, NSUInteger idx_j, BOOL * _Nonnull stop_j) {
//            UIView *pointView = [self.lineExtremeViewsArray objectAtIndex:countView_j];
//            pointView.center = obj_j.CGPointValue;
//            // 闪烁一次
//            [UIView animateWithDuration:0.1 animations:^{
//                pointView.alpha = 0.3;
//            }completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.1 animations:^{
//                    pointView.alpha = 1;
//                }completion:^(BOOL finished) {
//                    [UIView animateWithDuration:0.1 animations:^{
//                        pointView.alpha = 0.3;
//                    }completion:^(BOOL finished) {
//                        [UIView animateWithDuration:0.1 animations:^{
//                            pointView.alpha = 1;
//                        }];
//                    }];
//                }];
//            }];
//            countView_j ++; // 改变所在位置
//        }];
//    }];
//}
//- (void)reloadViewParm{
//    self.topParallelogramView.shortLength = -self.bevelLineHeight;
//    self.buttomParallelogramView.shortLength = self.bevelLineHeight;
//}
//
//- (void)reloadLinePoints{
//    self.fourEdgesArray =
//    @[@[[NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.insetsMargin.top + self.edgesLineHeight + self.lineSpacing)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight - self.lineSpacing)]
//        ],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.left,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight - self.lineSpacing)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right,
//                     self.insetsMargin.top + self.edgesLineHeight + self.lineSpacing)]
//        ],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right - self.edgesLineWidth,
//                     self.insetsMargin.top + self.edgesLineHeight/2)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left + self.edgesLineWidth,
//                     self.insetsMargin.top + self.edgesLineHeight/2)]],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left + self.edgesLineWidth,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight/2)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right - self.edgesLineWidth,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight/2)]
//        ]
//      ].mutableCopy;
//    [self.fourEdgesArray enumerateObjectsUsingBlock:^(NSArray<NSValue *> * _Nonnull linePoints, NSUInteger idx, BOOL * _Nonnull stop) {
//        CAShapeLayer *layer = [self.lineLayersArray objectAtIndex:idx];
//        layer.path = [self AxcAE_BaseSettingLineArray:linePoints].CGPath;
//    }];
//    // 二阶的坐标
//    CGFloat centerLeftWidth = self.axcAE_Width/2 - (self.insetsMargin.left + self.bevelLineHeight + self.centerLineWidth/2);
//    CGFloat centerRightX = self.axcAE_Width/2 - self.centerLineWidth/2 - self.lineSpacing;
//    self.phase2FourEdgesArray =
//    @[@[[NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.insetsMargin.top + self.edgesLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.insetsMargin.top + self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left + self.bevelLineHeight,
//                     self.insetsMargin.top )],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth,
//                     self.insetsMargin.top )],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth + self.bevelLineHeight,
//                     self.insetsMargin.top + self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth + self.bevelLineHeight + self.centerLineWidth,
//                     self.insetsMargin.top + self.bevelLineHeight)],
//        ],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.insetsMargin.left + self.bevelLineHeight,
//                     self.axcAE_Height - self.insetsMargin.bottom )],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth,
//                     self.axcAE_Height - self.insetsMargin.bottom )],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth + self.bevelLineHeight,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerLeftWidth + self.bevelLineHeight + self.centerLineWidth,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.bevelLineHeight)],
//        ],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right,
//                     self.insetsMargin.top + self.edgesLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right,
//                     self.insetsMargin.top + self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right - self.bevelLineHeight,
//                     self.insetsMargin.top )],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerRightX,
//                     self.insetsMargin.top )]
//        ],
//      @[[NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.edgesLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right,
//                     self.axcAE_Height - self.insetsMargin.bottom - self.bevelLineHeight)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(self.axcAE_Width - self.insetsMargin.right - self.bevelLineHeight,
//                     self.axcAE_Height - self.insetsMargin.bottom)],
//        [NSValue valueWithCGPoint:
//         CGPointMake(centerRightX,
//                     self.axcAE_Height - self.insetsMargin.bottom)]
//        ],
//      ].mutableCopy;
//    [self.phase2FourEdgesArray enumerateObjectsUsingBlock:^(NSArray<NSValue *> * _Nonnull linePoints, NSUInteger idx, BOOL * _Nonnull stop) {
//        CAShapeLayer *layer = [self.phase2lineLayersArray objectAtIndex:idx];
//        layer.path = [self AxcAE_BaseSettingLineArray:linePoints].CGPath;
//    }];
//}
//- (void)settingLineLayerColor:(CAShapeLayer *)layer{
//    layer.fillColor=[UIColor clearColor].CGColor;//填充颜色
//    layer.strokeColor = self.tintColor.CGColor;     //边框颜色
//}
//// 计算两条线之间的中心点
//- (CGPoint )calculateCenterPoint_1:(CGPoint )point_1 point_2:(CGPoint )point_2{
//    CGFloat maxX = MAX(point_1.x, point_2.x);
//    CGFloat minX = MIN(point_1.x, point_2.x);
//    CGFloat maxY = MAX(point_1.y, point_2.y);
//    CGFloat minY = MIN(point_1.y, point_2.y);
//    CGFloat centerX = (maxX - minX)/2 + minX;
//    CGFloat centerY = (maxY - minY)/2 + minY;
//    return CGPointMake(centerX, centerY);
//}
//#pragma mark - SET/GET
//#pragma mark - 懒加载
//- (AxcAE_ParallelogramView *)buttomParallelogramView{
//    if (!_buttomParallelogramView) {
//        _buttomParallelogramView = [AxcAE_ParallelogramView new];
//        _buttomParallelogramView.tintColor = self.tintColor;
//        _buttomParallelogramView.hidden = YES;
//        [self addSubview:_buttomParallelogramView];
//        _buttomParallelogramView.backgroundColor = [UIColor clearColor];
//        [_buttomParallelogramView draw];
//    }
//    return _buttomParallelogramView;
//}
//- (AxcAE_ParallelogramView *)topParallelogramView{
//    if (!_topParallelogramView) {
//        _topParallelogramView = [AxcAE_ParallelogramView new];
//        _topParallelogramView.tintColor = self.tintColor;
//        _topParallelogramView.hidden = YES;
//        [self addSubview:_topParallelogramView];
//        _topParallelogramView.backgroundColor = [UIColor clearColor];
//        [_topParallelogramView draw];
//    }
//    return _topParallelogramView;
//}
//
//- (NSMutableArray<CAShapeLayer *> *)phase2lineLayersArray{
//    if (!_phase2lineLayersArray) {
//        _phase2lineLayersArray = @[].mutableCopy;
//        [_phase2lineLayersArray addObject:self.leftTopLineLayer];
//        [_phase2lineLayersArray addObject:self.leftButtomLineLayer];
//        [_phase2lineLayersArray addObject:self.rightTopLineLayer];
//        [_phase2lineLayersArray addObject:self.rightButtomLineLayer];
//    }
//    return _phase2lineLayersArray;
//}
//- (CAShapeLayer *)leftTopLineLayer{
//    if (!_leftTopLineLayer) {
//        _leftTopLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_leftTopLineLayer];
//    }
//    return _leftTopLineLayer;
//}
//- (CAShapeLayer *)leftButtomLineLayer{
//    if (!_leftButtomLineLayer) {
//        _leftButtomLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_leftButtomLineLayer];
//    }
//    return _leftButtomLineLayer;
//}
//- (CAShapeLayer *)rightTopLineLayer{
//    if (!_rightTopLineLayer) {
//        _rightTopLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_rightTopLineLayer];
//    }
//    return _rightTopLineLayer;
//}
//- (CAShapeLayer *)rightButtomLineLayer{
//    if (!_rightButtomLineLayer) {
//        _rightButtomLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_rightButtomLineLayer];
//    }
//    return _rightButtomLineLayer;
//}
//
//- (NSMutableArray<UIView *> *)lineExtremeViewsArray{
//    if (!_lineExtremeViewsArray) {
//        _lineExtremeViewsArray = @[].mutableCopy;
//        for (int i = 0; i < 8 ; i++) {
//            UIView *pointView = [UIView new];
//            pointView.backgroundColor = self.tintColor;
//            pointView.axcAE_Size = self.lineExtremePointSize;
//            pointView.layer.masksToBounds = YES;
//            pointView.layer.cornerRadius = MAX(pointView.axcAE_Width, pointView.axcAE_Height)/2;
//            pointView.hidden = YES;
//            [self addSubview:pointView];
//            [_lineExtremeViewsArray addObject: pointView];
//        }
//    }
//    return _lineExtremeViewsArray;
//}
//- (NSMutableArray *)lineLayersArray{
//    if (!_lineLayersArray) {
//        _lineLayersArray = @[].mutableCopy;
//        [_lineLayersArray addObject:self.leftLineLayer];
//        [_lineLayersArray addObject:self.rightLineLayer];
//        [_lineLayersArray addObject:self.topLineLayer];
//        [_lineLayersArray addObject:self.buttomLineLayer];
//    }
//    return _lineLayersArray;
//}
//- (CAShapeLayer *)leftLineLayer{
//    if (!_leftLineLayer) {
//        _leftLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_leftLineLayer];
//    }
//    return _leftLineLayer;
//}
//- (CAShapeLayer *)rightLineLayer{
//    if (!_rightLineLayer) {
//        _rightLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_rightLineLayer];
//    }
//    return _rightLineLayer;
//}
//- (CAShapeLayer *)topLineLayer{
//    if (!_topLineLayer) {
//        _topLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_topLineLayer];
//    }
//    return _topLineLayer;
//}
//- (CAShapeLayer *)buttomLineLayer{
//    if (!_buttomLineLayer) {
//        _buttomLineLayer = [CAShapeLayer layer];
//        [self settingLineLayerColor:_buttomLineLayer];
//    }
//    return _buttomLineLayer;
//}
//
//
//@end
