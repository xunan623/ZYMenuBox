//
//  ViewController.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ViewController.h"
#import "ZYMenuView.h"
#import "ZYMenuBox.h"
#import "ZYItem.h"
#import "ZYSingleItem.h"

@interface ViewController () <ZYMenuViewDelegate, ZYMenuViewDataSource>

@property (strong, nonatomic) ZYMenuView *menuListView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController


- (ZYMenuView *)menuListView {
    if (!_menuListView) {
        _menuListView = [[ZYMenuView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
        _menuListView.dataSource = self;
        _menuListView.delegate = self;
    }
    return _menuListView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        ZYSingleItem *rootItem3 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"价格"];
        ZYSingleItem *rootItem1 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"区域"];
        ZYSingleItem *rootItem4 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"面积"];
        ZYSingleItem *rootItem5 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"户型"];

        ZYSingleItem *rootItem2 = [ZYSingleItem itemWithItemType:ZYPopupViewDisplayTypeUnselected titleName:@"排序"];
        [rootItem2  addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected isSelected:YES titleName:@"排序" subtitleName:nil code:nil]];
        [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"智能排序"]]];
        [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"离我最近"]]];
        [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"好评优先"]]];
        [rootItem2 addNode:[ZYItem itemWithItemType:ZYPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"人气最高"]]];

        
        [_dataArray addObject:rootItem1];
        [_dataArray addObject:rootItem2];
        [_dataArray addObject:rootItem3];
        [_dataArray addObject:rootItem4];
        [_dataArray addObject:rootItem5];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuListView];
    [self.menuListView reload];
}

#pragma mark - ZYMenuViewDelegate, ZYMenuViewDataSource

- (NSInteger)numberOfColumnsInMenuView:(ZYMenuView *)menuView {
    return self.dataArray.count;
}

- (ZYItem *)menuView:(ZYMenuView *)menuView menuForColumn:(NSInteger)column {
    return self.dataArray[column];
}

- (void)menuView:(ZYMenuView *)menuView didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSInteger)index {
    ZYItem *rootItem = self.dataArray[index];
    NSLog(@"%@", rootItem);
}



@end
