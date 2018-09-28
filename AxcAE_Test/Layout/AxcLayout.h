//
//  AxcLayout.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AxcLayout : UICollectionViewFlowLayout

// 半径
@property(nonatomic , assign)CGFloat radius;
// 间距
@property(nonatomic , assign)CGFloat spacing;
// 每行的个数
@property(nonatomic , assign)NSInteger rowMaxCount;
// 自适应每行
@property(nonatomic , assign)BOOL isAutoRowMaxCount;
@end
