//
//  AxcBF_FaceRecognition.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/26.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcBF_FaceRecognition.h"

@implementation AxcBF_FaceRecognition

+ (void)AxcBeginScanningFaceWithImage:(UIImage *)image factor:(CGFloat )factor block:(AxcBF_FaceCoordinatesBlock )block{
    CIImage* ciimage = [CIImage imageWithCGImage:image.CGImage];//1 将UIImage转换成CIImage
    //缩小图片，默认照片的图片像素很高，需要将图片的大小缩小为我们现实的ImageView的大小，否则会出现识别五官过大的情况
    ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(factor, factor)];
    //2.设置人脸识别精度
    NSDictionary* opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    //3.创建人脸探测器
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:opts];
    //4.获取人脸识别数据
    NSArray* features = [detector featuresInImage:ciimage];
    if (features.count && block) {
        block(features);
    }
}


@end
