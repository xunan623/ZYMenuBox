//
//  ZYCombinationFitlerView.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYCombinationFitlerView.h"
#import "ZYCombinationCell.h"
#import "ZYCombTextFieldCell.h"

#define CLEAR_TopMarin 5.0f
#define CLEAR_ButtonWidth 100.0f

@interface ZYCombinationFitlerView()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, ZYCombinationCellDelegate, ZYCombTextFieldCellDelegate>

@property (strong, nonatomic) UIView *bottomView;

/** 判断是否要将数据回归到temporaryArray状态 */
@property (nonatomic, assign) BOOL isSuccessfulToCallBack;

@end

@implementation ZYCombinationFitlerView

- (id)initWithItem:(ZYItem *)item {
    if (self = [super init]) {
        self.item = (ZYCombinationItem *)item;
        
        // 遍历ZYItems选项
        for (NSInteger i =0; i < self.item.childrenNodes.count; i++) {
            ZYItem *subItem = item.childrenNodes[i];
            NSMutableArray *itemsArray = [NSMutableArray array];
            for (NSInteger j = 0; j < subItem.childrenNodes.count; j++) {
                ZYItem *secondItem = subItem.childrenNodes[j];
                if (secondItem.isSelected == YES) {
                    [itemsArray addObject:[ZYSelectedPath pathWithFirstPath:i secondPath:j]];
                }
            }
            [self.selectedArray addObject:itemsArray];
        }
        self.temporaryArray = [[NSArray alloc] initWithArray:self.selectedArray copyItems:YES];
    }
    return self;
}

#pragma mark - Private Method
- (void)popupViewFromSourceFrame:(CGRect)frame completion:(void (^)())completion {
    UIView *rootView = [[UIApplication sharedApplication] keyWindow];
    self.sourceFrame = frame;
    CGFloat top = CGRectGetMaxY(self.sourceFrame) + DropDownBoxViewTopMargin;
    CGFloat resultHeight = kScreenHeigth - top - PopupViewTabBarHeight;
    self.frame = CGRectMake(0, top, kScreenWidth, 0);
    [rootView addSubview:self];
    
    // 添加tableView
    [self addSubview:[self viewWithTableView]];
    
    // 背景视图
    self.shadowView.frame = CGRectMake(0, top, kScreenWidth, kScreenHeigth - top);
    self.shadowView.alpha = 0.0;
    self.shadowView.userInteractionEnabled = YES;
    [rootView insertSubview:self.shadowView belowSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapGestureRecognizer:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.shadowView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, resultHeight);
        self.mainTableView.frame = self.bounds;
        self.shadowView.alpha = ShadowAlpha;
    }completion:^(BOOL finished) {
        completion();
        self.height += PopupViewTabBarHeight;
        
        // 底部按钮
        [self addSubview:self.bottomView];
        
        [self setupSubmitButton];
    }];
}

- (void)setupSubmitButton {
    NSArray *titleArray = @[@"清除", @"确定"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIColor *titleColor = ((i == 0)?[UIColor colorWithHexString:DropDownBoxViewClearButtonColor]:[UIColor colorWithHexString:titleSelectedColor]);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:DropDownBoxViewCombinaSubmitFont];
        if (i == 0) {
            button.frame = CGRectMake(ButtonHorizontalMargin, CLEAR_TopMarin, CLEAR_ButtonWidth, PopupViewTabBarHeight - 2 * CLEAR_TopMarin);
            button.layer.borderColor = [UIColor colorWithHexString:CombinationSelectedColor].CGColor;
            button.layer.borderWidth = 1.f / scale;
        }
        if (i == 1) {
            button.frame = CGRectMake(ButtonHorizontalMargin + CLEAR_ButtonWidth + ButtonHorizontalMargin, CLEAR_TopMarin, self.width - 3 * ButtonHorizontalMargin - CLEAR_ButtonWidth, PopupViewTabBarHeight - 2 * CLEAR_TopMarin);
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithHexString:CombinationSelectedColor];
        }
        button.layer.cornerRadius = 4.0f;
        [button addTarget:self action:@selector(respondsToButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
        
    }
}

#pragma mark - Getting & Setting

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithHexString:CombinationBottomBGColor];
        _bottomView.frame = CGRectMake(0, self.mainTableView.bottom, self.width, PopupViewTabBarHeight);
        _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        _bottomView.layer.shadowOffset = CGSizeMake(3,0);
        _bottomView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
        _bottomView.layer.shadowRadius = 4;//阴影半径，默认3
    }
    return _bottomView;
}

