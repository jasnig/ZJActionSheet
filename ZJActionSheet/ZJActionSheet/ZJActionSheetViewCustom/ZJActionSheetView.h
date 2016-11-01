//
//  ZJActionSheet.h
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJActionSheetTableViewCell.h"

typedef NS_ENUM(NSInteger, ZJActionSheetPosition) {
    ZJActionSheetPositionBottom = 0, // <<<<  default
    ZJActionSheetPositionCenter
};

@interface ZJActionSheetView : UIView
/** 提示文字label, 可自定义属性 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;
/** 详细文字label, 可自定义属性 */
@property (strong, nonatomic, readonly) UILabel *subtitleLabel;
/** 取消按钮, 可自定义属性 */
@property (strong, nonatomic, readonly) UIButton *cancelBtn;
/** 分割线的颜色 默认是 灰色 */
@property (strong, nonatomic) UIColor *separatorColor;
/** 分割线的边距 默认  UIEdgeInsetsZero */
@property (assign, nonatomic) UIEdgeInsets separatorEdgeInsest;
/** 分割线高度 默认1 */
@property (assign, nonatomic) CGFloat separatorHeight;
/** 取消按钮高度 默认44 */
@property (assign, nonatomic) CGFloat cancelBtnHeight;
/** 取消按钮顶部和上面的距离 默认5 */
@property (assign, nonatomic) CGFloat cancelBtnTopMargin;
/** ZJActionSheet最大的高度- 默认屏幕高度 */
@property (assign, nonatomic) CGFloat maxHeight;
/** 显示的位置 -- 默认居下 */
@property (assign, nonatomic) ZJActionSheetPosition actionSheetPositon;
/** 是否能滚动 默认YES */
@property (assign, nonatomic) BOOL scrollEnabled;
/** 是否有弹性 默认NO */
@property (assign, nonatomic) BOOL bounces;
/** 是否显示取消按钮 默认YES */
@property (assign, nonatomic) BOOL showCancelBtn;

/**
 *  初始化方法 同时显示标题和详细文字
 *
 *  @param title            标题文字
 *  @param subtitle         详细描述
 *  @param actionSheetItems actionSheetItems
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle actionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems;

/**
 *  初始化方法 显示标题
 *
 *  @param title            标题
 *  @param actionSheetItems actionSheetItems
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title actionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems;

/**
 *  初始化方法 不显示标题和详细文字
 *
 *  @param actionSheetItems actionSheetItems
 *
 *  @return return value description
 */
- (instancetype)initWithActionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems;

/**
 *  弹出ActionSheet
 */
- (void)show;
/**
 *  移除ActionSheet
 */
- (void)hide;

@end
