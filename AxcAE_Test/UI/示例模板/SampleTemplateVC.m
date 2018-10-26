//
//  SampleTemplateVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "SampleTemplateVC.h"

#import "AETestViewController.h"
#import "AETestViewController2.h"
#import "AETestViewController3.h"
#import "AETestViewController4.h"
#import "AETestViewController5.h"
#import "AETestViewController6.h"
#import "AETestViewController7.h"

@interface SampleTemplateVC ()

@end

@implementation SampleTemplateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[AETestViewController new] animated:YES];
}

@end
