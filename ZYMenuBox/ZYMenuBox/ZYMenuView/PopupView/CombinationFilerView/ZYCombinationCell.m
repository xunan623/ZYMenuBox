//
//  ZYCombinationCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/27.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYCombinationCell.h"

@interface ZYCombinationCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *btnArray;

@end

@implementation ZYCombinationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setItem:(ZYItem *)item {
    _item = item;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    // 放标题
    self.titleLabel.text = item.title;
    if (self.titleLabel.superview == nil) {
        [self addSubview:self.titleLabel];
    }
    
    CGFloat viewWidth = kScreenWidth - CombinaButtonLeftMargin*2;

    
    CGFloat buttonWidth = (viewWidth - CombinaButtonHorizontalSpace * (CombinaRowNumber - 1)) / CombinaRowNumber;
    
    // 放按钮
    for (NSInteger i = 0; i < item.childrenNodes.count; i++) {

        
        ZYItem *subItem = item.childrenNodes[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake((i%CombinaRowNumber)*(buttonWidth + CombinaButtonHorizontalSpace) + CombinaButtonLeftMargin,
                                  (i/CombinaRowNumber) *(CombinaButtonHeight + CombinaButtonVerticalSpace) + CombinaTableViewHeaderHeight,
                                  buttonWidth,
                                  CombinaButtonHeight) ;

        button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSize];
        button.layer.borderWidth = 1.0/scale;
        button.tag = i;
        button.layer.borderColor = subItem.isSelected ? [UIColor colorWithHexString:titleSelectedColor].CGColor : [UIColor colorWithHexString:@"e8e8e8"].CGColor;
        [button setTitle:subItem.title forState:UIControlStateNormal];
        [button setTitleColor:subItem.isSelected?[UIColor colorWithHexString:titleSelectedColor]:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = subItem.isSelected?[UIColor colorWithHexString:ComBinationItemSelectedBgColor]:[UIColor whiteColor];
        [button addTarget:self action:@selector(respondsToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    // layout
    self.titleLabel.frame = CGRectMake(CombinaTableViewHeaderLeftMargin,
                                       CombinaTableViewHeaderTopMargin,
                                       self.width - CombinaTableViewHeaderLeftMargin ,
                                       CombinaTableViewHeaderTextLabelHeight);
}

#pragma armk - Action
- (void)respondsToButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(combineCell:didSelectedAtIndex:)]) {
        [self.delegate combineCell:self didSelectedAtIndex:btn.tag];
    }
}

#pragma mark - Setting & Getting
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:CombinaTableViewHeaderTextLabelFont];
        _titleLabel.textColor = [UIColor colorWithHexString:CombinaTableViewHeaderTextLabelColor];
    }
    return _titleLabel;
}



@end
