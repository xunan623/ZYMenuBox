//
//  ZYMenuHeaderView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/27.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCombinationItem.h"

@class ZYMenuHeaderView;

@protocol ZYMenuHeaderViewDelegate <NSObject>

- (void)headerView:(ZYMenuHeaderView *)headerView didSelectedAtIndex:(NSInteger)index currentState:(BOOL)isSelected;

@end

@interface ZYMenuHeaderView : UIView

@property (strong, nonatomic) ZYCombinationItem *item;
@property (weak, nonatomic) id<ZYMenuHeaderViewDelegate> delegate;

@end
