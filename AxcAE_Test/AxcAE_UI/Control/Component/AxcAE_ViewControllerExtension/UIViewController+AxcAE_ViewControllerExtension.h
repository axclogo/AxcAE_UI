//
//  UIViewController+AxcAE_ViewControllerExtension.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/20.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_HeaderDefine.h"

/** 使用类扩展方式完成类似多重继承的功能，在不影响主基类VC的继承链情况下，实现和使用协议即可 */
@interface UIViewController (AxcAE_ViewControllerExtension)

#pragma mark - 重力感应

/** 开启重力感应监听模式，默认设备转向时坐标自动调整 = YES */
- (void)AxcAE_BaseOpenAccelerometer;
/** 开启重力感应监听模式 */
- (void)AxcAE_BaseOpenAccelerometerWithTransformationCoordinateSystem:(BOOL)isTransformationCoordinateSystem;
/** 关闭重力感应 */
- (void)AxcAE_BaseStopAccelerometer;
/** 重力陀螺仪信息的监听回调函数，执行上方函数开启后方可回调 */
- (void)AxcAE_BaseStartDeviceGyroscope:(AxcAE_Gyroscope)gyroscope motion:(CMDeviceMotion *)motion;


// 全局重感管理对象
@property(nonatomic , strong)CMMotionManager *motionManager;

#pragma mark - 总线控制
/** 将AE组件添加到控制器总成里进行管理 */
//- (void)addSubAEControl:(AxcAE_BaseControl *)AEControl;
/** AE子组件 */
//@property(nonatomic , strong , readonly)NSArray <AxcAE_BaseControl *>*subAEControls;

@end
