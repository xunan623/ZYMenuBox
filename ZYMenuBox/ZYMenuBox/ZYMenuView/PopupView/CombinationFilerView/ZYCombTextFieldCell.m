//
//  ZYCombTextFieldCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYCombTextFieldCell.h"
#import "SFDualWaySlider.h"
#import "ZYMenuHeader.h"

@interface ZYCombTextFieldCell()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIView *centerLine;

@property (strong, nonatomic) UITextField *lowFloorField;
@property (strong, nonatomic) UITextField *highFloorField;

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
    

    
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    
    // 标题
    self.titleLabel.frame = CGRectMake(CombinaTableViewHeaderLeftMargin,
                                       CombinaTableViewHeaderTopMargin,
                                       self.width - CombinaTableViewHeaderLeftMargin ,
                                       CombinaTableViewHeaderTextLabelHeight);
}

- (void)setItem:(ZYItem *)item {
    _item = item;

    // 放标题
    self.titleLabel.text = item.title;
    if (self.titleLabel.superview == nil) {
        [self addSubview:self.titleLabel];
    }
    
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[SFDualWaySlider class]]) {
            [subView removeFromSuperview];
        }
    }
    
    SFDualWaySlider *slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(CombinaTableViewSliderLeftMargin,
                                                                CombinaTableViewHeaderHeight,
                                                                kScreenWidth - 2 * CombinaTableViewSliderLeftMargin,
                                                                ComTextFieldCenterViewH)
                                            minValue:CombinaSliderMinValue
                                            maxValue:CombinaSliderMaxValue
                                     blockSpaceValue:1];
    slider.progressRadius = 0.0;
    
    slider.minIndicateView.backIndicateColor = [UIColor clearColor];
    slider.maxIndicateView.backIndicateColor = [UIColor clearColor];
    
    if (!item.childrenNodes[0].isSelected && !item.childrenNodes[1].isSelected) {
        [slider.minIndicateView setTitle:[NSString stringWithFormat:@"%.f层", CombinaSliderMinValue]];
        [slider.maxIndicateView setTitle:[NSString stringWithFormat:@"%.f层", CombinaSliderMaxValue]];

        slider.frontScale = 0.7;
        slider.frontValue = 15;

        [slider setCurrentMaxValue:CombinaSliderMaxValue];
        [slider setCurrentMinValue:CombinaSliderMinValue];

    } else {
        [slider.minIndicateView setTitle:[NSString stringWithFormat:@"%.f层", floor([item.childrenNodes[0].title floatValue])]];
        [slider.maxIndicateView setTitle:[NSString stringWithFormat:@"%.f层", floor([item.childrenNodes[1].title floatValue])]];
        
        slider.frontScale = 0.7;
        slider.frontValue = 15;
        
        [slider setCurrentMaxValue:[item.childrenNodes[1].title floatValue]];
        [slider setCurrentMinValue:[item.childrenNodes[0].title floatValue]];

    }
    
    
    __weak __block typeof(self) blockSelf = self;
    
    slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        
        if ([blockSelf.delegate respondsToSelector:@selector(comTextFieldCell:changeLowFloor:highFloor:)]) {
            [blockSelf.delegate comTextFieldCell:blockSelf changeLowFloor:[NSString stringWithFormat:@"%.f",floor(minValue)] highFloor:[NSString stringWithFormat:@"%.f",floor(maxValue)]];
        }
    };
    
    slider.getMinTitle = ^NSString *(CGFloat minValue) {
        if (floor(minValue) == 0.f) {
            return @"不限";
        }else{
            blockSelf.item.childrenNodes[0].title = [NSString stringWithFormat:@"%.f",floor(minValue)];
            return [NSString stringWithFormat:@"%.f层",floor(minValue)];
        }
        
    };
    
    slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
        blockSelf.item.childrenNodes[1].title = [NSString stringWithFormat:@"%.f",floor(maxValue)];
        return [NSString stringWithFormat:@"%.f层",floor(maxValue)];
    };

    [self.contentView addSubview:slider];
}

#pragma mark - Setting & Getting
#pragma mark - Setting & Getting
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:CombinaTableViewHeaderTextLabelFont];
        _titleLabel.textColor = [UIColor colorWithHexString:CombinaTableViewHeaderTextLabelColor];
    }
    return _titleLabel;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
    }
    return _centerView;
}

@end
