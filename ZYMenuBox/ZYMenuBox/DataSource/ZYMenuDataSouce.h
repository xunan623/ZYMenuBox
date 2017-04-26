//
//  ZYMenuDataSouce.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ZYMenuDataSouceType) {
    ZYMenuDataSouceTypeRent = 1,
    ZYMenuDataSouceTypeSale = 2
};


@interface ZYMenuDataSouce : NSObject

/** 价格数据 */
+ (NSMutableArray *)getDataArray:(ZYMenuDataSouceType)type;


@end
