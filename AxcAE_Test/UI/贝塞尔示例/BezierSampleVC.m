//
//  BezierSampleVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "BezierSampleVC.h"

@interface BezierSampleVC ()

@end

@implementation BezierSampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)settingData{
    [self.dataArray addObject:[ShowModel Title:@"线段绘制" disTitle:@"贝塞尔曲线折线/线段绘制" VCName:@"DrawLineVC"]];
    [self.dataArray addObject:[ShowModel Title:@"四边形绘制" disTitle:@"贝塞尔四边形绘制" VCName:@"DrawQuadrilateralVC"]];
    [self.dataArray addObject:[ShowModel Title:@"块状圆弧绘制" disTitle:@"贝塞尔块状圆弧绘制" VCName:@"DrawBlockRingVC"]];
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
