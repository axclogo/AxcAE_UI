//
//  UIImage+fixOrientation.m
//  TestCamera
//
//  Created by zzzili on 13-9-25.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "UIImage+fixOrientation.h"

@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [[UIImage alloc]initWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/** 纠正图片的方向 */

- (UIImage *)fixUIImageOrientation:(UIImage *)originalImage{
        if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
        CGAffineTransform transform = CGAffineTransformIdentity;
//        switch (originalImage.imageOrientation){
//
//                    case UIImageOrientationDown:
//
//                    case UIImageOrientationDownMirrored:
//
//                        transform = CGAffineTransformTranslate(transform, originalImage.size.width, originalImage.size.height);
//
//                        transform = CGAffineTransformRotate(transform, M_PI);
//
//                        break;
//
//                    case UIImageOrientationLeft:
//
//                    case UIImageOrientationLeftMirrored:
//
//                        transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
//
//                        transform = CGAffineTransformRotate(transform, M_PI_2);
//
//                        break;
//
//                    case UIImageOrientationRight:
//
//                    case UIImageOrientationRightMirrored:
//
                        transform = CGAffineTransformTranslate(transform, 0, originalImage.size.height);

                        transform = CGAffineTransformRotate(transform, -M_PI_2);
//
//                        break;
//
//                    case UIImageOrientationUp:
//
//                    case UIImageOrientationUpMirrored:
//
//                        break;
//
//            }
//
//        switch (originalImage.imageOrientation) {
//
//                    case UIImageOrientationUpMirrored:
//
//                    case UIImageOrientationDownMirrored:
//
//                        transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
//
//                        transform = CGAffineTransformScale(transform, -1, 1);
//
//                        break;
//
//                    case UIImageOrientationLeftMirrored:
//
//                    case UIImageOrientationRightMirrored:
//
//                        transform = CGAffineTransformTranslate(transform, originalImage.size.height, 0);
//
//                        transform = CGAffineTransformScale(transform, -1, 1);
//
//                        break;
//
//                    case UIImageOrientationUp:
//
//                    case UIImageOrientationDown:
//
//                    case UIImageOrientationLeft:
//
//                    case UIImageOrientationRight:
//
//                        break;
//
//            }
    
        // Now we draw the underlying CGImage into a new context, applying the transform
    
        // calculated above.
    
        CGContextRef ctx = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height,
                                                 
                                                                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                                 
                                                                                             CGImageGetColorSpace(self.CGImage),
                                                 
                                                                                             CGImageGetBitmapInfo(self.CGImage));
    
        CGContextConcatCTM(ctx, transform);
    
        switch (originalImage.imageOrientation)
    
        {
            
                    case UIImageOrientationLeft:
            
                    case UIImageOrientationLeftMirrored:
            
                    case UIImageOrientationRight:
            
                    case UIImageOrientationRightMirrored:
            
                        CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.height,originalImage.size.width), self.CGImage);
            
                        break;
            
            
            
                    default:
            
                        CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.width,originalImage.size.height), self.CGImage);
            
                        break;
            
            }
    
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    
        UIImage *img = [UIImage imageWithCGImage:cgimg];
    
        CGContextRelease(ctx);
    
        CGImageRelease(cgimg);
    
        return img;
    
}

@end
