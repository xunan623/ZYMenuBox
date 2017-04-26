//
//  ZYMultiItem.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYItem.h"

typedef NS_ENUM(NSUInteger, ZYPopupViewNumberoflayers) {
    ZYPopupViewTwolayers,
    ZYPopupViewThreelayers,
};

@interface ZYMultiItem : ZYItem
@property (nonatomic, assign) ZYPopupViewNumberoflayers numberOflayers;

@end
