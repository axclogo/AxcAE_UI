//
//  AxcAE_BaseDrawModule.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseModule.h"

/** 动画回调Block */
typedef CAAnimation *(^AxcAE_AnimationBlock )(void);

@interface AxcAE_BaseDrawModule : AxcAE_BaseModule

/** 给Image重绘颜色 */
- (UIImage *)AxcAE_BaseSettingTintColorWithObj:(AxcAE_BaseObject *)obj;

@end