- (UITableView *)viewWithTableView {
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    UITapGestureRecognizer *tapTableView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView:)];
    [self.mainTableView addGestureRecognizer:tapTableView];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView:)];
    swipeGesture.direction=UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp;
    
    swipeGesture.delegate=self;
    [self.mainTableView addGestureRecognizer:swipeGesture];
    
    [self.mainTableView registerClass:[ZYCombTextFieldCell class] forCellReuseIdentifier:TextFieldCellID];
    [self.mainTableView registerClass:[ZYCombinationCell class] forCellReuseIdentifier:MainCellID];
    return self.mainTableView;
}

- (void)dismiss {
    [super dismiss];
    
    if ([self.delegate respondsToSelector:@selector(popupViewWillDismiss:)]) {
        [self.delegate popupViewWillDismiss:self];
    }
    
    // 根据isSuccessfulToCallBack字段判断是否要将数据回归到temporaryArray状态
    [self _recoverToTheOriginalState];
    
    self.bottomView.hidden = YES;
    CGFloat top = CGRectGetMaxY(self.sourceFrame);
    // 消失的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.frame = CGRectMake(0, top, kScreenWidth, 0);
        self.mainTableView.frame = self.bounds;
        self.shadowView.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Private Method

- (void)_recoverToTheOriginalState {
    if (self.isSuccessfulToCallBack == NO) {
        // 选中的item清理
        [self _clearItemsStateOfSelectedArray];
        
        [self.temporaryArray enumerateObjectsUsingBlock:^(NSMutableArray *subArray, NSUInteger idx, BOOL * _Nonnull stop) {
            for (ZYSelectedPath *selectedPath in subArray) {
                ZYItem *lastItem = self.item.childrenNodes[selectedPath.firstPath].childrenNodes[selectedPath.secondPath];
                lastItem.isSelected = YES;
            }
        }];
    }
}

- (NSInteger)_indexOfSelectedArrayByPath:(ZYSelectedPath *)path {
    return path.firstPath;;
}
/** 是否包含已选中的Item */
- (BOOL)_iscontainsSelectedPath:(ZYSelectedPath *)path sourceArray:(NSMutableArray *)array {
    for (ZYSelectedPath *selectedPath in array) {
        if (selectedPath.firstPath == path.firstPath && selectedPath.secondPath == path.secondPath) return YES;
    }
    return NO;
}

/** 删除Item */
- (ZYSelectedPath *)_removePath:(ZYSelectedPath *)path sourceArray:(NSMutableArray *)array {
    
    for (ZYSelectedPath *selectedpath in array) {
        if (selectedpath.firstPath == path.firstPath && selectedpath.secondPath == path.secondPath &&selectedpath.isKindOfAlternative == NO ) {
            ZYSelectedPath *returnPath = selectedpath;
            [array removeObject:selectedpath];
            return returnPath;
        }
    }
    return nil;
}
/** 清除数据模型 */
- (void)_clearItemsStateOfSelectedArray {
    [self.selectedArray enumerateObjectsUsingBlock:^(NSMutableArray *subArray , NSUInteger idx, BOOL * _Nonnull stop) {
        
        for (ZYSelectedPath *selectedPath in subArray) {
            ZYItem *lastItem = self.item.childrenNodes[selectedPath.firstPath].childrenNodes[selectedPath.secondPath];
            lastItem.isSelected = NO;
        }
        [subArray removeAllObjects];
    }];
}

// 重置
- (void)_resetValue {
    [self _clearItemsStateOfSelectedArray];
//    [self.temporaryArray enumerateObjectsUsingBlock:^(NSMutableArray *subArray, NSUInteger idx, BOOL * _Nonnull stop) {
//        ZYSelectedPath *resetPath = [ZYSelectedPath pathWithFirstPath:idx secondPath:0];
//        ZYItem *lastItem = self.item.childrenNodes[resetPath.firstPath].childrenNodes[resetPath.secondPath];
//        lastItem.isSelected = YES;
//        if (idx != self.temporaryArray.count -1) {
//            [self.selectedArray[idx] addObject:resetPath];
//        } else {
//            
//            // 清除
//            for (NSInteger i = 0; i< 2; i++) {
//                ZYSelectedPath *resetPath = [ZYSelectedPath pathWithFirstPath:idx secondPath:i];
//                ZYItem *lastItem = self.item.childrenNodes[resetPath.firstPath].childrenNodes[resetPath.secondPath];
//                lastItem.isSelected = NO;
//                lastItem.title = @"";
//            }
//        }
//        
//    }];
    [self.mainTableView reloadData];
}



#pragma mark - Action

- (void)tapTableView:(id)gestue {
    [self endEditing:YES];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer{
    return YES;
}

- (void)respondsToTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self dismiss];
}


