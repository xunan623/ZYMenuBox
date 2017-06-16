//
//  ZYMenuLeftCell.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuLeftCell.h"

@interface ZYMenuLeftCell()

@property (nonatomic, strong) UILabel *infoLabel;
//@property (nonatomic, strong) CALayer *bottomLine;

@end

@implementation ZYMenuLeftCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        [self addSubview:self.infoLabel];
    }
    return self;
}   

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.infoLabel.frame = CGRectMake(LeftCellHorizontalMargin, 0, self.width - 2 *LeftCellHorizontalMargin, self.height);
}

#pragma mark - Setting * Getting 

- (void)setItem:(ZYItem *)item {
    _item = item;
    self.infoLabel.text = item.title;

    self.backgroundColor = item.isSelected?[UIColor colorWithHexString:LeftTableViewCellBackgroundColor]:[UIColor whiteColor];
    self.infoLabel.textColor = item.isSelected?[UIColor colorWithHexString:DropDownBoxSelectedColor]:[UIColor colorWithHexString:DropDownBoxNormalColor];

}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.font = [UIFont systemFontOfSize:MainTitleFontSize];
    }
    return _infoLabel;
}

@end
