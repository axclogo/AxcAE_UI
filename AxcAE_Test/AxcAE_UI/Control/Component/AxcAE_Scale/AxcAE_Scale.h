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

@class AxcAE_Scale;
/** 参数回调Block */
typedef void(^AxcAE_ScaleValueChangeBlock )(AxcAE_Scale *scale,CGFloat value);

@protocol AxcAE_ScaleDelegate <NSObject>
/** 参数发生改变 */
- (void)AxcAE_Scale:(AxcAE_Scale *)scale value:(CGFloat )value;

@end


@interface AxcAE_Scale : AxcAE_BaseControl <UIScrollViewDelegate> 

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

/** 指示器线宽 默认 1 */
@property(nonatomic , assign)CGFloat indicatorWidth;

/** 最小值 默认0 */
@property(nonatomic , assign)CGFloat minValue;
/** 最大值 默认20 */
@property(nonatomic , assign)CGFloat maxValue;

/** 值 */
@property(nonatomic , assign)CGFloat value;

/** 滚动对齐 默认NO */
@property(nonatomic , assign)BOOL isScrollAlign;

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

@end
