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
static const CGFloat  ButtonFontSize = 12.0f;
//ZYPopupView
static const CGFloat PopupViewRowHeight = 44.0f;
static const CGFloat DistanceBeteewnPopupViewAndBottom =80.0f;
static const CGFloat PopupViewTabBarHeight = 49.0f;
static const CGFloat LeftCellHorizontalMargin = 20.0f;
static CGFloat LeftCellWidth = 100.0f;
static const CGFloat ShadowAlpha = 0.5;
//static const CGFloat
static  NSString *MainCellID = @"MainCellID";
static  NSString *SubCellID = @"SubCellID";
static NSString *TextFieldCellID = @"TextFieldCellID";
static const NSTimeInterval AnimationDuration= .25;
static const CGFloat ButtonHorizontalMargin = 10.0f;

/* fontSize*/
static const CGFloat MainTitleFontSize = 13.0f;
static const CGFloat SubTitleFontSize = 12.0f;
/* color */
static  NSString *SelectedBGColor = @"F2F2F2";
static  NSString *UnselectedBGColor = @"FFFFFF";
//ZYComBoBoxView

//ZYCombinationFitlerView
static NSString *CombinationBottomBGColor = @"FFFFFF";
static NSString *CombinationSelectedColor = @"FF634D";
static NSString *ComBinationItemSelectedBgColor = @"FEF3F1";
static const CGFloat AlternativeTitleVerticalMargin = 10.0f;
static const CGFloat AlternativeTitleHeight = 31.0f;

static const CGFloat TitleVerticalMargin = 10.0f;
static const CGFloat TitleHeight  = 20.0f;

static const CGFloat ItemHeight  = 30.0f;
static const CGFloat ItemWidth  = 80.0f;
static const CGFloat ItemHorizontalMargin = 10.0f;
static const CGFloat ItemHorizontalDistance = 5.0f;

// ZYCombTextFieldCell
static const CGFloat ComTextFieldCenterViewH = 70.0f;

//ZYDropDownBox
static const CGFloat DropDownBoxFontSize = 14.0f;
static NSString *DropDownBoxSelectedColor = @"FF0000";
static NSString *DropDownBoxNormalColor = @"9398AA";

// 左边列表颜色
static NSString *LeftTableViewCellBackgroundColor = @"0xf9fafc";
// 清除按钮颜色
static NSString *DropDownBoxViewClearButtonColor = @"ff634d";
// 按钮字体
static CGFloat DropDownBoxViewCombinaSubmitFont = 17.0f;

// 弹出View距离dropBarTop距离
static const CGFloat DropDownBoxViewTopMargin = 4.0f;
// 弹出View的高度 单列
static const CGFloat DropDownBoxViewSingeHeight = 300.0f;
// 弹出View的高度 多列
static const CGFloat DropDownBoxViewMultiHeight = 300.0f;

// 布局多选按钮
static const NSInteger CombinaRowNumber = 3;
// 按钮距离边距
static const CGFloat CombinaButtonLeftMargin = 17.0f;
// 按钮距离底部
static const CGFloat CombinaButtonBottomMargin = 10.0f;
// 垂直间距
static const CGFloat CombinaButtonVerticalSpace = 13.0f;
// 水平间距
static const CGFloat CombinaButtonHorizontalSpace = 13.0f;
// 按钮高
static const CGFloat CombinaButtonHeight = 30.0f;

// 标题高度
static const CGFloat CombinaTableViewHeaderHeight = 40.0f;
// 标题左间距
static const CGFloat CombinaTableViewHeaderLeftMargin = 30.0f;
// 标题上间距
static const CGFloat CombinaTableViewHeaderTopMargin = 15.0f;
// 标题高度
static const CGFloat CombinaTableViewHeaderTextLabelHeight = 15.0f;
// 标题字体大小
static const CGFloat CombinaTableViewHeaderTextLabelFont = 14.0f;
// 标题颜色
static NSString *CombinaTableViewHeaderTextLabelColor = @"838EA6";

// 滑竿距离左侧
static const CGFloat CombinaTableViewSliderLeftMargin = 15.0f;






static const CGFloat ArrowSide = 8.0f;
static const CGFloat ArrowToRight = 6.0f;
static const CGFloat DropDownBoxTitleHorizontalToArrow = 10.0f;
static const CGFloat DropDownBoxTitleHorizontalToLeft  = 15.0f;

// ZYMenuResultView
static NSString * MenuResultBgColor = @"F8F8F9";
static const CGFloat MenuResultViewTagFontSize = 14.0f;
static NSString *MenuResultViewTagColor = @"9398AA";



#define kScreenHeigth [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#endif /* ZYMenuHeader_h */
