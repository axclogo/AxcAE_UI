//
//  AxcAE_RingDrawView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/15.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_RingDrawView.h"

@implementation AxcAE_RingDrawView
- (instancetype)initWithDrawModels:(NSArray<AxcAE_RingDrawModel *> *)drawModels{
    if (self == [super init]) {
        self.drawModels = drawModels;
    }
    return self;
}

// 自适应布局
- (void)layoutSubviews{
    [super layoutSubviews]; // 如果反复设置父类View的frame会不断重绘所有Layer层
    CGFloat sideLength = MIN(self.axcAE_Width, self.axcAE_Height); // 取最短边长
    if (sideLength > 0) {
        __block CGFloat internalDistance = 0; // 内边距计数
        [self.drawModels enumerateObjectsUsingBlock:^(AxcAE_RingDrawModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            internalDistance += obj.distance; // 依次圆心向内绘制
            // 图层大小
            CGSize layerSize = CGSizeMake(sideLength - 2*internalDistance, sideLength - 2*internalDistance);
            CGPoint layerPoint = CGPointZero;
            switch (self.verticalDrawPoints) {
                case AxcAE_Ring_VerticalDrawPointsTop:{
                    layerPoint.y = internalDistance;
                }break;
                case AxcAE_Ring_VerticalDrawPointsBottom:{
                    layerPoint.y = self.axcAE_Height - (internalDistance + layerSize.height);
                }break;
                default:{ // 其余定义全部默认中心
                    layerPoint.y = self.axcAE_Height/2.f - layerSize.height/2.f;
                }break;
            }
            switch (self.horizontalDrawPoints) {
                case AxcAE_Ring_HorizontalDrawPointsLeft:{
                    layerPoint.x = internalDistance;
                } break;
                case AxcAE_Ring_HorizontalDrawPointsRight:{
                    layerPoint.x = self.axcAE_Width -  (internalDistance + layerSize.width);
                } break;
                default:{ // 其余定义全部默认中心
                    layerPoint.x = self.axcAE_Width/2.f - layerSize.width/2.f;
                }break;
            }
            obj.layer.frame = CGRectMake(layerPoint.x, layerPoint.y, layerSize.width, layerSize.height);
        }];
    }else{
        NSLog(@"绘制失败！长宽绘制区域，宽高至少需要有一个不小于0！");
    }
}
// 获取适配标准坐标
- (CGRect )layoutStandardCoordinates:(CGFloat )sideLength internalDistance:(CGFloat )internalDistance{
    // 图层大小
    CGSize layerSize = CGSizeMake(sideLength - 2*internalDistance, sideLength - 2*internalDistance);
    CGPoint layerPoint = CGPointZero;
    switch (self.verticalDrawPoints) {
        case AxcAE_Ring_VerticalDrawPointsTop:{
            layerPoint.y = internalDistance;
        }break;
        case AxcAE_Ring_VerticalDrawPointsBottom:{
            layerPoint.y = self.axcAE_Height - (internalDistance + layerSize.height);
        }break;
        default:{ // 其余定义全部默认中心
            layerPoint.y = self.axcAE_Height/2.f - layerSize.height/2.f;
        }break;
    }
    switch (self.horizontalDrawPoints) {
        case AxcAE_Ring_HorizontalDrawPointsLeft:{
            layerPoint.x = internalDistance;
        } break;
        case AxcAE_Ring_HorizontalDrawPointsRight:{
            layerPoint.x = self.axcAE_Width -  (internalDistance + layerSize.width);
        } break;
        default:{ // 其余定义全部默认中心
            layerPoint.x = self.axcAE_Width/2.f - layerSize.width/2.f;
        }break;
    }
    return CGRectMake(layerPoint.x, layerPoint.y, layerSize.width, layerSize.height);
}

// 开始动画
- (void)startAnimation{
    [self.drawModels enumerateObjectsUsingBlock:^(AxcAE_RingDrawModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.animationBlock) { // 判断是否实现动画
            [obj.layer addAnimation:obj.animationBlock() forKey:kAnimationBlockKey];
        }
    }];
}
// 重感调用时偏移
- (void)offsetWithGyroscope:(AxcAE_Gyroscope)gyroscope{
    double gravityX = gyroscope.x;
    double gravityY = gyroscope.y;
    // 偏移率
    CGFloat gravityOffset = self.migrationRate;
    CGFloat sideLength = MIN(self.axcAE_Width, self.axcAE_Height); // 取最短边长
    __block CGFloat internalDistance = 0; // 内边距计数
    [self.drawModels enumerateObjectsUsingBlock:^(AxcAE_RingDrawModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        internalDistance += obj.distance ;
        CGRect coordinates  = [self layoutStandardCoordinates:sideLength internalDistance:internalDistance];
        CGRect layerFrame = obj.layer.frame;
        layerFrame.origin.y = coordinates.origin.y + -((gravityY + self.compensationCoefficient) *idx * gravityOffset) *self.offsetMultiple;
        layerFrame.origin.x = coordinates.origin.x + ((gravityX *idx * gravityOffset)) *self.offsetMultiple;
        obj.layer.frame = layerFrame;
    }];
}

#pragma mark - SET
- (void)setDrawModels:(NSArray<AxcAE_RingDrawModel *> *)drawModels{
    _drawModels = drawModels;
    // 设置绘制的图片
    [_drawModels enumerateObjectsUsingBlock:^(AxcAE_RingDrawModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tintColor && obj.image) { // 设置了渲染颜色并且有图片
            obj.image = [self AxcAE_BaseSettingTintColorWithObj:obj];// 重绘颜色
        }
        if (obj.image) obj.layer.contents = (__bridge id)obj.image.CGImage;
        [self.layer addSublayer:obj.layer]; // 图层层级过多会占用资源造成卡顿，卡顿情况会根据设备不同
    }];
}

@end







@implementation AxcAE_RingDrawModel
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)imageModelWithImage:(UIImage *)image{
    return [self imageModelWithImage:image
                   internalDistance:0];
}
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)imageModelWithImage:(UIImage *)image
                           internalDistance:(CGFloat )internalDistance{
    return [self imageModelWithImage:image
                   internalDistance:internalDistance
                          tintColor:nil];
}
/** 快速实例化类方法 */
+ (AxcAE_RingDrawModel *)imageModelWithImage:(UIImage *)image
                           internalDistance:(CGFloat )internalDistance
                                  tintColor:(UIColor *)tintColor{
    AxcAE_RingDrawModel *model = [[AxcAE_RingDrawModel alloc] init];
    if (image) model.image = image;
    if(internalDistance) model.distance = internalDistance;
    if (tintColor) model.tintColor = tintColor;
    return model;
}

@end

