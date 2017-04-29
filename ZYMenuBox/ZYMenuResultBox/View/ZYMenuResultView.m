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

#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING   3.0f
#define LABEL_MARGIN       10.0f
#define BOTTOM_MARGIN      10.0f
#define TAGVIEW_TOP_MARGIN 10.f

@interface ZYMenuResultView()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, assign) CGRect previousFrame;
@property (nonatomic, assign) NSInteger totalHeight;
@property (nonatomic, strong) UIButton *tagBtn;

@property (nonatomic, strong) UIView *centerView;

@end

@implementation ZYMenuResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.totalHeight = 0;
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
    
    [self.itemsArray enumerateObjectsUsingBlock:^(ZYItem *item, NSUInteger idx, BOOL *stop) {
        [self setupBtnWithNSString:item];
    }];
}

- (void)setupBtnWithNSString:(ZYItem *)item {
    //初始化按钮
    self.tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tagBtn.backgroundColor = [UIColor whiteColor];
    self.tagBtn.frame = CGRectZero;

    //设置内容水平居中
    self.tagBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.tagBtn setTitle:item.title forState:UIControlStateNormal];
    //设置字体的大小
    self.tagBtn.titleLabel.font = [UIFont systemFontOfSize:MenuResultViewTagFontSize];
    [self.tagBtn setBackgroundColor:[UIColor whiteColor]];
    [self.tagBtn setTitleColor:[UIColor colorWithHexString:MenuResultViewTagColor] forState:UIControlStateNormal];
    //设置方法
    [self.tagBtn addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:MenuResultViewTagFontSize]};
    CGSize StrSize = [item.title sizeWithAttributes:attribute];
    StrSize.width += HORIZONTAL_PADDING * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    if (self.previousFrame.origin.x + self.previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        
        NewRect.origin = CGPointMake(10, self.previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN;
    }else {
        NewRect.origin = CGPointMake(self.previousFrame.origin.x + self.previousFrame.size.width + LABEL_MARGIN, self.previousFrame.origin.y);
    }
    NewRect.size = StrSize;
    [self.tagBtn setFrame:NewRect];
    self.previousFrame = self.tagBtn.frame;
    
    self.height = self.totalHeight + StrSize.height + BOTTOM_MARGIN;
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
