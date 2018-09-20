//
//  CAShapeLayer+AxcAE_LayerAttribute.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (AxcAE_LayerAttribute)

/**
 重绘用的
 */
@property(nonatomic , strong)UIBezierPath *drawPath;


/**
 标签
 */
@property(nonatomic , assign)NSInteger tag;


@end
