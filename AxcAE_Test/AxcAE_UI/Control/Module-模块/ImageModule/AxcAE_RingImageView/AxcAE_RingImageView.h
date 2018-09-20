//
//  AxcAE_RingImageView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/15.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseImageModule.h"

/** 动画回调Block */
typedef void(^AxcAE_RingImageAnimationBlock )(UIImageView *imageView);

@interface AxcAE_RingImageModel : AxcAE_ImageBaseObj

/** 动画回调Block */
@property(nonatomic , copy)AxcAE_RingImageAnimationBlock animationBlock;


#pragma mark - 实例化方法
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)imageModelWithImageView:(UIImageView *)imageView;
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)imageModelWithImageView:(UIImageView *)imageView
                                         distance:(CGFloat )distance;

/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)imageModelWithImage:(UIImage *)image;
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)imageModelWithImage:(UIImage *)image
                                     distance:(CGFloat )distance;
/** 快速实例化类方法 */
+ (AxcAE_RingImageModel *)imageModelWithImage:(UIImage *)image
                                     distance:(CGFloat )distance
                                    tintColor:(UIColor *)tintColor;

@end



#pragma mark - 视图
@interface AxcAE_RingImageView : AxcAE_BaseImageModule
/** 快速实例化 */
- (instancetype)initWithImageModels:(NSArray<AxcAE_RingImageModel *>*)imageModels;
/** 要绘制的对象 */
@property(nonatomic , strong)NSArray<AxcAE_RingImageModel *>*imageModels;

@end

