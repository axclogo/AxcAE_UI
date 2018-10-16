//
//  AxcAE_ScopeDrawVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/16.
//  Copyright © 2018 AxcLogo. All rights reserved.
//
#import "AxcAE_ScopeDrawVC.h"
#import "ScopeCell.h"

@interface AxcAE_ScopeDrawVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic , strong)UICollectionView *collectionView;

@end

@implementation AxcAE_ScopeDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createStartAnimationBtn];
}
- (void)click_startAnimationBtn{
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ScopeCell *cell = obj;
        [cell.scopeDrawView draw];
        [cell.scopeDrawView startContinuousAnimation];
    }];
}
- (void)createUI{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScopeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"axc" forIndexPath:indexPath];
    cell.scopeDrawView.style = indexPath.row;
    return cell;
}
#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(200, 200);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ScopeCell" bundle:nil] forCellWithReuseIdentifier:@"axc"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
@end
