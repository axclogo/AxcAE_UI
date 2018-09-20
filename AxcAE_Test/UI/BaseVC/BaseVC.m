//
//  BaseVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = kBackColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self createUI];
    [self settingData];
}

- (void)createUI{}
- (void)settingData{}
- (void)click_startAnimationBtn{}

- (void)createStartAnimationBtn{
    [self.startAnimationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(-90);
    }];
}
- (void)pushVcWithName:(NSString *)vcName{
    Class class = NSClassFromString(vcName);
    BaseVC *vc = [class new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}

#pragma mark - 重写
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;   //状态栏字体白色 UIStatusBarStyleDefault黑色
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (UIButton *)startAnimationBtn{
    if (!_startAnimationBtn) {
        _startAnimationBtn = [UIButton new];
        _startAnimationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startAnimationBtn setTitleColor:KScienceTechnologyBlue forState:UIControlStateNormal];
        [_startAnimationBtn setBackgroundImage:[UIImage imageNamed:@"btnBackground_img"] forState:UIControlStateNormal];
        [_startAnimationBtn setTitle:@"开始动画效果" forState:UIControlStateNormal];
        [_startAnimationBtn addTarget:self action:@selector(click_startAnimationBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startAnimationBtn];
    }
    return _startAnimationBtn;
}


#pragma mark - 检查内存销毁情况
- (void)dealloc{
    NSLog(@"已销毁视图控制器对象：%@",self);
}

@end
