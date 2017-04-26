//
//  ZYDropDownView.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYDropDownView;

@protocol ZYDropDownViewDelegate <NSObject>

- (void)didTapDropDownView:(ZYDropDownView *)dropDownView atIndex:(NSUInteger)index;

@end

@interface ZYDropDownView : UIView

- (id)initWithFrame:(CGRect)frame titleName:(NSString *)title;

@property (nonatomic, weak) id<ZYDropDownViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

- (void)updateTitleState:(BOOL)isSelected;
- (void)updateTitleContent:(NSString *)title;

@end
