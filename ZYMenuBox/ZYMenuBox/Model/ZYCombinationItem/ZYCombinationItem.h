//
//  ZYCombinationItem.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYItem.h"
#import "ZYAlternativeItem.h"

@interface ZYCombinationItem : ZYItem

@property (nonatomic, assign) BOOL isHasSwitch;                         //是否有Switch类型
@property (nonatomic, strong) NSMutableArray <ZYAlternativeItem *>*alternativeArray;         //当有这种的类型则一定为MMPopupViewDisplayTypeFilters类型

- (void)addLayoutInformationWhenTypeFilters;
- (void)addAlternativeItem:(ZYAlternativeItem *)item;

@end
