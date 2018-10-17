//
//  UIImage+fixOrientation.h
//  TestCamera
//
//  Created by zzzili on 13-9-25.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;
- (UIImage *)fixUIImageOrientation:(UIImage *)originalImage;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end
