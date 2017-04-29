//
//  ZYCombTextFieldCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYCombTextFieldCell.h"
#import "ZYMenuHeader.h"

@interface ZYCombTextFieldCell()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIView *centerLine;

@end

@implementation ZYCombTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(ItemHorizontalMargin, TitleVerticalMargin, self.width - ItemHorizontalMargin , TitleHeight);
    self.centerView.frame = CGRectMake(ItemHorizontalMargin, self.titleLabel.height + 10 + self.titleLabel.top, kScreenWidth - 2 * ItemHorizontalMargin, ComTextFieldCenterViewH);    
    self.centerLine.frame = CGRectMake(self.centerView.width/2 - 8, self.centerView.height/2 , 16, 1);
    
    NSInteger count = 2;
    for (NSInteger i = 0; i< count; i++) {
        UIButton *bgView = [[UIButton alloc] init];
        bgView.layer.masksToBounds = YES;
        bgView.layer.borderWidth = .5f;
        bgView.layer.borderColor = [UIColor colorWithHexString:DropDownBoxNormalColor].CGColor;
        [bgView setTitle:@"层" forState:UIControlStateNormal];
        bgView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        bgView.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        bgView.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSize];
        [bgView setTitleColor:[UIColor colorWithHexString:DropDownBoxNormalColor] forState:UIControlStateNormal];
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:ButtonFontSize];
        textField.textColor = [UIColor colorWithHexString:DropDownBoxSelectedColor];
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.tag = i * 100;
        [textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];

        textField.delegate = self;
        if (i == 0) {
            bgView.frame = CGRectMake(0, 0, self.centerView.width/2 - 20, ComTextFieldCenterViewH);
        } else {
            bgView.frame = CGRectMake(kScreenWidth/2 + 10, 0, self.centerView.width/2 - 20, ComTextFieldCenterViewH);
        }
        textField.frame = CGRectMake(bgView.left + 10, 0, bgView.width - 30, ComTextFieldCenterViewH);
        textField.placeholder = @"不限";
        [self.centerView addSubview:bgView];
        [self.centerView addSubview:textField];
        
    }
    
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.centerView];
    [self.centerView addSubview:self.centerLine];
}

- (void)setItem:(ZYItem *)item {
    _item = item;

    // 放标题
    self.titleLabel.text = item.title;
    if (self.titleLabel.superview == nil) {
        [self addSubview:self.titleLabel];
    }
}

#pragma mark - Setting & Getting
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:ButtonFontSize];
    }
    return _titleLabel;
}

- (UIView *)centerLine {
    if (!_centerLine) {
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = [UIColor colorWithHexString:@"95A0B5"];
    }
    return _centerLine;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
    }
    return _centerView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldWithText:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            NSLog(@"%@", textField.text);
            break;
        case 100:
            NSLog(@"%@", textField.text);
            break;
        default:
            break;
    }
}

@end
