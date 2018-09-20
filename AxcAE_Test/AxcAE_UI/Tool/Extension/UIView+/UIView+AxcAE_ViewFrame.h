//
//  UIView+AxcAE_ViewFrame.h
//  Axc_AEUI
//
//  Created by Axc on 2018/6/7.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AxcAE_ViewFrame)

/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat axcAE_X;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat axcAE_Y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat axcAE_Width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat axcAE_Height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat axcAE_CenterX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat axcAE_CenterY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize axcAE_Size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint axcAE_Origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat axcAE_Top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat axcAE_Bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat axcAE_Left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat axcAE_Right;


@end
