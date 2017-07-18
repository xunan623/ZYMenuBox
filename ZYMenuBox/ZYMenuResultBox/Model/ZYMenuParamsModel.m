//
//  ZYMenuParamsModel.m
//  ZYMenuBox
//
//  Created by xunan on 2017/6/20.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuParamsModel.h"

@implementation ZYMenuParamsModel

- (NSMutableString *)tagCode {
    if (!_tagCode) {
        _tagCode = [NSMutableString string];
    }
    return _tagCode;
}

- (NSMutableString *)floorCode {
    if (!_floorCode) {
        _floorCode = [NSMutableString string];
    }
    return _floorCode;
}

@end
