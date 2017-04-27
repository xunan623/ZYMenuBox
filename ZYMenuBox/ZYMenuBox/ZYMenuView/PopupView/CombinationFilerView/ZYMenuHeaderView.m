//
//  ZYMenuHeaderView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/27.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuHeaderView.h"
#import "ZYAlternativeItem.h"
#import "ZYMenuHeader.h"

@implementation ZYMenuHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setItem:(ZYCombinationItem *)item {
    _item = item;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
