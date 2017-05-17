//
//  ZYMenuTitleButton.h
//  ZYMenuBox
//
//  Created by xunan on 2017/5/17.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮中图片的位置
 */
typedef NS_ENUM(NSUInteger, ZImageAlignment) {
    /**
     *  图片在左，默认
     */
    ZImageAlignmentLeft = 0,
    /**
     *  图片在上
     */
    ZImageAlignmentTop,
    /**
     *  图片在下
     */
    ZImageAlignmentBottom,
    /**
     *  图片在右
     */
    ZImageAlignmentRight,
};

@interface ZYMenuTitleButton : UIButton
/**
 *  按钮中图片的位置
 */
@property(nonatomic,assign)ZImageAlignment imageAlignment;
/**
 *  按钮中图片与文字的间距
 */
@property(nonatomic,assign)CGFloat spaceBetweenTitleAndImage;

@end
