//
//  UIViewController+AxcAE_ViewControllerExtension.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/20.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIViewController+AxcAE_ViewControllerExtension.h"
#import <objc/runtime.h>

static NSString * const kmotionManager = @"motionManager";

@implementation UIViewController (AxcAE_ViewControllerExtension)

#pragma mark - 重感
/* 开启重力感应监听模式 */
- (void)AxcAE_BaseOpenAccelerometer{
    [self AxcAE_BaseOpenAccelerometerWithTransformationCoordinateSystem:YES];
}
- (void)AxcAE_BaseOpenAccelerometerWithTransformationCoordinateSystem:(BOOL)isTransformationCoordinateSystem{
    if ([self.motionManager isDeviceMotionAvailable]) { //判断传感器是否可用
        __weak typeof(self)weakSelf = self;///启动设备运动更新队列
        UIApplication *app = [UIApplication sharedApplication];
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            AxcAE_Gyroscope gyroscope = AxcAE_GyroscopeMotionMake(motion); // 默认正常
            // 判断设备方向状态，做响应的操作
            if (isTransformationCoordinateSystem) { // 开启自动转换坐标计算
                switch (app.statusBarOrientation) {
                    case UIInterfaceOrientationPortraitUpsideDown:{ // 反向持机
                        gyroscope = AxcAE_GyroscopeMake(-motion.gravity.x, -motion.gravity.y, motion.gravity.z);
                    }break;
                    case UIInterfaceOrientationLandscapeRight:{ // 右向持机
                        gyroscope = AxcAE_GyroscopeMake(-motion.gravity.y, motion.gravity.x, motion.gravity.z);
                    }break;
                    case UIInterfaceOrientationLandscapeLeft:{ // 左向持机
                        gyroscope = AxcAE_GyroscopeMake(motion.gravity.y, -motion.gravity.x, motion.gravity.z);
                    }break;
                    default: break;
                }
            }
            [weakSelf AxcAE_BaseStartDeviceGyroscope:gyroscope motion:motion];
        }];
    }else{
        NSLog(@"开启重力感应模式失败！请检查传感器设置");
    }
}
/** 关闭重力感应 */
- (void)AxcAE_BaseStopAccelerometer{
    [self.motionManager stopDeviceMotionUpdates];
}
/** 重力陀螺仪信息的监听函数 */
- (void)AxcAE_BaseStartDeviceGyroscope:(AxcAE_Gyroscope)gyroscope motion:(CMDeviceMotion *)motion{}

#pragma mark - 懒加载 & SET & GET
- (void)setMotionManager:(CMMotionManager *)motionManager{
    [self willChangeValueForKey:kmotionManager];
    objc_setAssociatedObject(self, &kmotionManager,
                             motionManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kmotionManager];
}
- (CMMotionManager *)motionManager{
    CMMotionManager * motionManager = objc_getAssociatedObject(self, &kmotionManager);
    if (!motionManager) {
        motionManager = [[CMMotionManager alloc] init];
        self.motionManager = motionManager; // 触发SET保存对象
    }
    return motionManager;
}

#pragma mark - 销毁处理
- (void)dealloc{
    [self AxcAE_BaseStopAccelerometer];
    self.motionManager = nil;
}

@end
