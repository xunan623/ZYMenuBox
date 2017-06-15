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
                    }
                }
                break;}
            case ZYPopupViewDisplayTypeMultilayer:{
                for (NSInteger n =0; n<item.childrenNodes.count; n++) {
                    ZYItem *subItem = item.childrenNodes[n];
                    if (n== 0 && subItem.isSelected == YES) {
                        [dropMenu updateTitleContent:item.title];
                    }
                }
                break;}
            case ZYPopupViewDisplayTypeFilters:{
                
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
    for (int i = 0; i <self.dropDownViewArray.count; i++) {
        ZYDropDownView *currentBox  = self.dropDownViewArray[i];
        [currentBox updateTitleState:(i == index)];
    }
    //点击后先判断symbolArray有没有标示
    if (self.symbolArray.count) {
        //移除
        ZYBasePopupView * lastView = self.symbolArray[0];
        [lastView dismiss];
        [self.symbolArray removeAllObjects];
    }
//    }else{ // 当前选项卡打开的状态下 是否重新打开另外一个选项卡
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
//    }
}

#pragma mark - ZYPopupViewDelegate
- (void)popupView:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    ZYItem *item = self.itemArray[index];
    //混合类型不做UI赋值操作 直接将item的路径回调回去就好了
    if (item.displayType == ZYPopupViewDisplayTypeMultilayer || item.displayType == ZYPopupViewDisplayTypeNormal) {
        // 更新选项卡标题
        __block NSInteger selectedPath = -1;
        NSMutableString *title = [NSMutableString string];
        for (int i = 0; i <array.count; i++) {
            ZYSelectedPath *path = array[i];
            [title appendString:i?[NSString stringWithFormat:@";%@",[item findTitleBySelectedPath:path]]:[item findTitleBySelectedPath:path]];
            selectedPath = path.firstPath;
        }
        ZYDropDownView *box = self.dropDownViewArray[index];
        
        // UI赋值操作 其中如果是选中的第一个数据 则title 为默认值
        if (selectedPath == 0) {
            [box updateTitleContent:item.title];
        } else {
            [box updateTitleContent:title];
        }
    };
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectedItemsPackagingInArray:atIndex:)]) {
        [self.delegate menuView:self didSelectedItemsPackagingInArray:array atIndex:index];
    }
}

- (void)popupViewWillDismiss:(ZYBasePopupView *)popupView {
    [self.symbolArray removeAllObjects];
    for (ZYDropDownView *currentBox in self.dropDownViewArray) {
        [currentBox updateTitleState:NO];
    }
}

@end
