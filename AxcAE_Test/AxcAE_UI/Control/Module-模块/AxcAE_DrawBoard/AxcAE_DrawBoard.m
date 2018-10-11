//
//  AxcAE_DrawBoard.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_DrawBoard.h"

@interface AxcAE_DrawBoard ()

@end

@implementation AxcAE_DrawBoard
#pragma mark - 重写
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.sublayerMap enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) { // 断定是Layer层
            CAShapeLayer *layer = obj;
            UIBezierPath *drawPath = layer.drawPath;
            layer.path = drawPath.CGPath;
            [self.layer addSublayer:layer];
        }
    }];
}
#pragma mark - 实用函数区
- (CAShapeLayer *)layerWithTag:(NSInteger )tag{
    __block CAShapeLayer *returnLayer = nil;
    [self.sublayerMap enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) { // 断定是Layer层
            CAShapeLayer *layer = obj;
            if (layer.tag == tag) {
                returnLayer = layer;
                *stop = YES; // 效率能省则省吧。。
            }
        }
    }];
    return returnLayer;
}
// 添加Layer层到视图
- (void)drawSublayer:(CALayer *)layer{ // 默认用内存地址做Key，方便查找和特殊用途
    [self drawSublayer:layer withKey:[NSString stringWithFormat:@"%p",layer]];
}
- (void)drawSublayer:(CALayer *)layer withKey:(NSString *)key{
    [self.sublayerMap setObject:layer forKey:key];
    [self.layer addSublayer:layer];
}
- (void)draw{
    
}

#pragma mark - 懒加载
- (NSMutableDictionary *)sublayerMap{
    if (!_sublayerMap) {
        _sublayerMap = @{}.mutableCopy;
    }
    return _sublayerMap;
}

@end
