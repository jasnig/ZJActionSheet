//
//  ViewController.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJActionSheetView.h"
#import "ZJActionSheetViewSystem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 220, 60)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"类似系统ActionSheet效果" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 220, 60)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"自定义ActionSheet效果" forState:UIControlStateNormal];

    [btn1 addTarget:self action:@selector(showCustomActionSheetView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)btnOnClick {
    ZJActionSheetButton *btn = [[ZJActionSheetButton alloc] initWithTitle:@"豆瓣分享" image:[UIImage imageNamed:@"cm2_blogo_douban"] titleColor:[UIColor blackColor] handler:^(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton) {
        NSLog(@"点击了豆瓣---- ");
    }];
    // 文字的大小
//    btn.textLabel.font = [UIFont systemFontOfSize:12];
    // 文字颜色
//    btn.titleColor = [UIColor redColor];
    // 按钮高度
    btn.btnHeight = 70;
    ZJActionSheetButton *btn1 = [[ZJActionSheetButton alloc] initWithTitle:@"QQ好友" image:[UIImage imageNamed:@"cm2_blogo_qq"] titleColor:[UIColor blackColor] handler:^(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton) {
        NSLog(@"点击了QQ好友---- ");
    }];
    btn1.btnHeight = 70;

    ZJActionSheetButton *btn2 = [[ZJActionSheetButton alloc] initWithTitle:@"QQ空间" image:[UIImage imageNamed:@"cm2_blogo_qzone"] titleColor:[UIColor blackColor] handler:^(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton) {
        NSLog(@"点击了QQ空间---- ");
    }];
    btn2.btnHeight = 70;

    ZJActionSheetButton *btn3 = [[ZJActionSheetButton alloc] initWithTitle:@"微信好友" image:[UIImage imageNamed:@"cm2_blogo_weixin"] titleColor:[UIColor blackColor] handler:^(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton) {
        NSLog(@"点击了微信好友---- ");
    }];
    btn3.btnHeight = 70;

    ZJActionSheetButton *btn4 = [[ZJActionSheetButton alloc] initWithTitle:@"可以设置conerRadius和leftAndRighMargin为0" image:nil titleColor:[UIColor blackColor] handler:^(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton) {
        NSLog(@"点击了测试5---- ");
    }];
    
    ZJActionSheetViewSystem *actionSheet = [[ZJActionSheetViewSystem alloc] initWithTitle:@"这是提示文字" subtitle:@"这可以是详细描述的一段文字一段文字一段文字一段文字" actionSheetButtons:@[btn, btn1, btn3, btn4]];
    // 可以设置conerRadius和leftAndRighMargin为0 就可以实现微信的actionSheet的效果了
//    actionSheet.cornerRadius = 0.f;
//    actionSheet.leftAndRightMargin = 0.f;
    // 分割线的高度
    actionSheet.seperatorHeight = 3;
    // 左右间隙
    actionSheet.leftAndRightMargin = 15;
    // 取消按钮高度
//    actionSheet.cancelBtnHeight = 64;
    // 取消按钮的上下间距
//    actionSheet.cancelBtnTopAndBottomMargin = 15;
    [actionSheet show];
}

- (void)showCustomActionSheetView {
    
    ZJActionSheetItem *item1 = [[ZJActionSheetItem alloc] initWithTitle:@"分享" image:[UIImage imageNamed:@"cm2_blogo_douban"] handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了分享");
    }];
    item1.contentAlignment = ZJActionSheetItemContentAlignmentLeft;
    item1.itemHeight = 60;
    item1.backgroundColor = [UIColor yellowColor];
    item1.titleColor = [UIColor greenColor];

    ZJActionSheetItem *item2 = [[ZJActionSheetItem alloc] initWithTitle:@"点赞" image:[UIImage imageNamed:@"cm2_blogo_qq"] handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了点赞");
    }];
    item2.contentAlignment = ZJActionSheetItemContentAlignmentCenter;
    item2.itemHeight = 60;

    ZJActionSheetItem *item3 = [[ZJActionSheetItem alloc] initWithTitle:@"右边显示" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了右边显示");
    }];
    item3.contentAlignment = ZJActionSheetItemContentAlignmentRight;

    ZJActionSheetItem *item4 = [[ZJActionSheetItem alloc] initWithTitle:@"可以设置为支持滚动" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item5 = [[ZJActionSheetItem alloc] initWithTitle:@"可以自定义每个item的高度" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item6 = [[ZJActionSheetItem alloc] initWithTitle:@"可以自定义item的内容的位置 左中右" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item7 = [[ZJActionSheetItem alloc] initWithTitle:@"可以自定义分割线" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item8 = [[ZJActionSheetItem alloc] initWithTitle:@"可以自定义所有item的字体颜色 大小等" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];
    ZJActionSheetItem *item9 = [[ZJActionSheetItem alloc] initWithTitle:@"可以设置actionSheet居中或者居下显示" image:nil handler:^(ZJActionSheetView *actionSheet) {
        NSLog(@"点击了收藏");
    }];

    ZJActionSheetView *actionSheet = [[ZJActionSheetView alloc] initWithTitle:@"这是提示title" subtitle:@"这是详细说明文字,字体默认14,可修改subtitleLabel" actionSheetItems:@[item1, item2, item3,item4,item5,item6,item7,item8,item9]];
    
    // 最大的高度 默认为屏幕高度的 2/3
//    actionSheet.maxHeight = 300;
    // 是否可以滚动 默认为NO
    actionSheet.scrollEnabled = YES;
    // 是否滚动的时候有弹性效果 默认为NO
    actionSheet.bounces = YES;
    // actionSheet的位置, 居中或者居下显示
//    actionSheet.actionSheetPositon = ZJActionSheetPositionCenter;
    // 分割线的颜色
//    actionSheet.separatorColor = [UIColor purpleColor];
    // 分割线的高度
//    actionSheet.separatorHeight = 1;
    // 分割线的上下左右间隙
//    actionSheet.separatorEdgeInsest = UIEdgeInsetsMake(0, 10, 0, 10);
    // 标题属性自定义
//    actionSheet.titleLabel.font = [UIFont systemFontOfSize:18.f];
    actionSheet.titleLabel.textColor = [UIColor redColor];
    // 设置子标题的属性
//    actionSheet.subtitleLabel.textColor = [UIColor purpleColor];
    // 自定义取消按钮的属性
//    actionSheet.cancelBtn
    // 显示
    [actionSheet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
