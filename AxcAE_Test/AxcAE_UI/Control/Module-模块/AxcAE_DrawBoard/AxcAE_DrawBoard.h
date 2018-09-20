//
//  AxcAE_DrawBoard.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseModule.h"
// 贝塞尔画笔
#import "AxcDrawPath.h"
// Layer工厂类
#import "AxcLayerBrush.h"

#import "NSObject+AxcAE_ObjAttribute.h"

/**
 画板
 */
@interface AxcAE_DrawBoard : AxcAE_BaseModule

/**
 绘制这个Layer
 @param layer layer
 */
- (void)drawSublayer:(CAShapeLayer *)layer;
- (void)drawSublayer:(CAShapeLayer *)layer withKey:(NSString *)key;

/**
 子Layer层的所有Layer
 */
@property(nonatomic , strong)NSMutableDictionary *sublayerMap;

/**
 根据Tag标签获取Layer
 */
- (CAShapeLayer *)layerWithTag:(NSInteger )tag;

- (void )draw;

@end
