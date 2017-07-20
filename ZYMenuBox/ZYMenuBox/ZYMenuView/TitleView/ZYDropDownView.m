//
//  ZYDropDownView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYDropDownView.h"
#import "ZYMenuHeader.h"
#import "ZYMenuTitleButton.h"

@interface ZYDropDownView()

@property (strong, nonatomic) ZYMenuTitleButton *titleButton;

@end

@implementation ZYDropDownView

- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.isSelected = NO;
        self.userInteractionEnabled = YES;

        [self addSubview:self.titleButton];
    }
    return self;
}

- (ZYMenuTitleButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [[ZYMenuTitleButton alloc] init];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:DropDownBoxFontSize];
        [_titleButton setTitle:self.title forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor colorWithHexString:DropDownBoxNormalColor] forState:UIControlStateNormal];
        _titleButton.frame = CGRectMake(0, 0 , self.width, self.height);
        _titleButton.imageAlignment = ZImageAlignmentRight;
        _titleButton.spaceBetweenTitleAndImage = 2;
        [_titleButton addTarget:self action:@selector(respondToTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setImage:[UIImage imageNamed:@"pulldown.png"] forState:UIControlStateNormal];
    }
    return _titleButton;
}

#pragma mark - Action

- (void)updateTitleState:(BOOL)isSelected {
    if (isSelected) {
        [self.titleButton  setImage:[UIImage imageNamed:@"pullup"] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor colorWithHexString:DropDownBoxSelectedColor] forState:UIControlStateNormal];
    } else{
        [self.titleButton  setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor colorWithHexString:DropDownBoxNormalColor] forState:UIControlStateNormal];
    }
}

- (void)updateTitleContent:(NSString *)title {
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}

- (void)updateTitleColor:(BOOL)isSelected {
    [self.titleButton setTitleColor:[UIColor colorWithHexString:isSelected ? DropDownBoxSelectedColor : DropDownBoxNormalColor] forState:UIControlStateNormal];
}

- (void)respondToTapAction:(id)gesture {
    if ([self.delegate respondsToSelector:@selector(didTapDropDownView:atIndex:)]) {
        [self.delegate didTapDropDownView:self atIndex:self.tag];
    }
}

@end
