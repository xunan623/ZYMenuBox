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

@interface ZYMenuView()<ZYDropDownViewDelegate, ZYPopupViewDelegate>

@property (strong, nonatomic) NSMutableArray <ZYDropDownView *> *dropDownViewArray;
@property (strong, nonatomic) NSMutableArray <ZYItem *> *itemArray;
/** 当成一个队列来标记哪个弹出视图 */
@property (strong, nonatomic) NSMutableArray <ZYBasePopupView *> *symbolArray;

@property (nonatomic, strong) ZYBasePopupView *popupView;
@property (nonatomic, assign) BOOL isAnimation;                               /*防止多次快速点击**/

@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;


@end

@implementation ZYMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dropDownViewArray = [NSMutableArray array];
        self.itemArray = [NSMutableArray array];
        self.symbolArray = [NSMutableArray array];
    }
    return self;
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
    [self _addLine];
}

- (void)dimissPopView {
    if (self.popupView.superview) {
        [self.popupView dismissWithOutAnimation];
    }
}

#pragma mark - Private Method
- (void)_addLine {
    self.topLine = [CALayer layer];
    self.topLine.frame = CGRectMake(0, 0 , self.width, 1.0/scale);
    self.topLine.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3].CGColor;
    [self.layer addSublayer:self.topLine];
    
    self.bottomLine = [CALayer layer];
    self.bottomLine.frame = CGRectMake(0, self.height - 1.0/scale , self.width, 1.0/scale);
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"].CGColor;
    [self.layer addSublayer:self.bottomLine];
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
        
    }else{
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
    }
}

#pragma mark - ZYPopupViewDelegate
- (void)popupView:(ZYBasePopupView *)popupView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    ZYItem *item = self.itemArray[index];
    //混合类型不做UI赋值操作 直接将item的路径回调回去就好了
    if (item.displayType == ZYPopupViewDisplayTypeMultilayer || item.displayType == ZYPopupViewDisplayTypeNormal) {
        //拼接选择项
        NSMutableString *title = [NSMutableString string];
        for (int i = 0; i <array.count; i++) {
            ZYSelectedPath *path = array[i];
            [title appendString:i?[NSString stringWithFormat:@";%@",[item findTitleBySelectedPath:path]]:[item findTitleBySelectedPath:path]];
        }
        ZYDropDownView *box = self.dropDownViewArray[index];
        //UI赋值操作
        [box updateTitleContent:title];
    };
    
    if ([self.delegate respondsToSelector:@selector(popupView:didSelectedItemsPackagingInArray:atIndex:)]) {
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
