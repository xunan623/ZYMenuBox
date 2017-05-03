//
//  ZYMenuTagViewBtn.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/29.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYItem.h"
#import "ZYSelectedPath.h"
@interface ZYMenuTagViewBtn : UIButton

@property (nonatomic, strong) ZYItem *item;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) ZYSelectedPath *keyPath;

@end
