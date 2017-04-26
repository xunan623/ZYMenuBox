//
//  ZYMultiItem.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMultiItem.h"

@implementation ZYMultiItem
- (instancetype)init {
    self = [super init];
    if (self) {
        self.numberOflayers = ZYPopupViewTwolayers;
    }
    return self;
}
@end
