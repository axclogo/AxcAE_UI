//
//  ShowModel.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BaseModel.h"

@interface ShowModel : BaseModel

+ (ShowModel *)Title:(NSString *)title disTitle:(NSString *)disTitle VCName:(NSString *)VCName;

@property(nonatomic , copy)NSString *title;
@property(nonatomic , copy)NSString *disTitle;
@property(nonatomic , copy)NSString *VCName;


@property(nonatomic , copy)NSString *selectorName;

@end
