//
//  ZJActionSheetTableViewCell.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJActionSheetTableViewCell.h"

#define SELF_Width self.bounds.size.width
#define SELF_Height self.bounds.size.height

@interface ZJActionSheetTableViewCell ()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *separatorView;

@end

@implementation ZJActionSheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftAndRightMargin = 20.f;
        _imageAndTitleMargin = 15.f;
        // 因为cell重用的问题, 这里我们全部添加这些控件
        // 然后根据是否设置数据, 来显示和隐藏相应的控件
        [self.contentView addSubview:self.containerView];
        [self.contentView addSubview:self.separatorView];
        [self.containerView addSubview:self.iconView];
        [self.containerView addSubview:self.titleLabel];

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_actionSheetItem) {

        CGFloat iconViewMaxX = 0;
        CGFloat containerViewHeight = SELF_Height - _separatorHeight;
        if (_actionSheetItem.image) {
            self.iconView.frame = CGRectMake(0, 0, _iconView.image.size.width, containerViewHeight);
            iconViewMaxX = CGRectGetMaxX(self.iconView.frame);
        }
        // 计算文字尺寸
        [self.titleLabel sizeToFit];
        self.titleLabel.frame = CGRectMake(iconViewMaxX+_imageAndTitleMargin, 0, self.titleLabel.bounds.size.width, containerViewHeight);
        CGFloat containerViewWidth = CGRectGetMaxX(self.titleLabel.frame);
        CGFloat containViewX = 0.f;
        switch (_actionSheetItem.contentAlignment) {
            case ZJActionSheetItemContentAlignmentLeft:
                containViewX = _leftAndRightMargin;
                break;
            case ZJActionSheetItemContentAlignmentCenter:
                containViewX = (SELF_Width - containerViewWidth)/2;
                break;
            case ZJActionSheetItemContentAlignmentRight:
                containViewX = SELF_Width - containerViewWidth - _leftAndRightMargin;
                break;
        }
        
        self.containerView.frame = CGRectMake(containViewX, 0, containerViewWidth, containerViewHeight);
        
        CGFloat separatorX = _separatorEdgeInsest.left;
        CGFloat separatorY = SELF_Height - _separatorEdgeInsest.bottom - _separatorHeight - _separatorEdgeInsest.top;
        CGFloat separatorW = SELF_Width-_separatorEdgeInsest.left-_separatorEdgeInsest.right;
        self.separatorView.frame = CGRectMake(separatorX, separatorY, separatorW, _separatorHeight);
        self.separatorView.backgroundColor = _separatorViewColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setActionSheetItem:(ZJActionSheetItem *)actionSheetItem {
    _actionSheetItem = actionSheetItem;
    // 一定要注意cell重用的时候可能造成图片和文字显示错误
    if (actionSheetItem) {
        self.backgroundColor = actionSheetItem.backgroundColor;


        if (actionSheetItem.title) {
            self.titleLabel.text = actionSheetItem.title;
            self.titleLabel.textColor = actionSheetItem.titleColor;
            self.titleLabel.hidden = NO;
        }
        else {
            self.titleLabel.hidden = YES;
        }
        
        if (actionSheetItem.image) {
            self.iconView.hidden = NO;
            self.iconView.image = actionSheetItem.image;
        }
        else {
            self.iconView.hidden = YES;
        }
        
        [self setNeedsLayout];
    }

}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [UIView new];
        _separatorView.backgroundColor = [UIColor blueColor];

    }
    return _separatorView;
}

-(UIView *)containerView {
    if (!_containerView) {
        UIView *containerView = [UIView new];
        containerView.backgroundColor = [UIColor clearColor];
        _containerView = containerView;
    }
    return _containerView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *iconView = [UIImageView new];
        iconView.contentMode = UIViewContentModeCenter;
        _iconView = iconView;
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16.f];
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

@end
