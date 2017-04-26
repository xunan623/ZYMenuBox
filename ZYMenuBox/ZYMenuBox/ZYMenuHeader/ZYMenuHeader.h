//
//  ZYMenuHeader.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#ifndef ZYMenuHeader_h
#define ZYMenuHeader_h

#import "UIColor+ZYMenuExtension.h"
#import "UIView+ZYMenuExtension.h"

#define scale [UIScreen mainScreen].scale
static  NSString *titleSelectedColor = @"FF0000";
static const CGFloat  ButtonFontSize = 14.0f;
//MMPopupView
static const CGFloat PopupViewRowHeight = 44.0f;
static const CGFloat DistanceBeteewnPopupViewAndBottom =80.0f;
static const CGFloat PopupViewTabBarHeight = 40.0f;
static const CGFloat LeftCellHorizontalMargin = 10.0f;
static CGFloat LeftCellWidth = 100.0f;
static const CGFloat ShadowAlpha = 0.5;
//static const CGFloat
static  NSString *MainCellID = @"MainCellID";
static  NSString *SubCellID = @"SubCellID";
static const NSTimeInterval AnimationDuration= .25;
static const CGFloat ButtonHorizontalMargin = 10.0f;

/* fontSize*/
static const CGFloat MainTitleFontSize = 13.0f;
static const CGFloat SubTitleFontSize = 12.0f;
/* color */
static  NSString *SelectedBGColor = @"F2F2F2";
static  NSString *UnselectedBGColor = @"FFFFFF";
//MMComBoBoxView

//MMCombinationFitlerView
static const CGFloat AlternativeTitleVerticalMargin = 10.0f;
static const CGFloat AlternativeTitleHeight = 31.0f;

static const CGFloat TitleVerticalMargin = 10.0f;
static const CGFloat TitleHeight  = 20.0f;

static const CGFloat ItemHeight  = 30.0f;
static const CGFloat ItemWidth  = 80.0f;
static const CGFloat ItemHorizontalMargin = 10.0f;
static const CGFloat ItemHorizontalDistance = 5.0f;
//MMDropDownBox
static const CGFloat DropDownBoxFontSize = 14.0f;
static NSString *DropDownBoxSelectedColor = @"FF0000";
static NSString *DropDownBoxNormalColor = @"9398AA";

static const CGFloat ArrowSide = 8.0f;
static const CGFloat ArrowToRight = 6.0f;
static const CGFloat DropDownBoxTitleHorizontalToArrow = 10.0f;
static const CGFloat DropDownBoxTitleHorizontalToLeft  = 15.0f;
#define kScreenHeigth [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#endif /* ZYMenuHeader_h */
