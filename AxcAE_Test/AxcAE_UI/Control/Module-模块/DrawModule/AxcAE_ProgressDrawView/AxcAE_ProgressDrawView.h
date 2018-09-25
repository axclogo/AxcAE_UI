//
//  AxcAE_ProgressDrawView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/21.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseDrawModule.h"

/** 外观类型 */
typedef NS_ENUM(NSInteger, AxcAE_ProgressDrawStyle) {
    AxcAE_ProgressDrawStyleRoundedVitro,            // 圆角试管型
    AxcAE_ProgressDrawStyleRectangleVitro,          // 方角试管型
    
    AxcAE_ProgressDrawStyleExpectRectangleHead,     // 方角头预期型
    AxcAE_ProgressDrawStyleExpectFlatHead,          // 平角头预期型
    
    AxcAE_ProgressDrawStyleRoundedBattery,          // 圆角电池型
    AxcAE_ProgressDrawStyleRectangleBattery,        // 方角电池型
    
    AxcAE_ProgressDrawStyleThermometer,             // 温度计型
    AxcAE_ProgressDrawStyleDialGauge,               // 刻度计型
};

/** 绘制方向 */
typedef NS_ENUM(NSInteger, AxcAE_ProgressDrawDirection) {
    AxcAE_ProgressDrawDirectionBottom,   // 从底部向顶部展示进度
    AxcAE_ProgressDrawDirectionTop       // 从顶部向下展示进度
};
@class AxcAE_ProgressDrawView;
@protocol AxcAE_ProgressDrawViewDelegate <NSObject>
/** 进度展示区域代理回调 */
- (CGRect )contentAreaWithProgressDrawView:(AxcAE_ProgressDrawView *)progressDrawView;
@end

@interface AxcAE_ProgressDrawView : AxcAE_BaseDrawModule

/** 快速实例化 */
- (instancetype)initWithStyle:(AxcAE_ProgressDrawStyle )style;

/** 外观模式 */
@property(nonatomic , assign)AxcAE_ProgressDrawStyle style;

/** 绘制方向 默认从底部向顶部 */
@property(nonatomic , assign)AxcAE_ProgressDrawDirection drawDirection;

/** 代理 */
@property(nonatomic , weak)id<AxcAE_ProgressDrawViewDelegate>delegate;

/** 比例 */
@property(nonatomic , assign)CGFloat proportion;

/** 内容间距 默认3 */
@property(nonatomic , assign)CGFloat contentSpacing;

/** 网格高度 默认5 */
@property(nonatomic , assign)CGFloat gridHeight;

/** 网格间距 默认2 如果为0则为填充型，非网格型 */
@property(nonatomic , assign)CGFloat gridSpacing;

/** 网格边框虚线参数 默认nil 实线 */
@property(nonatomic , strong)NSArray <NSNumber *>*gridLineDashPattern;

/** 网格边框颜色 默认 whiteColor */
@property(nonatomic , strong)UIColor *gridBorderColor;

/** 网格边框宽度 默认 0.5f */
@property(nonatomic , assign)CGFloat gridBorderWidth;

/** 网格填充颜色 默认 tintColor */
@property(nonatomic , strong)UIColor *gridFillColor;

/** 头部高度 默认 10 */
@property(nonatomic , assign)CGFloat headerHeight;


#pragma mark - Layer层 以及固定外观参数
/** 内容Layer */
@property(nonatomic , strong)CAShapeLayer *contentLayer;

/** 进度Layer */
@property(nonatomic , strong)CAShapeLayer *progressLayer;

// 预计型的Layer 打底图案
@property(nonatomic , strong)CAShapeLayer *rectangleLayer;

// 电池型的Layer 打底图案
@property(nonatomic , strong)CAShapeLayer *batteryLayer;

/** 电池头左右间距 默认10 */
@property(nonatomic , assign)CGFloat batteryHeaderSpacing;

/** 温度计的遮罩层 */
@property(nonatomic , strong)CAShapeLayer *thermometerMaskLayer;

/** 温度计的边缘描边层 */
@property(nonatomic , strong)CAShapeLayer *thermometerLayer;

/** 温度计宽度 默认10 */
@property(nonatomic , assign)CGFloat thermometerBodyWidth;

/** 刻度计Layer */
@property(nonatomic , strong)CAShapeLayer *dialGaugeLayer;

/** 刻度间距 默认3.0 */
@property(nonatomic , assign)CGFloat dialGaugeSpacing;

@end
