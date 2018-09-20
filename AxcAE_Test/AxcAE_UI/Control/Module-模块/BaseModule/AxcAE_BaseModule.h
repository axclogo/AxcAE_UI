//
//  AxcAE_BaseModule.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseControl.h"

/** 当视图不为正方形时，纵向绘制点位 默认Center*/
typedef NS_ENUM(NSInteger, AxcAE_Ring_VerticalDrawPoints) {
    AxcAE_Ring_VerticalDrawPointsCenter,
    AxcAE_Ring_VerticalDrawPointsTop,
    AxcAE_Ring_VerticalDrawPointsBottom,
};
/** 当视图不为正方形时，横向绘制点位 默认Center*/
typedef NS_ENUM(NSInteger, AxcAE_Ring_HorizontalDrawPoints) {
    AxcAE_Ring_HorizontalDrawPointsCenter,
    AxcAE_Ring_HorizontalDrawPointsLeft,
    AxcAE_Ring_HorizontalDrawPointsRight,
};

@interface AxcAE_BaseModule : AxcAE_BaseControl

/** 当视图不为正方形时，纵向绘制点位 默认Center*/
@property(nonatomic , assign)AxcAE_Ring_VerticalDrawPoints verticalDrawPoints;

/** 当视图不为正方形时，横向绘制点位 默认Center*/
@property(nonatomic , assign)AxcAE_Ring_HorizontalDrawPoints horizontalDrawPoints;

/** 开始动画 */
- (void)startAnimation;


#pragma mark - 重感
/** 重感时候传入此参数展示立体效果 */
@property(nonatomic , assign)AxcAE_Gyroscope gyroscope;

/** 一旦发生重感事件就会向所有子类通知偏移量参数 */
- (void)offsetWithGyroscope:(AxcAE_Gyroscope)gyroscope;

/** 重感偏移倍数，倍数越接近1，偏移距离越大，默认0.1 */
@property(nonatomic , assign)CGFloat offsetMultiple;

/** Y轴倾斜补偿系数 默认0.5 倾斜45度时修正为0偏移 */
@property(nonatomic , assign)CGFloat compensationCoefficient;

/** 偏移率 默认100 */
@property(nonatomic , assign)CGFloat migrationRate;


@end
