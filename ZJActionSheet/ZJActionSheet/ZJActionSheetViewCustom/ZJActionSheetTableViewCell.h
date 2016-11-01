//
//  ZJActionSheetTableViewCell.h
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJActionSheetItem.h"
@interface ZJActionSheetTableViewCell : UITableViewCell
@property (strong, nonatomic) ZJActionSheetItem *actionSheetItem;
@property (assign, nonatomic) CGFloat imageAndTitleMargin;
@property (assign, nonatomic) CGFloat leftAndRightMargin;
@property (strong, nonatomic) UIColor *separatorViewColor;
@property (assign, nonatomic) UIEdgeInsets separatorEdgeInsest;
@property (assign, nonatomic) CGFloat separatorHeight;
@end
