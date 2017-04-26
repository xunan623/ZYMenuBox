//
//  ZYAlternativeItem.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYAlternativeItem.h"

@implementation ZYAlternativeItem

+ (instancetype)itemWithTitle:(NSString *)title isSelected:(BOOL)isSelected {
    ZYAlternativeItem *item = [[[self class] alloc] init];
    item.title = title;
    item.isSelected = isSelected;
    return item;
}

@end
