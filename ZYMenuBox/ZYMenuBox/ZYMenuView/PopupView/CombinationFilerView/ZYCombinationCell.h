//
//  ZYCombinationCell.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/27.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCombinationItem.h"
@class ZYCombinationCell;

@protocol ZYCombinationCellDelegate <NSObject>

- (void)combineCell:(ZYCombinationCell *)combineCell didSelectedAtIndex:(NSInteger)index;

@end

@interface ZYCombinationCell : UITableViewCell

@property (strong, nonatomic) ZYItem *item;
@property (nonatomic, weak) id<ZYCombinationCellDelegate> delegate;

@end
