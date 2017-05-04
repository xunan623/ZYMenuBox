//
//  ZYMenuResultView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/28.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYMenuResultView.h"
#import "ZYItem.h"
#import "ZYMenuHeader.h"
#import "ZYDropDownView.h"
#import "ZYMenuTagViewBtn.h"
#import "ZYNumberStringTool.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define TAGVIEW_TOP_MARGIN 10.f

@interface ZYMenuResultView()

@property (nonatomic, strong) NSMutableArray *itemsPathArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) CGRect previousFrame;
@property (nonatomic, assign) NSInteger totalHeight;
@property (nonatomic, strong) ZYMenuTagViewBtn *tagBtn;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, assign) NSInteger zeroLinePage;

@end

@implementation ZYMenuResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.totalHeight = 0;
        self.zeroLinePage = 0;
        self.frame = frame;
        [self addSubview:self.centerView];
        
    }
    return self;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
    }
    return _centerView;
}

- (NSMutableArray *)itemsPathArray {
    if (!_itemsPathArray) {
        _itemsPathArray = [NSMutableArray array];
    }
    return _itemsPathArray;
}

- (void)setupWithArray:(NSMutableArray *)array withIndex:(NSInteger)index dataArray:(NSMutableArray *)dataArray {
    self.dataArray = dataArray;
    
    ZYItem *rootItem = self.dataArray[index];
    NSLog(@"%@", rootItem);
    switch (rootItem.displayType) {
        case ZYPopupViewDisplayTypeNormal:
        case ZYPopupViewDisplayTypeMultilayer:{
            [self fliterPathWithDict:@{@(index) : array}];
            break;}
        case ZYPopupViewDisplayTypeFilters:{
            
            [array enumerateObjectsUsingBlock:^(NSMutableArray *subArray, NSUInteger  idx, BOOL *stop) {
                for (ZYSelectedPath *path in subArray) {
                    ZYItem *firstItem = rootItem.childrenNodes[path.firstPath];
                    [self fliterPathWithDict:@{firstItem.title : subArray}];
                }
            }];
            
            break;}
        default:
            break;
    }
    NSLog(@"%@---", self.itemsPathArray);
    
    [self reloadTagView];

}

/** 刷新tagView */
- (void)reloadTagView {
    
    self.previousFrame = CGRectZero;
    self.totalHeight = 0.0;
    self.zeroLinePage = 0.0;
    for (UIButton *btn in self.subviews) {
        [btn removeFromSuperview];
    }
    self.height = self.totalHeight;
    
    for (NSInteger i = 0; i < self.itemsPathArray.count; i++) {
        NSDictionary *keyPath = self.itemsPathArray[i];
        [keyPath enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *keyPathArray, BOOL *stop) {
            NSLog(@"%@--%@", key, keyPath);
            if ([ZYNumberStringTool zy_IsPureInt:[NSString stringWithFormat:@"%@",key]]) { // 纯数字
                ZYItem *keyItem = self.dataArray[[key integerValue]];
                for (NSInteger j = 0; j < keyPathArray.count; j++) {
                    ZYSelectedPath *keyPath = keyPathArray[j];
#pragma mark - TODO 这里是选中默认的功能 这里要返回到接口中清除请求参数
                    if (keyPath.firstPath == 0) {
                        break;
                    }
                    [self setupBtnWithNSString:[keyItem findTitleBySelectedPath:keyPath]
                                      withItem:keyItem
                                         index:[key integerValue]
                                          keyPath:keyPath];
                }
            } else {
                ZYItem *keyItem = self.dataArray[4];
                for (NSInteger j = 0; j < keyPathArray.count; j++) {
                    ZYSelectedPath *keyPath = keyPathArray[j];
                    ZYItem *secondItem = keyItem.childrenNodes[keyPath.firstPath].childrenNodes[keyPath.secondPath];
                    [self setupBtnWithNSString:secondItem.title
                                      withItem:keyItem
                                         index:4
                                       keyPath:keyPath];
                }
            }
            
        }];
    }
}

/** 保存的数组中是否有当前点击的path */
- (void)fliterPathWithDict:(NSDictionary *)dict {
    NSNumber *pathKey = [dict.allKeys objectAtIndex:0];
    NSMutableArray *dictArr = [[dict.allValues objectAtIndex:0] mutableCopy];
    if (self.itemsPathArray.count) {

        NSInteger j = 0;
        for (NSInteger i = 0; i< self.itemsPathArray.count; i++) {
            NSMutableDictionary *itemDict = self.itemsPathArray[i];
            NSMutableDictionary *itemDicts =  [itemDict mutableCopy];
            if ([itemDicts.allKeys containsObject:pathKey]) { // 如果保存的数组中有当前的key

                NSMutableArray *tmpItemArr = [NSMutableArray arrayWithCapacity:0];

                tmpItemArr = [itemDict[pathKey] mutableCopy];

                [tmpItemArr removeAllObjects];
                for (NSInteger k =0; k < dictArr.count; k++) {
                    [tmpItemArr addObject:dictArr[k]];
                }

                [itemDicts setObject:tmpItemArr forKey:pathKey];
                [self.itemsPathArray removeObjectAtIndex:i];
                [self.itemsPathArray addObject:itemDicts];
            } else {
                j ++;
            }
            if (j == self.itemsPathArray.count) {
                [self.itemsPathArray addObject:dict];
            }
        }
    } else {
        [self.itemsPathArray addObject:dict];
    }
}


