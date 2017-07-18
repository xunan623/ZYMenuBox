//
//  ZYMenuDataSouce.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/26.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuDataSouce.h"
#import "ZYItem.h"
#import "ZYSingleItem.h"
#import "ZYMultiItem.h"
#import "ZYCombinationItem.h"

@implementation ZYMenuDataSouce

+ (NSMutableArray *)getDataArray:(ZYMenuDataSouceType)type {
    NSMutableArray *dataArray = [NSMutableArray array];
    ZYMultiItem *rootItem1 = [ZYMultiItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"区域"];
    
    ZYSingleItem *rootItem2 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"价格"];
    ZYSingleItem *rootItem4 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"户型"];
    
    ZYCombinationItem *rootItem5 = [ZYCombinationItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"更多"];
    
    // 更多 多选
    rootItem5.displayType = ZYPopupViewDisplayTypeFilters;

    // 标签
    NSArray *tagArray = @[@"满五", @"满二", @"唯一", @"地铁房", @"学区房", @"签赔", @"钥匙", @"租售", @"备案", @"独家", @"委托"];
    // 朝向
    NSArray *directionArray = @[@"东", @"西" , @"南", @"北", @"东南", @"西南", @"东北", @"西北", @"南北"];
    // 面积
    NSArray *areaTitle = @[@"50平米以下",@"50-70平米",@"70-90平米",@"90-110平米",@"110-130平米",@"130-150平米",@"150-200平米",@"200-300平米",@"300平米以上"];
//    NSArray *areaCode = @[@"0-49",@"50-70",@"70-90",@"90-110",@"110-130",@"130-150",@"150-200",@"200-300",@"301-"];
    
    NSArray *floorCode = @[@"0", @"20"];
    NSArray *comArray = @[@{ZYMenuFilterParamsTag : tagArray},
                          @{ZYMenuFilterParamsDirection : directionArray},
                          @{ZYMenuFilterParamsAcreage : areaTitle},
                          @{ZYMenuFilterParamsFloor : floorCode}];
    for (NSInteger i = 0; i < comArray.count; i++) {
        NSDictionary *itemDict = comArray[i];
        ZYItem *item5_A = [ZYItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:[itemDict.allKeys lastObject]];
        if (i == comArray.count - 1) {
            item5_A.selectedType = ZYPopupViewInputViewSelection;
        } else if (i == 0) {
            item5_A.selectedType = ZYPopupViewMultilSeMultiSelection;
        } else {
            item5_A.selectedType = ZYPopupViewSingleSelection ;
        }
        
        [rootItem5 addNode:item5_A];
        
        if (i == comArray.count -1) {
            NSInteger count = [[itemDict.allValues lastObject] count];
            for (NSInteger k = 0; k < count; k++) {
                NSString *title = [itemDict.allValues lastObject][k];
                ZYItem *item5_B = [ZYItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:title];
                item5_B.selectedType = ZYPopupViewInputViewSelection;
                [item5_A addNode:item5_B];
            }
        } else {
            NSInteger count = [[itemDict.allValues lastObject] count];
            for (NSInteger j = 0; j < count; j++) {
                NSString *title = [itemDict.allValues lastObject][j];
                ZYItem *item5_B = [ZYItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:title];
                item5_B.selectedType = ZYPopupViewMultilSeMultiSelection;
                [item5_A addNode:item5_B];
            }
        }
    }
    
    
    // 区域 二级菜单
    rootItem1.displayType = ZYPopupViewDisplayTypeMultilayer;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *cityArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSString *pathArea = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    NSMutableArray * pianArray = [NSMutableArray arrayWithContentsOfFile:pathArea];
//    [pianArray insertObject:@"全部" atIndex:0];
    for (NSInteger i = 0; i< cityArray.count; i++) {
        NSDictionary *dict = cityArray[i];
        ZYItem *item_A = [ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected
                                       isSelected:NO
                                        titleName:dict[@"CREATED_BY"]
                                     subtitleName:@""
                                             code:dict[@"DISTRICT_NAME"]];
        item_A.isSelected = (i == 0);
        [rootItem1 addNode:item_A];
        
//        if (i == 0) continue;
        
        for (NSInteger j = 0; j < pianArray.count; j ++) {
//            if (j == 0) {
//                ZYItem *item_B =  [ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected
//                                                isSelected:NO
//                                                 titleName:@"全部"
//                                              subtitleName:dict[@"CREATED_BY"]
//                                                      code:dict[@"DISTRICT_NAME"]];
//                [item_A addNode:item_B];
//                
//            } else {
                NSDictionary *subDict = pianArray[j];
                if ([subDict [@"CREATED_BY"] isEqualToString:dict[@"DISTRICT_NAME"]]) {
                    ZYItem *item_B =  [ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected
                                                    isSelected:NO
                                                     titleName:subDict[@"UPDATED_BY"]
                                                  subtitleName:@""
                                                          code:subDict[@"CREATED_TIME"]];
                    [item_A addNode:item_B];
                }
//            }
      
        }
        // 默认二层选中第一个
        for (NSInteger k =0; k< item_A.childrenNodes.count; k++) {
            ZYItem *item = item_A.childrenNodes[k];
            item.isSelected = (i == 0 && k ==0);
        }

    }
    
    // 价格
    switch (type) {
        case ZYMenuDataSouceTypeRent: {
            NSArray *rentPriceTitle = @[@"全部",@"2000元以下",@"2000-3000元",@"3000-5000元",@"5000-8000元",@"8000-12000元",@"12000元以上"];
            NSArray *rentPriceCode = @[@"",@"0-1999",@"2000-3000",@"3000-5000",@"5000-8000",@"8000-12000",@"12001-"];
            for (NSInteger i = 0 ; i< rentPriceCode.count; i++) {
                [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected
                                                 isSelected:(i==0 ? YES : NO)
                                                  titleName:rentPriceTitle[i]
                                               subtitleName:nil
                                                       code:rentPriceCode[i]]];
            }
        }
            break;
        case ZYMenuDataSouceTypeSale: {
            NSArray *salePriceTitle = @[@"全部",@"150万以下",@"150-200万",@"200-250万",@"250-350万",@"350-500万",@"500-700万",@"700-1000万",@"1000万以上"];
            NSArray *salePriceCode = @[@"",@"0-1499900",@"1500000-2000000",@"2000000-2500000",@"2500000-3500000",@"3500000-5000000",@"5000000-7000000",@"7000000-10000000",@"10000100-"];
            for (NSInteger i = 0 ; i< salePriceCode.count; i++) {
                [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected isSelected:(i==0 ? YES : NO)
                                                  titleName:salePriceTitle[i]
                                               subtitleName:nil
                                                       code:salePriceCode[i]]];
            }
        }
            break;
        default:
            break;
    }

    // 户型
    NSArray *houseTitle = @[@"全部",@"一室",@"二室",@"三室",@"四室",@"五室",@"五室以上"];
    NSArray *houseCode = @[@"",@"1",@"2",@"3",@"4",@"5",@"6"];
    for (NSInteger i =0 ; i< houseCode.count; i++) {
        [rootItem4 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected isSelected:(i==0 ? YES : NO)
                                          titleName:houseTitle[i]
                                       subtitleName:nil
                                               code:houseCode[i]]];
    }
    
    
    
    [dataArray addObject:rootItem1];
    [dataArray addObject:rootItem2];
    [dataArray addObject:rootItem4];
    [dataArray addObject:rootItem5];

    return dataArray;
}


@end
