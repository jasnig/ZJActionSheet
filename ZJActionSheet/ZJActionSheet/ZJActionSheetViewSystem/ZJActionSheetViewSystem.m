//
//  ZJActionSheetViewSystem.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/23.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJActionSheetViewSystem.h"
#import "ZJActionSheetButton.h"
#define SELF_Width self.bounds.size.width
#define SELF_Height self.bounds.size.height

static CGFloat kTopMargin = 10.f;
@interface ZJActionSheetViewSystem ()<UIGestureRecognizerDelegate> {
    NSString *_title;
    NSString *_subtitle;
    CGFloat _titleHeight;
    CGFloat _subtitleHeight;
    CGFloat _headViewHeight;
    CGFloat _contentViewHeight;

}
// 所有控件的容器
@property (strong, nonatomic) UIView *contentView;
// 显示标题
@property (strong, nonatomic) UILabel *titleLabel;
// 显示子标题
@property (strong, nonatomic) UILabel *subtitleLabel;
// 顶部显示提示文字的view
@property (strong, nonatomic) UIView *headView;
// 底部取消按钮
@property (strong, nonatomic) ZJActionSheetButton *cancelBtn;
// 选项
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
// 点击手势
@property (strong, nonatomic) NSArray<ZJActionSheetButton *> *actionSheetButtons;

@end

@implementation ZJActionSheetViewSystem

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle actionSheetButtons:(NSArray<ZJActionSheetButton *> *)actionSheetButtons {
    if (self = [super init]) {
        _title = title;
        _subtitle = subtitle;
        _actionSheetButtons = actionSheetButtons;
        [self commonInit];
    }
    return self;

}

- (instancetype)initWithActionSheetButtons:(NSArray<ZJActionSheetButton *> *)actionSheetButtons {
    return [self initWithTitle:nil subtitle:nil actionSheetButtons:actionSheetButtons];
}

- (void)commonInit {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self addGestureRecognizer:self.tapGesture];
    if (!_actionSheetButtons) return;
    _cancelBtnHeight = 44.f;
    _cancelBtnTopAndBottomMargin = 8.f;
    _leftAndRightMargin = 20.f;
    _cornerRadius = 10.f;
    _seperatorHeight = 2.f;
    [self setupHeadView];

    for (ZJActionSheetButton *btn in _actionSheetButtons) {
        // 给按钮添加点击响应方法, 在响应方法中调用他的block即可
        [btn addTarget:self action:@selector(actionSheetBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 添加按钮
        [self.contentView addSubview:btn];
    }
}

- (void)setupHeadView {
    CGFloat labelMaxWidth = [UIScreen mainScreen].bounds.size.width - 2*_leftAndRightMargin;
    
    if (_title) {
        
        // 设置了标题 才添加titleLabel
        self.titleLabel.text = _title;
        // 添加titleLabel
        [self.headView addSubview:self.titleLabel];
        // 计算标题的高度  最大宽度为屏幕的宽度减去左右的间隙
        _titleHeight = [_title boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.height;
        // headView的高度就应该加上标题的高度和间隙
        _headViewHeight += (kTopMargin + _titleHeight);
        
    }
    
    if (_subtitle) {
        self.subtitleLabel.text = _subtitle;
        [self.headView addSubview:self.subtitleLabel];
        _subtitleHeight = [_subtitle boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.subtitleLabel.font} context:nil].size.height;
        _headViewHeight += (kTopMargin + _subtitleHeight);
    }
    
    if (_headView) {
        // 只有在设置了标题或者子标题的时候才需要添加headView
        [self.contentView addSubview:_headView];
    }
    // headView的高度最小为44
    _headViewHeight = MAX(44.f, _headViewHeight);

    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.superview) { // window
        self.frame = self.superview.bounds;
        CGFloat contentViewWidth = SELF_Width - 2*_leftAndRightMargin;
        if (_headView) {
            self.headView.frame = CGRectMake(0, 0, contentViewWidth, _headViewHeight);
            [self setCornerRadiusForView:self.headView isForTop:YES];

            if (_titleLabel && _subtitleLabel) {
                // 无_subtitleLabel的时候,titleLabel 竖直方向居中
                // titleLabel 和 separatorView的距离为 kTopMargin/2
                self.titleLabel.frame = CGRectMake(0, kTopMargin, contentViewWidth, _titleHeight);
                self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+kTopMargin/2, contentViewWidth, _subtitleHeight);

            }
            else if (_titleLabel) {
                self.titleLabel.frame = self.headView.bounds;

            }
            else if (_subtitleLabel) {
                self.subtitleLabel.frame = self.headView.bounds;

            }
        }

        CGFloat btnY = _headViewHeight;
        
        for (int i=0; i<_actionSheetButtons.count; i++) {
            ZJActionSheetButton *btn = _actionSheetButtons[i];
            btnY += _seperatorHeight;
            btn.frame = CGRectMake(0, btnY, contentViewWidth, btn.btnHeight);
            btnY += btn.btnHeight;
            if (i == 0) {
                if (_headView == nil) { // 没有提示文字
                    if (_actionSheetButtons.count == 1) {
                        // 只有一个按钮 设置四个圆角
                        btn.layer.masksToBounds = YES;
                        btn.layer.cornerRadius = _cornerRadius;
                    }
                    else {
                        // 有多个按钮的时候, 设置第一个按钮上两个角为圆角
                        [self setCornerRadiusForView:btn isForTop:YES];
                    }
                }
                else {
                    if (_actionSheetButtons.count == 1) {
                        // _headView的时候, 并且只有一个按钮, 设置第一个按钮下面两个角为圆角
                        [self setCornerRadiusForView:btn isForTop:NO];
                    }
                }
            }
            else if (i == _actionSheetButtons.count - 1) {
                // 设置最后一个按钮的最后两个角为圆角
                [self setCornerRadiusForView:btn isForTop:NO];

            }

        }
        
        self.cancelBtn.frame = CGRectMake(0, btnY+_cancelBtnTopAndBottomMargin, contentViewWidth, _cancelBtnHeight);
        self.cancelBtn.layer.masksToBounds = YES;
        self.cancelBtn.layer.cornerRadius = _cornerRadius;
        
        self.contentView.frame = CGRectMake(_leftAndRightMargin, (self.bounds.size.height-_contentViewHeight), contentViewWidth, _contentViewHeight);
    }
}


