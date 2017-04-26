//
//  ZYAlternativeItem.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYAlternativeItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)itemWithTitle:(NSString *)title isSelected:(BOOL)isSelected;


@end
