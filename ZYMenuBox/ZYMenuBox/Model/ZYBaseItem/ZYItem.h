//
//  ZYItem.h
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYLayout.h"
#import "ZYSelectedPath.h"

//这个字段我们暂时留着以后扩展，覆盖可能要有些选项不能选择，显示灰色的情况
typedef NS_ENUM(NSUInteger, ZYPopupViewMarkType) {  //选中的状态
    ZYPopupViewDisplayTypeSelected = 0,      // 可以选中
    ZYPopupViewDisplayTypeUnselected = 1,    // 不可以选中
};

typedef NS_ENUM(NSUInteger, ZYPopupViewSelectedType) { //是否支持单选或者多选
    ZYPopupViewSingleSelection = 0,                            // 单选
    ZYPopupViewMultilSeMultiSelection = 1,                     // 多选
    ZYPopupViewInputViewSelection = 2                          // 输入框
};

typedef NS_ENUM(NSUInteger, ZYPopupViewDisplayType) { //分辨弹出来的view类型
    ZYPopupViewDisplayTypeNormal = 0,                //一层
    ZYPopupViewDisplayTypeMultilayer = 1,            //多层
    ZYPopupViewDisplayTypeFilters = 2,               //混合
};

@interface ZYItem : NSObject

/** 是否可以选中 */
@property (nonatomic, assign) ZYPopupViewMarkType markType;
/** 分辨弹出View的类型 */
@property (nonatomic, assign) ZYPopupViewDisplayType displayType;
/** 是否支持多选 */
@property (nonatomic, assign) ZYPopupViewSelectedType selectedType;

@property (nonatomic, assign) BOOL isSelected;                          //默认0 只有根这个属性没有意义
@property (nonatomic, copy) NSString *code;                             //支持有的需要上传code而不是title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray <ZYItem *>*childrenNodes;
@property (nonatomic, strong) NSString *subTitle;                       //第一层默认没有

@property (nonatomic, strong) ZYLayout *combinationLayout;


+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                       titleName:(NSString *)title;

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                       titleName:(NSString *)title
                     subTileName:(NSString *)subTile;

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                      isSelected:(BOOL)isSelected
                       titleName:(NSString *)title
                    subtitleName:(NSString *)subTile;

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                      isSelected:(BOOL)isSelected
                       titleName:(NSString *)title
                    subtitleName:(NSString *)subtitle
                            code:(NSString *)code;
- (void)addNode:(ZYItem *)node;
- (NSString *)findTitleBySelectedPath:(ZYSelectedPath *)selectedPath;

@end
