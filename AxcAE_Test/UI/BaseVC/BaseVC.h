//
//  BaseVC.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AxcAE_UI.h"
#import "ShowCell.h"

@interface BaseVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)NSMutableArray *dataArray;

@property(nonatomic , strong)UITableView *tableView;

@property(nonatomic , strong)UIButton *startAnimationBtn;

- (void)createUI;
- (void)settingData;
- (void)click_startAnimationBtn;


- (void)createStartAnimationBtn;
- (void)pushVcWithName:(NSString *)vcName;

@end
