//
//  ViewSampleListVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ViewSampleListVC.h"

@interface ViewSampleListVC ()

@end

@implementation ViewSampleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)settingData{
    [self.dataArray addObject:[ShowModel Title:@"圆环" disTitle:@"View设置" VCName:@"AxcAE_RingImageVC"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowModel *model = self.dataArray[indexPath.row];
    [self pushVcWithName:model.VCName];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"axc"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)createUI{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:@"axc"];
}


@end
