//
//  ZYBasePopupView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYBasePopupView.h"
#import "ZYItem.h"
#import "ZYMenuHeader.h"
#import "ZYSingleItem.h"
#import "ZYMultiFitlerView.h"
#import "ZYCombinationFitlerView.h"
#import "ZYCombinationItem.h"
#import "ZYSingleFitlerView.h"

@interface ZYBasePopupView()

@end

@implementation ZYBasePopupView

- (id)initWithItem:(ZYItem *)item {
    if (self = [self init]) {
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.shadowView = [[UIView alloc] init];
        self.shadowView.backgroundColor = [UIColor colorWithHexString:@"484848"];
        self.selectedArray = [NSMutableArray array];
        self.temporaryArray = [NSMutableArray array];
    }
    return self;
}

+ (ZYBasePopupView *)getSubPopupView:(ZYItem *)item {
    ZYBasePopupView *view;
    switch (item.displayType) {
        case ZYPopupViewDisplayTypeNormal:
            view =  [[ZYSingleFitlerView alloc] initWithItem:item];
            break;
        case ZYPopupViewDisplayTypeMultilayer:
            view =  [[ZYMultiFitlerView alloc] initWithItem:item];
            break;
        case ZYPopupViewDisplayTypeFilters:
            view =  [[ZYCombinationFitlerView alloc] initWithItem:item];
            break;
        default:
            break;
    }
    return view;
}

- (void)dismiss {
    if (self.superview) {
        [self.shadowView removeFromSuperview];
    }
}

- (void)dismissWithOutAnimation {
    if (self.superview) {
        [self.shadowView removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)())completion {
    //写这些方法是为了消除警告；
}

@end
