//
//  ZYBasePopupView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYItem, ZYBasePopupView;

@protocol ZYPopupViewDelegate <NSObject>

@optional
- (void)popupView:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;
@required
- (void)popupViewWillDismiss:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index;

@end

@interface ZYBasePopupView : UIView

+ (ZYBasePopupView *)getSubPopupView:(ZYItem *)item;
- (id)initWithItem:(ZYItem *)item;

- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void(^)())completion;
- (void)dismiss;
- (void)dismissWithOutAnimation;

@property (nonatomic, weak) id<ZYPopupViewDelegate> delegate;

@property (nonatomic, assign) CGRect sourceFrame;                                       /* tapBar的frame**/
@property (nonatomic, strong) UIView *shadowView;                                       /* 遮罩层**/
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) NSMutableArray *selectedArray;                            /* 记录所选的item**/
@property (nonatomic, strong) NSArray *temporaryArray;                                  /* 暂存最初的状态**/


@end