- (void)setupBtnWithNSString:(NSString *)title withItem:(ZYItem *)item index:(NSInteger)index keyPath:(ZYSelectedPath *)keyPath {
    //初始化按钮
    self.tagBtn = [[ZYMenuTagViewBtn alloc] init];
    self.tagBtn.item = item;
    self.tagBtn.keyPath = keyPath;
    self.tagBtn.index = index;
    [self.tagBtn setTitle:title forState:UIControlStateNormal];
    
    //设置方法
    [self.tagBtn addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:MenuResultViewTagFontSize]};
    CGSize StrSize = [title sizeWithAttributes:attribute];
    StrSize.width += HORIZONTAL_PADDING  * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    
    if (self.previousFrame.origin.x + self.previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        
        NewRect.origin = CGPointMake(10, self.previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN ;
        self.zeroLinePage ++;
    }else {
        NewRect.origin = CGPointMake(self.previousFrame.origin.x + self.previousFrame.size.width + LABEL_MARGIN, self.zeroLinePage ==0 ? 10 : self.previousFrame.origin.y);
    }
    NewRect.size = StrSize;
    [self.tagBtn setFrame:NewRect];
    self.previousFrame = self.tagBtn.frame;
    
    self.height = self.totalHeight + StrSize.height + BOTTOM_MARGIN + TAGVIEW_TOP_MARGIN;
    
    CGFloat interval = 1.0;
    self.tagBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(self.tagBtn.imageView.bounds.size.width + interval), 0, self.tagBtn.imageView.bounds.size.width + interval);
    self.tagBtn.imageEdgeInsets = UIEdgeInsetsMake(0,self.tagBtn.titleLabel.bounds.size.width + interval, 0, -(self.tagBtn.titleLabel.bounds.size.width + interval));

    [self addSubview:self.tagBtn];
    
    
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

#pragma mark - 按钮的处理方法

- (void)clickHandle:(ZYMenuTagViewBtn *)sender{
    ZYMenuTagViewBtn *btn = (ZYMenuTagViewBtn *)sender;
    
    if (btn.index == 4) {
        ZYItem *keyItem = self.dataArray[btn.index];
        ZYItem *secondItem = keyItem.childrenNodes[btn.keyPath.firstPath].childrenNodes[btn.keyPath.secondPath];
        secondItem.isSelected = NO;
        ZYItem *firstItem = keyItem.childrenNodes[btn.keyPath.firstPath];

        for (NSInteger i = 0; i< self.itemsPathArray.count; i++) {
            NSDictionary *dict = self.itemsPathArray[i];
            [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray *value, BOOL *stop) {
                NSLog(@"key:%@-vaule:%@", key, value);
                if ([[NSString stringWithFormat:@"%@", key ] isEqualToString:firstItem.title]) {
                    [value enumerateObjectsUsingBlock:^(ZYSelectedPath *selectedsPath, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (selectedsPath == btn.keyPath) {
                            [value removeObject:selectedsPath];
                            *stop = YES;
                        }
                    }];
                }
            
            }];
        }
    } else {
        // 删除数据源
        for (NSInteger i = 0; i< self.itemsPathArray.count; i++) {
            NSDictionary *dict = self.itemsPathArray[i];
            [dict enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSMutableArray *value, BOOL *stop) {
                if ([key isEqual:@(btn.index)]) {
                    [self.itemsPathArray removeObject:dict];
                }
            }];
        }
   
        ZYItem *rootItem = self.dataArray[btn.index];
        
        for (ZYItem *item in self.dataArray) {
            if (item == rootItem) {
                item.title = rootItem.title;
                switch (item.displayType) {
                    case ZYPopupViewDisplayTypeNormal: {
                        for (NSInteger i =0; i<item.childrenNodes.count; i++) {
                            ZYItem *subItem = item.childrenNodes[i];
                            subItem.isSelected = (i==0) ? YES : NO;
                        }
                        break;}
                    case ZYPopupViewDisplayTypeMultilayer:{
                        
                        for (NSInteger i =0; i<item.childrenNodes.count; i++) {
                            ZYItem *item_A = item.childrenNodes[i];
                            item_A.isSelected = (i==0);
                            for (NSInteger j =0; j < item_A.childrenNodes.count; j++) {
                                ZYItem *subItemB = item_A.childrenNodes[j];
                                subItemB.isSelected = NO;
                            }
                            for (NSInteger k =0; k< item_A.childrenNodes.count; k++) {
                                ZYItem *item = item_A.childrenNodes[k];
                                item.isSelected = (i == 0 && k ==0);
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

    }
  
    [self reloadTagView];

    if ([self.delegate respondsToSelector:@selector(didSelectedTagView)]) {
        [self.delegate didSelectedTagView];
    }
}


@end
