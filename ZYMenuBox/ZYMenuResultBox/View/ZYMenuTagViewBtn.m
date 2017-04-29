//
//  ZYMenuTagViewBtn.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/29.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuTagViewBtn.h"
#import "ZYMenuHeader.h"

@implementation ZYMenuTagViewBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置字体的大小
        self.titleLabel.font = [UIFont systemFontOfSize:MenuResultViewTagFontSize];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectZero;
        
        [self setTitleColor:[UIColor colorWithHexString:MenuResultViewTagColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ZYMenu_Close"] forState:UIControlStateNormal];
        
    }
    return self;
}

@end
