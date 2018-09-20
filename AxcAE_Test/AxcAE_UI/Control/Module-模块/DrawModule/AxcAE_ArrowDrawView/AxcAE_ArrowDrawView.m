//
//  AxcAE_ArrowDrawView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ArrowDrawView.h"

@interface AxcAE_ArrowDrawView ()


@end

@implementation AxcAE_ArrowDrawView
- (void)AxcAE_BaseConfiguration{
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 发生布局
    CGFloat headerX = self.bounds.size.width;
    __block AxcAE_ArrowBody *onArrow = nil;
    [self.arrowBodys enumerateObjectsUsingBlock:^(AxcAE_ArrowBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat arrowBodyX = headerX - obj.width;
        if (onArrow){
            arrowBodyX = onArrow.layer.frame.origin.x - onArrow.distance - obj.width;
        }
        obj.layer.frame = CGRectMake(arrowBodyX, 0, obj.width, self.self.bounds.size.height);
        onArrow = obj;
    }];
    onArrow = nil;
}

- (void)startAnimation{
    [self.arrowBodys enumerateObjectsUsingBlock:^(AxcAE_ArrowBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.animationBlock) { // 判断是否实现动画
            [obj.layer addAnimation:obj.animationBlock() forKey:kAnimationBlockKey];
        }
    }];
}

#pragma mark - SET
- (void)setArrowBodys:(NSArray<AxcAE_ArrowBody *> *)arrowBodys{
    _arrowBodys = arrowBodys;
    // 设置绘制图片并添加到图层
    [_arrowBodys enumerateObjectsUsingBlock:^(AxcAE_ArrowBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tintColor && obj.image) { // 设置了渲染颜色并且有图片
            obj.image = [self AxcAE_BaseSettingTintColorWithObj:obj];// 重绘颜色
        }
        obj.layer.contents = (__bridge id)obj.image.CGImage;
        [self.layer addSublayer:obj.layer];
    }];
}
- (void)setArrowTowardAngle:(CGFloat)arrowTowardAngle{
    _arrowTowardAngle = arrowTowardAngle;
    self.transform = CGAffineTransformMakeRotation(arrowTowardAngle);
}

@end


@implementation AxcAE_ArrowBody
- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.distance = 5; // 重置为5
    self.width = 10.f;
}
@end