- (void)respondsToButtonAction:(UIButton *)sender {
    [self endEditing:YES];
    if (sender.tag == 0) { // 重置
        [self _resetValue];
    }
    else if (sender.tag == 1) { // 确定
        [self callBackDelegate];
    }
}

#pragma mark - Public Method
- (void)callBackDelegate {
    if ([self.delegate respondsToSelector:@selector(popupView:didSelectedItemsPackagingInArray:atIndex:)]) {
        self.isSuccessfulToCallBack = YES;
        [self.delegate popupView:self didSelectedItemsPackagingInArray:self.selectedArray atIndex:self.tag];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
            self.isSuccessfulToCallBack = NO;
        });
    }
}

#pragma mark - UItableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.childrenNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYItem *item = self.item.childrenNodes[indexPath.row];
    if (item.selectedType == ZYPopupViewInputViewSelection) { // 输入框
        ZYCombTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellID forIndexPath:indexPath];
        cell.item = self.item.childrenNodes[indexPath.row];
        cell.delegate = self;
        return cell;
    } else { // 单选多选
        ZYCombinationCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID forIndexPath:indexPath];
        cell.item = self.item.childrenNodes[indexPath.row];
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.item.combinationLayout.cellLayoutTotalHeight[indexPath.row] floatValue];
}


#pragma mark - ZYCombinationCellDelegate

- (void)combineCell:(ZYCombinationCell *)combineCell didSelectedAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:combineCell];
    NSInteger indexOfSelectedArray = [self _indexOfSelectedArrayByPath:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index]];
    NSMutableArray *itemArray = self.selectedArray[indexOfSelectedArray];
    
    switch (self.item.selectedType) {
        case ZYPopupViewSingleSelection: { // 单选处理
            if ([self _iscontainsSelectedPath:[ZYSelectedPath pathWithFirstPath:indexPath.row
                                                                     secondPath:index]
                                                                    sourceArray:itemArray] && itemArray.count == 1) return; // 包含
            ZYSelectedPath *removeIndexPath = [itemArray lastObject];
            [itemArray removeAllObjects];
            self.item.childrenNodes[removeIndexPath.firstPath].childrenNodes[removeIndexPath.secondPath].isSelected = NO;
            [itemArray addObject:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index]];
            self.item.childrenNodes[indexPath.row].childrenNodes[index].isSelected = YES;
        }
            break;
        case ZYPopupViewMultilSeMultiSelection: { // 多选处理
            if ([self _iscontainsSelectedPath:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index] sourceArray:itemArray]) {
                if (itemArray.count == 1) return;
                ZYSelectedPath *removeIndexPath = [self _removePath:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index] sourceArray:itemArray];
                self.item.childrenNodes[removeIndexPath.firstPath].childrenNodes[removeIndexPath.secondPath].isSelected = NO;
            }else {
                self.item.childrenNodes[indexPath.row].childrenNodes[index].isSelected = YES;
                [itemArray addObject:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index]];
            }
        }
            break;
        default:
            break;
    }
    [self.mainTableView reloadData];
}

#pragma mark - ZYCombTextFieldCellDelegate

- (void)comTextFieldCell:(ZYCombTextFieldCell *)cell changeTextField:(UITextField *)textField {
    [self.mainTableView setContentOffset:CGPointMake(0, self.mainTableView.contentSize.height -self.mainTableView.height) animated:YES];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    // 输入框会在index为last的数组里面
    NSMutableArray *itemArray = self.selectedArray.lastObject;
    NSInteger index = textField.tag / 100;
    NSLog(@"%@, %zd", itemArray, index);
    
    if ([self _iscontainsSelectedPath:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index] sourceArray:itemArray]) {
        if (itemArray.count == 1) return;
        ZYSelectedPath *removeIndexPath = [self _removePath:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index] sourceArray:itemArray];
        self.item.childrenNodes[removeIndexPath.firstPath].childrenNodes[removeIndexPath.secondPath].isSelected = NO;
        self.item.childrenNodes[removeIndexPath.firstPath].childrenNodes[removeIndexPath.secondPath].title = textField.text;

    }else {
        self.item.childrenNodes[indexPath.row].childrenNodes[index].isSelected = YES;
        self.item.childrenNodes[indexPath.row].childrenNodes[index].title = textField.text;
        [itemArray addObject:[ZYSelectedPath pathWithFirstPath:indexPath.row secondPath:index]];
    }
}
- (void)comTextFieldCell:(ZYCombTextFieldCell *)cell beginEdited:(UITextField *)textField {
    [self.mainTableView setContentOffset:CGPointMake(0, 250) animated:YES];

}

@end
