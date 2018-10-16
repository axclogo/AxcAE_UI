//
//  AxcAE_Scale.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/10.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseControl.h"
#import "AxcAE_DrawBoard.h"
#import "AxcLayerBrush.h"

@class AxcAE_ScaleDrawView;
/** 参数回调Block */
typedef void(^AxcAE_ScaleValueChangeBlock )(AxcAE_ScaleDrawView *scale,CGFloat value);

@protocol AxcAE_ScaleDelegate <NSObject>
@optional
/** 参数发生改变 */
- (void)AxcAE_Scale:(AxcAE_ScaleDrawView *)scale value:(CGFloat )value;
/** 每当重绘文字时候会调用 */
- (void)AxcAE_Scale:(AxcAE_ScaleDrawView *)scale textLayer:(CATextLayer *)textLayer idx:(NSInteger )idx;
@end

@interface AxcAE_ScaleDrawView : AxcAE_BaseControl <UIScrollViewDelegate> 
#pragma mark 刻度设置
/** 大刻度个数 默认20 */
@property(nonatomic , assign)NSInteger count;
/** 大刻度中间的小刻度个数 默认10 */
@property(nonatomic , assign)NSInteger groupCount;
/** 大刻度高度 默认20 */
@property(nonatomic , assign)CGFloat bigScaleHeight;
/** 小刻度高度 默认10 */
@property(nonatomic , assign)CGFloat smallScaleHeight;
/** 刻度间距 默认5 */
@property(nonatomic , assign)CGFloat spacing;
/** 线宽 默认0.5 */
@property(nonatomic , assign)CGFloat lineWidth;

#pragma mark 指示器设置
/** 指示器线宽 默认 1 */
@property(nonatomic , assign)CGFloat indicatorWidth;
/** 指示器颜色 默认 1 */
@property(nonatomic , strong)UIColor *indicatorColor;

#pragma mark 数值设置
/** 最小值 默认0 */
@property(nonatomic , assign)CGFloat minValue;
/** 最大值 默认20 */
@property(nonatomic , assign)CGFloat maxValue;
/** 值 */
@property(nonatomic , assign)CGFloat value;

#pragma mark 文字设置
/** 单位 默认无 */
@property(nonatomic , strong)NSString *unit;
/** 文字层Layer的大小 默认50*30 */
@property(nonatomic , assign)CGSize textLayerSize;
/** 文字层颜色 默认TingColor */
@property(nonatomic , strong)UIColor *textColor;
/** 文字层大小 默认10 */
@property(nonatomic , assign)CGFloat fontSize;

#pragma mark 附加设置
/** 滚动对齐 默认NO */
@property(nonatomic , assign)BOOL isScrollAlign;
/** 开启渐变 默认YES */
@property(nonatomic , assign)BOOL isGradient;

#pragma mark - 对象
// 代理
@property(nonatomic , weak)id <AxcAE_ScaleDelegate>delegate;
// 回调Block
@property(nonatomic , copy)AxcAE_ScaleValueChangeBlock scaleValueChangeBlock;
// 滑动层
@property(nonatomic , strong)UIScrollView *scrollView;
// 刻度底盘绘制层
@property(nonatomic , strong)AxcAE_DrawBoard *chassisBoard;
// 刻度图层
@property(nonatomic , strong)CAShapeLayer *scaleLayer;
// 刻度线段
@property(nonatomic , strong)UIBezierPath *scaleBezierPath;
// 指示器图层
@property(nonatomic , strong)CAShapeLayer *indicatorLayer;
// 渐变图层
@property(nonatomic , strong)CAGradientLayer *gradientLayer;

#pragma mark 函数
/** 刷新文字Layer */
- (void)reloadTextLayer;

@end
