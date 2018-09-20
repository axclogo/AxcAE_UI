//
//  AxcAE_ArrowDrawView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseDrawModule.h"

@interface AxcAE_ArrowBody : AxcAE_DrawBaseObj
/** 箭头宽度 默认10 */
@property(nonatomic , assign)CGFloat width;
/** 动画回调Block */
@property(nonatomic , copy)AxcAE_AnimationBlock animationBlock;
/** 箭身向后间距 默认5*/
@property(nonatomic , assign)CGFloat arrowBodyBackwardSpacing;

@end

/** 偏移轴向，根据重感的X轴进行计算偏移  */
typedef NS_ENUM(NSInteger, AxcAE_ArrowGyroscopeOffset) {
    AxcAE_ArrowGyroscopeOffsetX,
    AxcAE_ArrowGyroscopeOffsetY
};
@interface AxcAE_ArrowDrawView : AxcAE_BaseDrawModule
/** 箭头朝向角度 */
@property(nonatomic , assign)CGFloat arrowTowardAngle;
/** 箭身 */
@property(nonatomic , strong)NSArray <AxcAE_ArrowBody *>*arrowBodys;
/** 偏移轴向，默认根据重感的X轴进行计算偏移  */
@property(nonatomic , assign)AxcAE_ArrowGyroscopeOffset gyroscopeOffset;
@end
