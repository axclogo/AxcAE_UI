//
//  HexagonCell.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcAE_UI.h"

@interface HexagonCell : UICollectionViewCell
// 声明一个画板视图
@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;
// 声明一个画笔对象
@property(nonatomic , strong)CAShapeLayer *layerBrush;

@property(nonatomic , strong)UILabel *label;

@end
