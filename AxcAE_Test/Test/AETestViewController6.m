//
//  AETestViewController6.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/15.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AETestViewController6.h"

#import "GredientLayerView.h"



@interface AETestViewController6 ()

@end

@implementation AETestViewController6

- (void)viewDidLoad {
    [super viewDidLoad];

//    GredientLayerView *gredientLayerView=[[GredientLayerView alloc]initWithFrame:CGRectMake(30, 100, 200, 200)];
//
//    [self.view addSubview:gredientLayerView];

    //创建CGContextRef
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGFloat point = 300;
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, point, 0);
    CGPathAddLineToPoint(path, NULL, point, point);
    CGPathAddLineToPoint(path, NULL, 0, point);
    CGPathCloseSubpath(path);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) [UIColor whiteColor].CGColor, (__bridge id) [UIColor blackColor].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(150, 150);
    CGFloat radius = 300 ;
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(10, 100, 300, 300);
    imgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imgView];
    CALayer *layer = imgView.layer;
    NSLog(@"%@",layer);

}


@end
