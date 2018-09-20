//
//  AxcAE_BaseObject.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AxcAE_BaseObject : NSObject
/** 渲染颜色，推荐png格式的图片使用这个参数 */
@property(nonatomic , strong)UIColor *tintColor;
/** 间距 默认 10*/
@property(nonatomic , assign)CGFloat distance;
/** 要绘制的图片 */
@property(nonatomic , strong)UIImage *image;

- (void)AxcAE_BaseConfiguration;


@end
