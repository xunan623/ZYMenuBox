//
//  ZYMenuView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuView.h"
#import "ZYDropDownView.h"
#import "ZYMenuHeader.h"
#import "ZYBasePopupView.h"
#import "ZYSelectedPath.h"
#import "ZYCombinationItem.h"

// 这是[_ _ _ _]
@interface ZYMenuView()<ZYDropDownViewDelegate, ZYPopupViewDelegate>

@property (strong, nonatomic) NSMutableArray <ZYDropDownView *> *dropDownViewArray;
@property (strong, nonatomic) NSMutableArray <ZYItem *> *itemArray;
/** 当成一个队列来标记哪个弹出视图 */
@property (strong, nonatomic) NSMutableArray <ZYBasePopupView *> *symbolArray;

@property (nonatomic, strong) ZYBasePopupView *popupView;
@property (nonatomic, assign) BOOL isAnimation;                               /*防止多次快速点击**/

@property (nonatomic, assign) NSInteger perviousIndex;          // 上一次点击

@property (nonatomic, strong) UIView *bottomLayer;

@end

@implementation ZYMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.1;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，默认3
        self.dropDownViewArray = [NSMutableArray array];
        self.itemArray = [NSMutableArray array];
        self.symbolArray = [NSMutableArray array];
        self.perviousIndex = -1;
    }
    return self;
}

- (void)reloadTitle {
    
    for (NSInteger i =0; i< self.dropDownViewArray.count; i++) {
        ZYDropDownView *dropMenu = self.dropDownViewArray[i];
        ZYItem *item = self.itemArray[i];
        switch (item.displayType) {
            case ZYPopupViewDisplayTypeNormal: {
                for (NSInteger j =0; j<item.childrenNodes.count; j++) {
                    ZYItem *subItem = item.childrenNodes[j];
                    if (j == 0 && subItem.isSelected == YES) {
                        [dropMenu updateTitleContent:item.title];
                        // 特殊处理 标题
                        [dropMenu updateTitleColor:NO];
                    }
                }
                break;}
            case ZYPopupViewDisplayTypeMultilayer:{
                for (NSInteger n =0; n<item.childrenNodes.count; n++) {
                    ZYItem *subItem = item.childrenNodes[n];
                    if (n== 0 && subItem.isSelected == YES) {
                        [dropMenu updateTitleContent:item.title];
                        // 特殊处理 标题
                        [dropMenu updateTitleColor:NO];
                    }
                }
                break;}
            case ZYPopupViewDisplayTypeFilters:{
                NSInteger count = 0;
                for (NSInteger n =0; n<item.childrenNodes.count; n++) {
                    ZYItem *subItem = item.childrenNodes[n];
                    for (NSInteger m = 0; m< subItem.childrenNodes.count; m++) {
                        ZYItem *mSubItem = subItem.childrenNodes[m];
                        if (mSubItem.isSelected == YES) {
                            count++;
                        }
                    }
                }
                if (count==0) [dropMenu updateTitleColor:NO];
                
                break;}
            default:
                break;
        }
    }

}

- (void)reload {
    NSInteger count = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInMenuView:)]) {
        count = [self.dataSource numberOfColumnsInMenuView:self];
    }
    
    CGFloat width = self.width / count;
    if ([self.dataSource respondsToSelector:@selector(menuView:menuForColumn:)]) {
        for (NSInteger i = 0; i < count; i++) {
            
            ZYItem *item = [self.dataSource menuView:self menuForColumn:i];
            if ([item isMemberOfClass:[ZYCombinationItem class]]) {
                [(ZYCombinationItem *)item addLayoutInformationWhenTypeFilters];
            }
            
            ZYDropDownView *dropMenu = [[ZYDropDownView alloc] initWithFrame:CGRectMake(i * width, 0, width, self.height)
                                                                   titleName:item.title];
            dropMenu.tag = i;
            dropMenu.delegate = self;
            [self addSubview:dropMenu];
            [self.dropDownViewArray addObject:dropMenu];
            [self.itemArray addObject:item];
        }
    }
}


- (void)dimissPopView {
    if (self.popupView.superview) {
        [self.popupView dismissWithOutAnimation];
    }
}

