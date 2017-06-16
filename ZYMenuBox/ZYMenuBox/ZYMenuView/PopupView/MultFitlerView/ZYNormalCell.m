//
//  ZYNormalCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYNormalCell.h"
#import "ZYMenuHeader.h"
static const CGFloat horizontalMargin = 20.0f;
@interface ZYNormalCell()

@property (nonatomic, strong) UILabel *title;

@end

@implementation ZYNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(horizontalMargin, 0, 100, self.height);
}

- (void)setItem:(ZYItem *)item {
    _item = item;
    self.title.text = item.title;
    self.title.textColor = item.isSelected?[UIColor colorWithHexString:titleSelectedColor]:[UIColor colorWithHexString:DropDownBoxNormalColor];

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


@end
