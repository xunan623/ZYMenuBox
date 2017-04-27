//
//  ZYCombinationItem.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYCombinationItem.h"

@implementation ZYCombinationItem

- (void)addAlternativeItem:(ZYAlternativeItem *)item {
    [self.alternativeArray addObject:item];
}

- (void)addLayoutInformationWhenTypeFilters {
    // 不是混合类型返回
    if (self.displayType != ZYPopupViewDisplayTypeFilters)  return;
    
    self.combinationLayout = [ZYLayout layoutWithItem:self];
    for (int i = 0; i < self.childrenNodes.count; i++) {
        ZYCombinationItem *subItem = (ZYCombinationItem *)self.childrenNodes[i];
        subItem.combinationLayout = [[ZYLayout alloc] init];
        [subItem.combinationLayout.cellLayoutTotalInfo addObjectsFromArray:self.combinationLayout.cellLayoutTotalInfo[i]];
    }
}

- (BOOL)isHasSwitch {
    return (self.alternativeArray.count != 0);
}

- (NSMutableArray *)alternativeArray {
    if (_alternativeArray == nil) {
        _alternativeArray = [NSMutableArray array];
    }
    return _alternativeArray;
}


@end
