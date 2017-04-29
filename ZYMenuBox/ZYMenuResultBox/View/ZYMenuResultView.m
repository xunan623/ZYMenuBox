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
#import "ZYMenuTagViewBtn.h"

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define TAGVIEW_TOP_MARGIN 10.f

@interface ZYMenuResultView()

@property (nonatomic, strong) NSMutableArray *itemsArray;

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

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)setupWithArray:(NSMutableArray *)array withIndex:(NSInteger)index {
    
    self.previousFrame = CGRectZero;
    self.totalHeight = 0.0;
    self.zeroLinePage = 0.0;
    
    
    ZYItem *rootItem = array[index];
    
    NSLog(@"%@", rootItem);
    switch (rootItem.displayType) {
        case ZYPopupViewDisplayTypeNormal:
        case ZYPopupViewDisplayTypeMultilayer:{
            //拼接选择项
//            NSMutableString *title = [NSMutableString string];
//            __block NSInteger firstPath;
//            [array enumerateObjectsUsingBlock:^(ZYSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
//                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
//                if (idx == 0) {
//                    firstPath = path.firstPath;
//                }
//            }];
//            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            [self.itemsArray addObject:rootItem];
            break;}
        case ZYPopupViewDisplayTypeFilters:{
            
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (rootItem.selectedType == ZYPopupViewInputViewSelection && idx == subArray.count -1) {
                    for (ZYSelectedPath *path in subArray) {
                        ZYItem *firstItem = rootItem.childrenNodes[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",firstItem.title,firstItem.isSelected);
                    }
                    [self.itemsArray addObject:rootItem];
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (ZYSelectedPath *path in subArray) {
                    ZYItem *firstItem = rootItem.childrenNodes[path.firstPath];
                    ZYItem *secondItem = rootItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@", secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
                [self.itemsArray addObject:rootItem];
            }];
            
            break;}
        default:
            break;
    }
    
    for (UIButton *btn in self.subviews) {
        [btn removeFromSuperview];
    }
    
    [self.itemsArray enumerateObjectsUsingBlock:^(ZYItem *item, NSUInteger idx, BOOL *stop) {
        [self setupBtnWithNSString:item];
    }];
}

- (void)setupBtnWithNSString:(ZYItem *)item {
    //初始化按钮
    self.tagBtn = [[ZYMenuTagViewBtn alloc] init];
    [self.tagBtn setTitle:item.title forState:UIControlStateNormal];
    
    //设置方法
    [self.tagBtn addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:MenuResultViewTagFontSize]};
    CGSize StrSize = [item.title sizeWithAttributes:attribute];
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

#pragma mark==========按钮的处理方法

///按钮的处理方法
- (void)clickHandle:(UIButton *)sender{
    NSLog(@"点击了，点解了");
}


@end