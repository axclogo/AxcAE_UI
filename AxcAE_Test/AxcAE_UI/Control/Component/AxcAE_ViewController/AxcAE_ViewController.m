//
//  AxcAE_ViewController.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ViewController.h"

@interface AxcAE_ViewController ()
@property(nonatomic , strong)NSMutableArray <AxcAE_BaseControl *>*AEControls;
@end

@implementation AxcAE_ViewController
#pragma mark - init&ParentClass
- (instancetype)init{
    self = [super init];
    if (self) {
        [self AxcAE_BaseConfiguration];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self AxcAE_BaseConfiguration];
    }
    return self;
}
- (void)AxcAE_BaseConfiguration{
    // 坐标转换默认开启
    self.isTransformationCoordinateSystem = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)addSubAEControl:(AxcAE_BaseControl *)AEControl{
    [self.AEControls addObject:AEControl];
}



#pragma mark - 重感
/* 开启重力感应监听模式 */
- (void)AxcAE_BaseOpenAccelerometer{
    if ([self.motionManager isDeviceMotionAvailable]) { //判断传感器是否可用
        __weak typeof(self)weakSelf = self;;///启动设备运动更新队列
        UIApplication *app = [UIApplication sharedApplication];
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            AxcAE_Gyroscope gyroscope = AxcAE_GyroscopeMotionMake(motion); // 默认正常
            // 判断设备方向状态，做响应的操作
            if (self.isTransformationCoordinateSystem) { // 开启自动转换坐标计算
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
/* 重力陀螺仪信息的监听函数 */
- (void)AxcAE_BaseStartDeviceGyroscope:(AxcAE_Gyroscope)gyroscope motion:(CMDeviceMotion *)motion{}


#pragma mark - 懒加载
- (NSMutableArray <AxcAE_BaseControl *>*)AEControls{
    if (!_AEControls) {
        _AEControls = @[].mutableCopy;
    }
    return _AEControls;
}
- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}


@end

