//
//  ZYNumberStringTool.m
//  ZYMenuBox
//
//  Created by xunan on 2017/5/3.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYNumberStringTool.h"

@implementation ZYNumberStringTool

+ (BOOL)zy_IsPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
