//
//  ZJActionSheetButton.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/23.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJActionSheetButton.h"


@interface ZJActionSheetButton ()
@end

@implementation ZJActionSheetButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor handler:(ZJActionSheetSystemHandler)handler {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        self.titleColor = titleColor;
        _handler = [handler copy];
        _btnHeight = 44.f;
        if (image) {
            // 设置图片和文字的间距 20
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        }
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(ZJActionSheetSystemHandler)handler {
    return [self initWithTitle:title image:nil titleColor:titleColor handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title handler:(ZJActionSheetSystemHandler)handler {
    return [self initWithTitle:title image:nil titleColor:[UIColor blackColor] handler:handler];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
}
- (UILabel *)textLabel {
    return self.titleLabel;
}
@end
