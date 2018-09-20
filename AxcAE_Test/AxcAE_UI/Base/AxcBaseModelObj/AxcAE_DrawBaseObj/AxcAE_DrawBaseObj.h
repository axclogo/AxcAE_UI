//
//  AxcAE_DrawBaseObj.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseObject.h"

#define kAnimationBlockKey @"AnimationBlockKey"


@interface AxcAE_DrawBaseObj : AxcAE_BaseObject
/** Layer层 */
@property(nonatomic , strong)CALayer *layer;

@end
