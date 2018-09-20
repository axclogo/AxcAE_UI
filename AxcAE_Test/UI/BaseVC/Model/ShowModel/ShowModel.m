//
//  ShowModel.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ShowModel.h"

@implementation ShowModel

+ (ShowModel *)Title:(NSString *)title disTitle:(NSString *)disTitle VCName:(NSString *)VCName{
    ShowModel *model = [ShowModel new];
    model.title = title;
    model.disTitle = disTitle;
    model.VCName = VCName;
    return model;
}


@end
