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
    [super AxcAE_BaseConfiguration];
    self.gyroscopeOffset = AxcAE_ArrowGyroscopeOffsetX;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 发生布局
    CGFloat headerX = self.bounds.size.width;
    [self.arrowBodys enumerateObjectsUsingBlock:^(AxcAE_ArrowBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat arrowBodyX = headerX - obj.width - (idx * (obj.distance + obj.width) );
        obj.layer.frame = CGRectMake(arrowBodyX, 0, obj.width, self.self.bounds.size.height);
    }];
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
// 重感调用时偏移
- (void)offsetWithGyroscope:(AxcAE_Gyroscope)gyroscope{
    /*右正左负*/
    double gravityAmount = self.gyroscopeOffset==AxcAE_ArrowGyroscopeOffsetX ? fabs(gyroscope.x):fabs(gyroscope.y);
    // 偏移率
    CGFloat gravityOffset = self.migrationRate;
    CGFloat headerX = self.bounds.size.width;
    [self.arrowBodys enumerateObjectsUsingBlock:^(AxcAE_ArrowBody * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat arrowBodyX = headerX - obj.width - (idx * (obj.distance + obj.width) );
        CGRect layerFrame = CGRectMake(arrowBodyX, 0, obj.width, self.self.bounds.size.height); // 原有范围值
        // 获取中间的那个Layer
        NSInteger centerIdx = self.arrowBodys.count/2 ;
        CGFloat leftIdxGravity = ((gravityAmount - self.compensationCoefficient) *(idx - centerIdx) * gravityOffset);
        CGFloat rightIdxGravity = ((gravityAmount - self.compensationCoefficient) *(centerIdx -idx) * gravityOffset);
        // 设置以最低宽度为限，防止叠到一起,最低X偏移量等于相对宽度的X坐标值
        if (self.arrowBodys.count%2 == 0) { // 整除偶数
            if (idx < centerIdx) { // 右边的 坐标向右递减
                layerFrame.origin.x = layerFrame.origin.x - rightIdxGravity * self.offsetMultiple + obj.width;
            }else{ // 左边的
                layerFrame.origin.x = layerFrame.origin.x + leftIdxGravity * self.offsetMultiple + obj.width;
            }
        }else{  // 奇数
            if (idx < centerIdx) { // 右边的 坐标向右递减
                layerFrame.origin.x = layerFrame.origin.x - rightIdxGravity * self.offsetMultiple + obj.width;
            }else if (idx > centerIdx){ // 左边的
                layerFrame.origin.x = layerFrame.origin.x + leftIdxGravity * self.offsetMultiple + obj.width;
            }else{
                layerFrame.origin.x = layerFrame.origin.x - obj.width;
            }
        }
        obj.layer.frame = layerFrame;
    }];
}

@end


@implementation AxcAE_ArrowBody
- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.distance = 5; // 重置为5
    self.width = 10.f;
}
@end


