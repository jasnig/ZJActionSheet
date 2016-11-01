//
//  ZJActionSheet.m
//  ZJActionSheet
//
//  Created by ZeroJ on 16/10/21.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJActionSheetView.h"

static CGFloat kLeftAndRightMargin = 20.f;
static CGFloat kTopMargin = 10.f;
#define kWhiteColor [[UIColor whiteColor] colorWithAlphaComponent:0.95]
#define SELF_Width self.bounds.size.width
#define SELF_Height self.bounds.size.height

@interface ZJActionSheetView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate> {
    NSString *_title;
    NSString *_subtitle;
    CGFloat _titleHeight;
    CGFloat _subtitleHeight;
    CGFloat _headViewHeight;

}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIView *separatorView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIButton *cancelBtn;

@property (assign, nonatomic) NSInteger contentViewHeight;

@property (strong, nonatomic) NSArray<ZJActionSheetItem *> *actionSheetItems;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation ZJActionSheetView

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle actionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems {
    if (self = [super init]) {
        _title = title;
        _subtitle = subtitle;
        _actionSheetItems = actionSheetItems;
        [self commonInit];
        
    }
    return self;
}

- (instancetype)initWithActionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems {
    return [self initWithTitle:nil subtitle:nil actionSheetItems:actionSheetItems];
}

- (instancetype)initWithTitle:(NSString *)title actionSheetItems:(NSArray<ZJActionSheetItem *> *)actionSheetItems {
    return [self initWithTitle:title subtitle:nil actionSheetItems:actionSheetItems];
}

- (void)commonInit {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self addGestureRecognizer:self.tapGesture];
    
    _separatorColor = [UIColor lightGrayColor];
    _separatorHeight = 1.f;
    _separatorEdgeInsest = UIEdgeInsetsZero;
    _maxHeight = [UIScreen mainScreen].bounds.size.height;
    _cancelBtnHeight = 44.f;
    _cancelBtnTopMargin = 5;
    _showCancelBtn = YES;
    _scrollEnabled = YES;
    _bounces = NO;
    [self setupHeadView];
    
    for (ZJActionSheetItem *item in _actionSheetItems) {
        _contentViewHeight += item.itemHeight;
    }
    
}

- (void)setupHeadView {
    CGFloat labelMaxWidth = [UIScreen mainScreen].bounds.size.width - 2*kLeftAndRightMargin;
    
    if (_title) {
        self.titleLabel.text = _title;
        [self.headView addSubview:self.titleLabel];
        _titleHeight = [_title boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.height;
        _headViewHeight = (kTopMargin + _titleHeight);
        
    }
    
    if (_subtitle) {
        self.subtitleLabel.text = _subtitle;
        [self.headView addSubview:self.subtitleLabel];
        _subtitleHeight = [_subtitle boundingRectWithSize:CGSizeMake(labelMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.subtitleLabel.font} context:nil].size.height;
        _headViewHeight += (kTopMargin + _subtitleHeight + _separatorHeight);
    }
    
    if (_headView) {
        CGRect headViewFrame = _headView.frame;
        headViewFrame.size.height = _headViewHeight;
        _headView.frame = headViewFrame;
        
        [_headView addSubview:self.separatorView];
        self.tableView.tableHeaderView = _headView;
    }
    
    _contentViewHeight += _headViewHeight;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) { // window
        self.frame = self.superview.bounds;

        if (_headView) {
            CGFloat labelMaxWidth = SELF_Width - 2*kLeftAndRightMargin;
            
            if (_titleLabel && _subtitleLabel) {
                // 无_subtitleLabel的时候,titleLabel 竖直方向居中
                // titleLabel 和 separatorView的距离为 kTopMargin/2
                self.titleLabel.frame = CGRectMake(0, kTopMargin, labelMaxWidth, _titleHeight);
                self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+kTopMargin/2, labelMaxWidth, _subtitleHeight);
                
            }
            else if (_titleLabel) {
                self.titleLabel.frame = self.headView.bounds;
                
            }
            else if (_subtitleLabel) {
                self.subtitleLabel.frame = self.headView.bounds;
                
            }
            
            self.separatorView.frame = CGRectMake(0, _headViewHeight-1, SELF_Width, 1);
            self.headView.frame = CGRectMake(0, 0, SELF_Width, _headViewHeight);
        }
        
        if (_showCancelBtn) {
            self.cancelBtn.frame = CGRectMake(0, _contentViewHeight - _cancelBtnHeight, SELF_Width, _cancelBtnHeight);
            self.tableView.frame = CGRectMake(0, 0, SELF_Width, _contentViewHeight - _cancelBtnHeight - _cancelBtnTopMargin);
        }
        else {
            self.tableView.frame = self.contentView.bounds;
        }
        
        
        [self switchToShowState];
    }
}

