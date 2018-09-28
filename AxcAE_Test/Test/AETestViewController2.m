//
//  AETestViewController2.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController2.h"
#import "HexagonCell.h"
#import "AxcLayout.h"

@interface AETestViewController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic , strong)UICollectionView *collectionView;

@end

@implementation AETestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 200;
}
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HexagonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"axc" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[AxcLayout new]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kVCBackColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"HexagonCell" bundle:nil] forCellWithReuseIdentifier:@"axc"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}



@end
