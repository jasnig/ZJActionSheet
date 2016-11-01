//
//  ZJActionSheetButton.h
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/23.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJActionSheetViewSystem;
@class ZJActionSheetButton;
typedef void(^ZJActionSheetSystemHandler)(ZJActionSheetViewSystem *actionSheet, ZJActionSheetButton *actionSheetButton);
@interface ZJActionSheetButton : UIButton

/** 按钮的titleLabel 可自定义属性 */
@property (strong, nonatomic, readonly) UILabel *textLabel;
/** 点击响应 */
@property (copy, nonatomic) ZJActionSheetSystemHandler handler;
/** 按钮的高度 默认44 */
@property (assign, nonatomic) CGFloat btnHeight;
/** 文字的颜色 默认黑色 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 *  初始化方法
 *
 *  @param title      title
 *  @param image      image
 *  @param titleColor titleColor
 *  @param handler    点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor handler:(ZJActionSheetSystemHandler)handler;

/**
 *  初始化方法
 *
 *  @param title      title
 *  @param titleColor titleColor
 *  @param handler    点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(ZJActionSheetSystemHandler)handler;
/**
 *  初始化方法, 字体颜色默认为 黑色
 *
 *  @param title   title description
 *  @param handler 点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title handler:(ZJActionSheetSystemHandler)handler;

@end
