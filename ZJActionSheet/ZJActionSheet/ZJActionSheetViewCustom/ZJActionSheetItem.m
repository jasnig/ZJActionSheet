//
//  ZJActionSheetItem.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJActionSheetItem.h"

@interface ZJActionSheetItem ()

@end

@implementation ZJActionSheetItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image handler:(ZJActionSheetHandler)handler {
    if (self = [super init]) {
        _title = title;
        _image = image;
        _handler = [handler copy];
        _titleColor = [UIColor blackColor];
        _backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        _contentAlignment = ZJActionSheetItemContentAlignmentCenter;
        _itemHeight = 44.f;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title handler:(ZJActionSheetHandler)handler {
    return [self initWithTitle:title image:nil handler:handler];
}
@end