#pragma mark - ZYDropDownViewDelegate
- (void)didTapDropDownView:(ZYDropDownView *)dropDownView atIndex:(NSUInteger)index {
    if (self.isAnimation == YES) return;
    
    if (self.perviousIndex != -1) {
        if (self.perviousIndex == index) { // 当前点击和上次点击一样
//            for (int i = 0; i <self.dropDownViewArray.count; i++) {
//                ZYDropDownView *currentBox  = self.dropDownViewArray[i];
//                [currentBox updateTitleState:(i == index)];
//            }
            ZYBasePopupView * lastView = self.symbolArray[0];
            [lastView dismiss];
            [self.symbolArray removeAllObjects];
            
            self.perviousIndex = -1;
            return;
        } else {
            //点击后先判断symbolArray有没有标示
            //移除
            ZYBasePopupView * lastView = self.symbolArray[0];
            [lastView dismiss];
            [self.symbolArray removeAllObjects];
        }
    }
    
    for (int i = 0; i <self.dropDownViewArray.count; i++) {
        ZYDropDownView *currentBox  = self.dropDownViewArray[i];
        if (i == index) [currentBox updateTitleState:YES];
    }
    
    self.isAnimation = YES;
    ZYItem *item = self.itemArray[index];
    ZYBasePopupView *popupView = [ZYBasePopupView getSubPopupView:item];
    popupView.delegate = self;
    popupView.tag = index;
    self.popupView = popupView;
    [popupView popupViewFromSourceFrame:self.frame completion:^{
        self.isAnimation = NO;
    }];
    [self.symbolArray addObject:popupView];
    
    self.perviousIndex = index;

}


#pragma mark - ZYPopupViewDelegate
- (void)popupView:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    ZYItem *item = self.itemArray[index];
    
    switch (item.displayType) {
        case ZYPopupViewDisplayTypeMultilayer:
        case ZYPopupViewDisplayTypeNormal: {
            // 更新选项卡标题
            __block NSInteger selectedPath = -1;
            NSMutableString *title = [NSMutableString string];
            for (int i = 0; i <array.count; i++) {
                ZYSelectedPath *path = array[i];
                
                // 特殊处理 点击第二列第一条数据 显示第一列title
                if (index == 0 && path.secondPath == 0) {
                    [title appendString:item.childrenNodes[path.firstPath].title];
                } else {
                    [title appendString:i?[NSString stringWithFormat:@";%@",[item findTitleBySelectedPath:path]]:[item findTitleBySelectedPath:path]];
                }
                selectedPath = path.firstPath;
            }
            ZYDropDownView *box = self.dropDownViewArray[index];
            
            // UI赋值操作 其中如果是选中的第一个数据 则title 为默认值
            [box updateTitleContent:selectedPath == 0 ? item.title : title];

        }
            break;
        case ZYPopupViewDisplayTypeFilters: {     //混合类型不做UI赋值操作 直接将item的路径回调回去就好了
            __block NSInteger selectedPath = -1;
            __block NSString *title;
            [array enumerateObjectsUsingBlock:^(NSMutableArray *subArray, NSUInteger idx, BOOL *stop) {
                
                NSMutableString *subtitles = [NSMutableString string];
                for (ZYSelectedPath *path in subArray) {
                    ZYItem *firstItem = item.childrenNodes[path.firstPath];
                    ZYItem *secondItem = item.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                    selectedPath = path.firstPath;
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];

        }
            break;
        default:
            break;
    }
    

    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectedItemsPackagingInArray:atIndex:)]) {
        [self.delegate menuView:self didSelectedItemsPackagingInArray:array atIndex:index];
    }
    
    
    
}

- (void)popupViewWillDismiss:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index{
    self.perviousIndex = -1;
    [self.symbolArray removeAllObjects];
    
    ZYItem *item = self.itemArray[index];
    
    
    ZYDropDownView *currentBox = self.dropDownViewArray[index];
    [currentBox updateTitleState:NO];
    
    switch (item.displayType) {
        case ZYPopupViewDisplayTypeNormal: {
            // 更新选项卡标题
            __block NSInteger selectedPath = -1;
            for (int i = 0; i <array.count; i++) {
                ZYSelectedPath *path = array[i];
                selectedPath = path.firstPath;
            }
            ZYDropDownView *box = self.dropDownViewArray[index];
            
            // UI赋值操作 其中如果是选中的第一个数据 则title 为默认值
            [box updateTitleColor:selectedPath!=0];
            
        }
            break;
        case ZYPopupViewDisplayTypeMultilayer: {
            __block NSInteger secondSelectedPath = -2;
            __block NSInteger firstSelectedPath = -2;
            for (int i = 0; i <array.count; i++) {
                ZYSelectedPath *path = array[i];
                secondSelectedPath = path.secondPath;
                firstSelectedPath = path.firstPath;
                NSLog(@"%zd - %zd", firstSelectedPath, secondSelectedPath);
            }
            ZYDropDownView *box = self.dropDownViewArray[index];
            
            // UI赋值操作 其中如果是选中的第一个数据 则title 为默认值
            if (firstSelectedPath !=0) [box updateTitleColor:secondSelectedPath !=-2];
        }
            break;
        case ZYPopupViewDisplayTypeFilters: {     //混合类型不做UI赋值操作 直接将item的路径回调回去就好了
            __block NSInteger selectedPath = -1;
            [array enumerateObjectsUsingBlock:^(NSMutableArray *subArray, NSUInteger idx, BOOL *stop) {
                for (ZYSelectedPath *path in subArray) {
                    selectedPath = path.firstPath;
                }
            }];
            
            ZYDropDownView *box = self.dropDownViewArray[index];
            [box updateTitleColor:selectedPath!=-1];
        }
            break;
        default:
            break;
    }


    


}

@end
