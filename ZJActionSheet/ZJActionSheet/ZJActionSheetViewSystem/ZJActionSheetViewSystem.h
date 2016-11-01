//
//  ZJActionSheetViewSystem.h
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/23.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJActionSheetButton.h"
@interface ZJActionSheetViewSystem : UIView
/** 取消按钮的高度 默认44 */
@property (assign, nonatomic) CGFloat cancelBtnHeight;
/** 取消按钮上下的间隙 默认为8 */
@property (assign, nonatomic) CGFloat cancelBtnTopAndBottomMargin;
/** 分割线高度 默认2 */
@property (assign, nonatomic) CGFloat seperatorHeight;
/** 左右的间隙 默认20 */
@property (assign, nonatomic) CGFloat leftAndRightMargin;
/** 圆角半径 默认10 */
@property (assign, nonatomic) CGFloat cornerRadius;
/** 取消按钮, 可自定义属性 */
@property (strong, nonatomic, readonly) ZJActionSheetButton *cancelBtn;

/** 提示文字label, 可自定义属性 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;
/** 详细文字label, 可自定义属性 */
@property (strong, nonatomic, readonly) UILabel *subtitleLabel;

/**
 *  初始化方法
 *
 *  @param title              title
 *  @param subtitle           subtitle
 *  @param actionSheetButtons actionSheetButtons
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle actionSheetButtons:(NSArray<ZJActionSheetButton *> *)actionSheetButtons;

/**
 *  初始化方法 无标题提示
 *
 *  @param actionSheetButtons actionSheetButtons description
 *
 *  @return return value description
 */
- (instancetype)initWithActionSheetButtons:(NSArray<ZJActionSheetButton *> *)actionSheetButtons;

/**
 *  弹出ActionSheet
 */
- (void)show;
/**
 *  移除ActionSheet
 */
- (void)hide;
@end
