//
//  ZYLayout.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYCombinationItem;
#import "ZYMenuHeader.h"

@interface ZYLayout : NSObject

@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat alternativeTitleHeight;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableArray *cellLayoutTotalHeight;

@property (nonatomic, strong) NSMutableArray *cellLayoutTotalInfo;

// 新增自定义高度
@property (nonatomic, strong) NSMutableArray *rowHeightArray;

@property (nonatomic, strong) ZYCombinationItem *item;

+ (instancetype)layoutWithItem:(ZYCombinationItem *)item;

@end
