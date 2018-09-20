//
//  AxcAE_RingImageView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/15.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_RingImageView.h"

@implementation AxcAE_RingImageView
- (instancetype)initWithImageModels:(NSArray<AxcAE_RingImageModel *> *)imageModels{
    if (self == [super init]) {
        self.imageModels = imageModels;
    }
    return self;
}
// 配置
- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.migrationRate = 100;
    self.offsetMultiple = 0.1f;
    self.compensationCoefficient = 0.45f;
}
// 自适应布局
- (void)layoutSubviews{
    [super layoutSubviews]; // 如果反复设置父类View的frame会不断重绘所有Layer层
    CGFloat sideLength = MIN(self.axcAE_Width, self.axcAE_Height); // 取最短边长
    if (sideLength > 0) {
        __block CGFloat internalDistance = 0; // 内边距计数
        [self.imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            internalDistance += obj.distance; // 依次圆心向内绘制
            obj.imageView.frame = [self layoutStandardCoordinates:sideLength internalDistance:internalDistance];
        }];
    }else{
        NSLog(@"添加失败！长宽区域，宽高至少需要有一个不小于0！");
    }
}
// 开始动画
- (void)startAnimation{
    [self.imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.animationBlock) { // 判断是否实现动画
            obj.animationBlock(obj.imageView);
        }
    }];
}
// 获取适配标准坐标
- (CGRect )layoutStandardCoordinates:(CGFloat )sideLength internalDistance:(CGFloat )internalDistance{
    // 图层大小
    CGSize imageSize = CGSizeMake(sideLength - 2*internalDistance, sideLength - 2*internalDistance);
    CGPoint imagePoint = CGPointZero;
    switch (self.verticalDrawPoints) {
        case AxcAE_Ring_VerticalDrawPointsTop:{
            imagePoint.y = internalDistance;
        }break;
        case AxcAE_Ring_VerticalDrawPointsBottom:{
            imagePoint.y = self.axcAE_Height - (internalDistance + imageSize.height);
        }break;
        default:{ // 其余定义全部默认中心
            imagePoint.y = self.axcAE_Height/2.f - imageSize.height/2.f;
        }break;
    }
    switch (self.horizontalDrawPoints) {
        case AxcAE_Ring_HorizontalDrawPointsLeft:{
            imagePoint.x = internalDistance;
        } break;
        case AxcAE_Ring_HorizontalDrawPointsRight:{
            imagePoint.x = self.axcAE_Width -  (internalDistance + imageSize.width);
        } break;
        default:{ // 其余定义全部默认中心
            imagePoint.x = self.axcAE_Width/2.f - imageSize.width/2.f;
        }break;
    }
    return CGRectMake(imagePoint.x, imagePoint.y, imageSize.width, imageSize.height);
}

#pragma mark - SET
- (void)setImageModels:(NSArray<AxcAE_RingImageModel *> *)imageModels{
    _imageModels = imageModels;
    // 设置绘制的图片
    [_imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.image) obj.imageView.image = obj.image;
        if (obj.tintColor) { // 设置了渲染颜色并且有图片
            // 重绘颜色
            obj.imageView.image = [obj.imageView.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            obj.imageView.tintColor = obj.tintColor;
        }
        [self addSubview:obj.imageView]; // 图层层级过多会占用资源造成卡顿，卡顿情况会根据设备不同
    }];
}
// 重感调用时偏移
- (void)setGyroscope:(AxcAE_Gyroscope)gyroscope{
    double gravityX = gyroscope.x;
    double gravityY = gyroscope.y;
    // 偏移率
    CGFloat gravityOffset = self.migrationRate;
    CGFloat sideLength = MIN(self.axcAE_Width, self.axcAE_Height); // 取最短边长
    __block CGFloat internalDistance = 0; // 内边距计数
    [self.imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        internalDistance += obj.distance ;
        CGRect coordinates  = [self layoutStandardCoordinates:sideLength internalDistance:internalDistance];
        obj.imageView.axcAE_Y = coordinates.origin.y + -((gravityY + self.compensationCoefficient) *idx * gravityOffset) *self.offsetMultiple;
        obj.imageView.axcAE_X = coordinates.origin.x + ((gravityX *idx * gravityOffset)) *self.offsetMultiple;
    }];
}

@end










@implementation AxcAE_RingImageModel
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)drawModelWithImageView:(UIImageView *)imageView{
    return [self drawModelWithImageView:imageView
                               distance:0];
}
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)drawModelWithImageView:(UIImageView *)imageView
                                        distance:(CGFloat )distance{
    AxcAE_RingImageModel *model = [self drawModelWithImage:nil
                                                  distance:distance];
    if (imageView) model.imageView = imageView;
    return model;
}
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)drawModelWithImage:(UIImage *)image{
    return [self drawModelWithImage:image
                           distance:0];
}
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)drawModelWithImage:(UIImage *)image
                                    distance:(CGFloat )distance{
    return [self drawModelWithImage:image
                           distance:distance
                          tintColor:nil];
}
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)drawModelWithImage:(UIImage *)image
                                    distance:(CGFloat )distance
                                   tintColor:(UIColor *)tintColor{
    AxcAE_RingImageModel *model = [[AxcAE_RingImageModel alloc] init];
    if (image)              model.image = image;
    if (distance)   model.distance = distance;
    if (tintColor)          model.tintColor = tintColor;
    return model;
}



@end
