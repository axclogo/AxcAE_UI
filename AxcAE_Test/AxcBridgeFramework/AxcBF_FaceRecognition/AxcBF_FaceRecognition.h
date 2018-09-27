//
//  AxcBF_FaceRecognition.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 回调五官坐标Block */
typedef void(^AxcBF_FaceCoordinatesBlock )(NSArray <CIFaceFeature *>* faceFeature);

@interface AxcBF_FaceRecognition : NSObject


/**
 开始脸部扫描
 @param image 传入扫描图片
 @param factor 缩小系数
 @param block 回调面部坐标系对象
 */
+ (void)AxcBeginScanningFaceWithImage:(UIImage *)image factor:(CGFloat )factor block:(AxcBF_FaceCoordinatesBlock )block;


@end
