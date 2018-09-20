//
//  AxcAE_ViewController.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcAE_BaseControl.h"
#import "AxcAE_HeaderDefine.h"

@interface AxcAE_ViewController : UIViewController

#pragma mark - 重力感应
/** 开启重力感应监听模式 */
- (void)AxcAE_BaseOpenAccelerometer;

/** 重力陀螺仪信息的监听函数 */
- (void)AxcAE_BaseStartDeviceGyroscope:(AxcAE_Gyroscope)gyroscope motion:(CMDeviceMotion *)motion;

/** 是否开启根据设备朝向自动计算转换坐标系 默认YES */
@property(nonatomic , assign)BOOL isTransformationCoordinateSystem;

// 初始化全局管理对象
@property(nonatomic , strong)CMMotionManager *motionManager;

#pragma mark - 总线控制
/** 将AE组件添加到控制器总成里进行管理 */
- (void)addSubAEControl:(AxcAE_BaseControl *)AEControl;

/** AE子组件 */
@property(nonatomic , strong , readonly)NSArray <AxcAE_BaseControl *>*subAEControls;

/** 控制器中已添加的组件进行动画 */
//- (void)startAE_Animation;

@end
