//
//  ZYMenuResultView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYMenuParamsModel.h"

@class ZYItem;

@protocol ZYMenuResultViewDelegate <NSObject>

- (void)didSelectedTagView;

/** 接口参数 */
- (void)resultViewFilterParams:(ZYMenuParamsModel *)model;

@end

@interface ZYMenuResultView : UIView


@property (nonatomic, strong) ZYMenuParamsModel *paramsModel;

@property (nonatomic, weak) id<ZYMenuResultViewDelegate> delegate;

/** 设置背景色 */
@property (nonatomic, strong) UIColor *bgColor;

/** 数据源 */
- (void)setupWithArray:(NSArray *)array withIndex:(NSInteger)index dataArray:(NSMutableArray *)dataArray;

@end