- (void)switchToHideState {
    self.alpha = 0;
    self.contentView.frame = CGRectMake(_leftAndRightMargin, self.bounds.size.height, SELF_Width-2*_leftAndRightMargin, _contentViewHeight);
}

- (void)switchToShowState {
    self.alpha = 1.f;
    self.contentView.frame = CGRectMake(_leftAndRightMargin, (self.bounds.size.height-_contentViewHeight), SELF_Width-2*_leftAndRightMargin, _contentViewHeight);
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    [window addSubview:self];
    
    [self computeContentViewHeight];
    
    [self switchToHideState];
    [UIView animateWithDuration:0.25 animations:^{
        [self switchToShowState];
    } completion:nil];
}

- (void)computeContentViewHeight {
    
    _contentViewHeight = _headViewHeight;
    for (ZJActionSheetButton *btn in _actionSheetButtons) {
        _contentViewHeight += (btn.btnHeight+_seperatorHeight);
    }
    // 计算contentView的高度
    _contentViewHeight += (_cancelBtnHeight + 2*_cancelBtnTopAndBottomMargin);
}


- (void)tapHandler:(UITapGestureRecognizer *)tapGesture {
    [self hide];
}

- (void)cancelBtnOnClick:(ZJActionSheetButton *)btn {
    [self hide];
}

- (void)actionSheetBtnOnClick:(ZJActionSheetButton *)btn {
    if (btn.handler) {
        btn.handler(self, btn);
    }
    [self hide];
}


- (void)hide {
    
    [UIView animateWithDuration:0.25 animations:^{
        [self switchToHideState];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)dealloc {
//    NSLog(@"销毁----");
}

- (void)setCornerRadiusForView:(UIView *)targetView isForTop:(BOOL)isForTop {
    // 需要设置的圆角-- 上下左右组合
    UIRectCorner rectCorner = isForTop ? (UIRectCornerTopLeft|UIRectCornerTopRight) : (UIRectCornerBottomLeft|UIRectCornerBottomRight);
    // UIBezierPath
    UIBezierPath *headViewPath = [UIBezierPath bezierPathWithRoundedRect:targetView.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = headViewPath.CGPath;
    // 使用maskView来完成
    targetView.layer.mask = maskLayer;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == _tapGesture) {
        CGFloat locationY = [gestureRecognizer locationInView:self].y;
        //        NSLog(@"%f ----", locationY);
        //         点击位置不在contentView上面
        return locationY < self.contentView.frame.origin.y || locationY > CGRectGetMaxY(self.contentView.frame);
    }
    return YES;
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        tapGesture.delegate = self;
        _tapGesture = tapGesture;
    }
    return _tapGesture;
}

- (ZJActionSheetButton *)cancelBtn {
    if (!_cancelBtn) {
        ZJActionSheetButton *cancelBtn = [[ZJActionSheetButton alloc] init];
        [cancelBtn addTarget:self action:@selector(cancelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
        _cancelBtn = cancelBtn;
    }
    return _cancelBtn;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor blackColor];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor blackColor];
        _subtitleLabel = titleLabel;
    }
    return _subtitleLabel;
}
- (UIView *)headView {
    if (!_headView) {
        UIView *headView = [UIView new];
        headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
        
        _headView = headView;
    }
    return _headView;
}

@end
