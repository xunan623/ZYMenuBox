//
//  ZYCombTextFieldCell.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYItem.h"

@class ZYCombTextFieldCell;

@protocol ZYCombTextFieldCellDelegate <NSObject>

- (void)comTextFieldCell:(ZYCombTextFieldCell *)cell changeTextField:(UITextField *)textField;
- (void)comTextFieldCell:(ZYCombTextFieldCell *)cell beginEdited:(UITextField *)textField;

@end

@interface ZYCombTextFieldCell : UITableViewCell

@property (nonatomic, weak) id<ZYCombTextFieldCellDelegate> delegate;

@property (strong, nonatomic) ZYItem *item;

@end
