//
//  AxcTabBarController.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcTabBarController.h"


@interface AxcTabBarController ()<AxcAE_TabBarDelegate>

@end

@implementation AxcTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewControllers];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}

- (void)addChildViewControllers{

    NSArray <NSDictionary *>*tabBarItems =
    @[@{@"VCName":@"SampleTemplateVC",@"itemTitle":@"示例模板",@"VCTitle":@"示例列表",@"nomalImageName":@"sampleList_item"},
      @{@"VCName":@"BezierSampleVC",@"itemTitle":@"贝塞尔示例",@"VCTitle":@"",@"nomalImageName":@"home_activity",@"selectImageName":@"home_activity_select"},
      @{@"VCName":@"DrawSampleListVC",@"itemTitle":@"绘制组件示例",@"VCTitle":@"Layer组件示例",@"nomalImageName":@"layerSample_item"},
      @{@"VCName":@"ViewSampleListVC",@"itemTitle":@"视图组件示例",@"VCTitle":@"View组件示例",@"nomalImageName":@"viewSample_item"},
      @{@"VCName":@"ContainerSampleVC",@"itemTitle":@"容器组件示例",@"VCTitle":@"",@"nomalImageName":@"complaint",@"selectImageName":@"complaint_select"}];
    NSMutableArray *VCs = @[].mutableCopy;
    NSMutableArray *configs = @[].mutableCopy;
    [tabBarItems enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        // 未点击状态
        model.normalImageName = [obj objectForKey:@"nomalImageName"];
        model.normalColor = [UIColor lightGrayColor];
        model.normalTintColor = [UIColor lightGrayColor];
        model.normalBackgroundColor = [UIColor clearColor];
        // 点击状态
        model.selectImageName = [obj objectForKey:@"nomalImageName"];
        model.selectColor = KScienceTechnologyBlue;
        model.selectTintColor = KScienceTechnologyBlue; // 直接渲染颜色即可
        model.selectBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        // 设置所有点击动画
        model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
        // 实例化
        NSString *VCName = [obj objectForKey:@"VCName"];
        Class VC_Class = NSClassFromString(VCName);
        UIViewController *viewController = [[VC_Class alloc]init];
        viewController.title = [obj objectForKey:@"VCTitle"];
        [VCs addObject:[[UINavigationController alloc] initWithRootViewController:viewController]];
        [configs addObject:model];
    }];
    self.viewControllers = VCs;
    
    // 将自定义的覆盖到原来的tabBar上面
    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:configs];
    /// 设置委托
    self.axcTabBar.delegate = self;
    //    self.axcTabBar.backgroundImageView.image = [UIImage imageNamed:@"tabBarBackGround"];
    self.axcTabBar.backgroundColor = kBackColor;
    //    self.axcTabBar.translucent = YES;
    [self.tabBar addSubview:self.axcTabBar];
}

- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}


@end
