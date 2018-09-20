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

@end
