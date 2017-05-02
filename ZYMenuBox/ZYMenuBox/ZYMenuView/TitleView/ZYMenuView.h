//
//  ZYMenuView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYItem.h"

@class ZYMenuView;

@protocol ZYMenuViewDataSource <NSObject>

- (NSInteger)numberOfColumnsInMenuView:(ZYMenuView *)menuView;
- (ZYItem *)menuView:(ZYMenuView *)menuView menuForColumn:(NSInteger)column;

@end

@protocol ZYMenuViewDelegate  <NSObject>

- (void)menuView:(ZYMenuView *)menuView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSInteger)index;

@end

@interface ZYMenuView : UIView

@property (nonatomic, weak) id<ZYMenuViewDelegate> delegate;
@property (nonatomic, weak) id<ZYMenuViewDataSource> dataSource;

/** 加载下拉菜单数据 只能第一次加载时候用 */
- (void)reload;
- (void)dimissPopView;

/** 刷新对应标题 */
- (void)reloadTitle;

@end
