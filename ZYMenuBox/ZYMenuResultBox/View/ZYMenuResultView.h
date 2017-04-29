//
//  ZYMenuResultView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYMenuResultView : UIView

/** 设置背景色 */
@property (nonatomic, strong) UIColor *bgColor;

/** 数据源 */
- (void)setupWithArray:(NSMutableArray *)array withIndex:(NSInteger)index;

@end
