//
//  AxcAE_RingDrawView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/15.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseDrawModule.h"

@interface AxcAE_RingDrawModel : AxcAE_DrawBaseObj

/** 动画回调Block */
@property(nonatomic , copy)AxcAE_AnimationBlock animationBlock;

#pragma mark - 实例化方法
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)drawModelWithImage:(UIImage *)image;
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)drawModelWithImage:(UIImage *)image
                           internalDistance:(CGFloat )internalDistance;
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)drawModelWithImage:(UIImage *)image
                           internalDistance:(CGFloat )internalDistance
                                  tintColor:(UIColor *)tintColor;
@end



#pragma mark - 绘制方位
@interface AxcAE_RingDrawView : AxcAE_BaseDrawModule

/** 快速实例化 */
- (instancetype)initWithDrawModels:(NSArray<AxcAE_RingDrawModel *>*)drawModels;

/** 要绘制的对象 */
@property(nonatomic , strong)NSArray<AxcAE_RingDrawModel *>*drawModels;

@end