- (void)dealloc {
//    NSLog(@"ZJActionSheet ---- 销毁");
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    [window addSubview:self];
    if (_showCancelBtn) {
        [self.contentView addSubview:self.cancelBtn];
        _contentViewHeight += (_cancelBtnHeight + _cancelBtnTopMargin);

    }

    _contentViewHeight = MIN(_maxHeight, _contentViewHeight);
    // 为动画做隐藏准备
    [self switchToHideState];

    [UIView animateWithDuration:0.25 animations:^{
        [self switchToShowState];
    } completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionSheetItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellID = @"kCellID";
    ZJActionSheetItem *item = self.actionSheetItems[indexPath.row];
    ZJActionSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
        cell = [[ZJActionSheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.separatorViewColor = _separatorColor;
        cell.separatorEdgeInsest = _separatorEdgeInsest;
        cell.separatorHeight = _separatorHeight;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.actionSheetItem = item;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZJActionSheetItem *item = self.actionSheetItems[indexPath.row];
    if (item.handler) {
        item.handler(self);
        [self hide];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.actionSheetItems[indexPath.row].itemHeight;
}



- (void)tapHandler:(UITapGestureRecognizer *)tapGesture {
    [self hide];
}

- (void)hide {
    
    [UIView animateWithDuration:0.25 animations:^{
        [self switchToHideState];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

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

- (void)switchToHideState {
    self.alpha = 0;
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, _contentViewHeight);
}

- (void)switchToShowState {
    
    self.alpha = 1;
    switch (_actionSheetPositon) {
        case ZJActionSheetPositionBottom:
            self.contentView.frame = CGRectMake(0, self.bounds.size.height-_contentViewHeight, self.bounds.size.width, _contentViewHeight);
            break;
            
        case ZJActionSheetPositionCenter:
            self.contentView.frame = CGRectMake(0, (self.bounds.size.height-_contentViewHeight)/2, self.bounds.size.width, _contentViewHeight);
            
            break;
    }

}


- (void)cancelBtnOnClick:(UIButton *)btn {
    [self hide];
}


- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    if (_separatorView) {
        _separatorView.backgroundColor = _separatorColor;
    }
}
- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    self.tableView.scrollEnabled = scrollEnabled;
}
- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    self.tableView.bounces = bounces;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        tapGesture.delegate = self;
        _tapGesture = tapGesture;
    }
    return _tapGesture;
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

- (UIView *)separatorView {
    if (!_separatorView) {
        UIView *separatorView = [UIView new];
        separatorView.backgroundColor = _separatorColor;
        _separatorView = separatorView;
    }
    return _separatorView;
}

- (UIView *)headView {
    if (!_headView) {
        UIView *headView = [UIView new];
        headView.backgroundColor = kWhiteColor;
        _headView = headView;
    }
    return _headView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn addTarget:self action:@selector(cancelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor = kWhiteColor;
        _cancelBtn = cancelBtn;
    }
    return _cancelBtn;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.scrollsToTop = NO;
        tableView.scrollEnabled = _scrollEnabled;
        tableView.bounces = _bounces;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    
    return _tableView;
}
@end
