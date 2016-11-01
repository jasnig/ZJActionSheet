//
//  ZJActionSheetItem.h
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJActionSheetView;

typedef NS_ENUM(NSInteger, ZJActionSheetItemContentAlignment) {
    ZJActionSheetItemContentAlignmentCenter = 0,
    ZJActionSheetItemContentAlignmentLeft,
    ZJActionSheetItemContentAlignmentRight
};

typedef void(^ZJActionSheetHandler)(ZJActionSheetView *actionSheet);

@interface ZJActionSheetItem : NSObject

/** 内容位置-- 默认居中显示*/
@property (assign, nonatomic) ZJActionSheetItemContentAlignment contentAlignment;
/** 文字颜色 */
@property (strong, nonatomic) UIColor *titleColor;
/** 背景色 */
@property (strong, nonatomic) UIColor *backgroundColor;
/** 高度 默认 44 */
@property (assign, nonatomic) CGFloat itemHeight;

/** 文字 */
@property (strong, nonatomic) NSString *title;
/** 图片 */
@property (strong, nonatomic) UIImage *image;
/** 点击处理 */
@property (copy, nonatomic) ZJActionSheetHandler handler;
/**
 *  初始化方法 显示文字
 *
 *  @param title   title
 *  @param handler 点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title handler:(ZJActionSheetHandler)handler;
/**
 *  初始化方法 显示文字和图片
 *
 *  @param title   文字
 *  @param image   图片
 *  @param handler 点击处理
 *
 *  @return return value description
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image handler:(ZJActionSheetHandler)handler;
@end
