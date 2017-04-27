//
//  ZYNormalCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYNormalCell.h"
#import "ZYMenuHeader.h"
static const CGFloat horizontalMargin = 10.0f;
@interface ZYNormalCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) CALayer *bottomLine;

@end

@implementation ZYNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(horizontalMargin, 0, 100, self.height);
    self.bottomLine.frame = CGRectMake(0, self.height - .5 , self.width, .5);
}

- (void)setItem:(ZYItem *)item {
    _item = item;
    self.title.text = item.title;
    self.title.textColor = item.isSelected?[UIColor colorWithHexString:titleSelectedColor]:[UIColor colorWithHexString:DropDownBoxNormalColor];

    self.backgroundColor = item.isSelected?[UIColor colorWithHexString:SelectedBGColor]:[UIColor colorWithHexString:UnselectedBGColor];
}

#pragma mark - get
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:MainTitleFontSize];
        [self addSubview:_title];
    }
    return _title;
}

- (CALayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CALayer layer];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.2].CGColor;
        [self.layer addSublayer:_bottomLine];
    }
    return _bottomLine;
}

@end
