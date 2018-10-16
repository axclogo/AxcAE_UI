//
//  AxcAE_ScopeDrawView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/16.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseControl.h"

typedef NS_ENUM(NSInteger, AxcAE_ScopeDrawStyle) {
    AxcAE_ScopeDrawStyleThreePhase,                     // 三相线瞄准
    AxcAE_ScopeDrawStyleX,                              // X型瞄准
    AxcAE_ScopeDrawStyleXArrow,                         // 箭头+X型瞄准
    AxcAE_ScopeDrawStyleXArrowRectangular,              // 箭头+X型+矩形瞄准
};

NS_ASSUME_NONNULL_BEGIN

@interface AxcAE_ScopeDrawView : AxcAE_BaseControl


@property(nonatomic , assign)AxcAE_ScopeDrawStyle style;

@property(nonatomic , strong)CAShapeLayer *shapeLayer_1;
@property(nonatomic , strong)CAShapeLayer *shapeLayer_2;
@property(nonatomic , strong)CAShapeLayer *shapeLayer_3;
@property(nonatomic , strong)CAShapeLayer *shapeLayer_4;

@property(nonatomic , assign)CGFloat lineWidth;

- (void)draw;
- (void)drawTime:(CGFloat )time;
- (void)drawTime:(CGFloat )time timingFunction:(NSString *)timingFunction;
- (void)startContinuousAnimation;

- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
