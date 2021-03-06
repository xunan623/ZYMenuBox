//
//  ZYLayout.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYLayout.h"
#import "ZYCombinationItem.h"

@implementation ZYLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellLayoutTotalHeight = [NSMutableArray array];
        self.cellLayoutTotalInfo = [NSMutableArray array];
        self.rowHeightArray = [NSMutableArray array];
        self.rowNumber = (kScreenWidth - 2*ItemHorizontalMargin)/(ItemWidth + ItemHorizontalDistance);
        
    }
    return self;
}

+ (instancetype)layoutWithItem:(ZYCombinationItem *)item {
    
    ZYLayout *layout = [[ZYLayout alloc] init];
    layout.headerViewHeight = item.alternativeArray.count * (2*AlternativeTitleVerticalMargin + AlternativeTitleHeight);
    layout.totalHeight += layout.headerViewHeight;
    for (int i = 0; i < item.childrenNodes.count; i++) {
        ZYItem *subItem = item.childrenNodes[i];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:subItem.childrenNodes.count];
        
        CGFloat totalCellHeight = 2*TitleVerticalMargin + ItemHeight;
        NSInteger columnNumber = MAX(1,subItem.childrenNodes.count /layout.rowNumber + ((subItem.childrenNodes.count %layout.rowNumber)?1:0));
        totalCellHeight += columnNumber*(ItemHeight + TitleVerticalMargin);
        [layout.cellLayoutTotalHeight addObject:@(totalCellHeight)];
        
        // 计算自定义高度
        if (subItem.selectedType == ZYPopupViewInputViewSelection) {
            [layout.rowHeightArray addObject:@(120)];
        } else {
            CGFloat baseHeight = CombinaTableViewHeaderHeight;
            NSInteger line = subItem.childrenNodes.count / CombinaRowNumber + ((subItem.childrenNodes.count) % CombinaRowNumber ? 1 : 0 );
            CGFloat totalButtonHeight = baseHeight + line * CombinaButtonHeight + (line - 1) * CombinaButtonVerticalSpace;
            [layout.rowHeightArray addObject:@(totalButtonHeight)];
        }
        
        layout.totalHeight += totalCellHeight;
        //布局
        for (int j = 0; j < columnNumber; j ++){
            if ( j ==  columnNumber -1) {
                for (int k = 0; k < (subItem.childrenNodes.count %layout.rowNumber?subItem.childrenNodes.count%layout.rowNumber:layout.rowNumber) ; k++) {
                    [array addObject:@[@(k*(ItemWidth + ItemHorizontalDistance) + ItemHorizontalMargin),@((2*TitleVerticalMargin + ItemHeight) + j*(ItemHeight + TitleVerticalMargin))]];
                }
            }else {
                for (int m = 0; m < layout.rowNumber; m++) {
                    [array addObject:@[@(m*(ItemWidth + ItemHorizontalDistance) + ItemHorizontalMargin),@((2*TitleVerticalMargin + ItemHeight) + j*(ItemHeight + TitleVerticalMargin))]];
                }
            }
        }
        [layout.cellLayoutTotalInfo addObject:array];
        


        
    }
    
    
    return  layout;
}


@end
