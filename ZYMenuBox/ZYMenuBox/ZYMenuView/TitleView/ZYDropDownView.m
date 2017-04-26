//
//  ZYDropDownView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYDropDownView.h"
#import "ZYMenuHeader.h"

@interface ZYDropDownView()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) CAGradientLayer *line;

@end

@implementation ZYDropDownView

- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.isSelected = NO;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapAction:)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrow];
        
        [self.layer addSublayer:self.line];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:DropDownBoxFontSize];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor colorWithHexString:DropDownBoxNormalColor];
        _titleLabel.frame = CGRectMake(DropDownBoxTitleHorizontalToLeft, 0 ,self.arrow.left - DropDownBoxTitleHorizontalToArrow - DropDownBoxTitleHorizontalToLeft  , self.height);
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pulldown.png"]];
        _arrow.frame = CGRectMake(self.width - ArrowSide - ArrowToRight,(self.height - ArrowSide)/2  , ArrowSide , ArrowSide);
    }
    return _arrow;
}

- (CAGradientLayer *)line {
    if (!_line) {
        UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
        UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
        NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
        NSArray *locations = @[@0.2, @0.5, @0.8];
        _line = [CAGradientLayer layer];
        _line.colors = colors;
        _line.locations = locations;
        _line.startPoint = CGPointMake(0, 0);
        _line.endPoint = CGPointMake(0, 1);
        _line.frame = CGRectMake(self.arrow.right + ArrowToRight - 1.0/scale , 0, 1.0/scale, self.height);
    }
    return _line;
}

#pragma mark - Action

- (void)updateTitleState:(BOOL)isSelected {
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithHexString:DropDownBoxSelectedColor];
        self.arrow.image = [UIImage imageNamed:@"pullup"];
    } else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.arrow.image = [UIImage imageNamed:@"pulldown"];
    }
}

- (void)updateTitleContent:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)respondToTapAction:(UITapGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(didTapDropDownView:atIndex:)]) {
        [self.delegate didTapDropDownView:self atIndex:self.tag];
    }
}

@end
