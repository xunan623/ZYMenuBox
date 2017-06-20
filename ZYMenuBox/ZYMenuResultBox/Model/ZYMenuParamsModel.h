//
//  ZYMenuParamsModel.h
//  ZYMenuBox
//
//  Created by xunan on 2017/6/20.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYMenuParamsModel : NSObject

/** 区域参数 */
@property (nonatomic, copy) NSString *areaCode;
/** 价格 */
@property (nonatomic, copy) NSString *priceCode;
/** 户型 */
@property (nonatomic, copy) NSString *houseType;
/** 标签 */
@property (nonatomic, strong) NSMutableString *tagCode;
/** 朝向 */
@property (nonatomic, copy) NSString *directionCode;
/** 面积 */
@property (nonatomic, copy) NSString *acreageCode;
/** 楼层 */
@property (nonatomic, copy) NSString *floorCode;



@end
