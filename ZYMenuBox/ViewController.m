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
#import "ZYMenuDataSouce.h"

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
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuListView];
    self.dataArray = [ZYMenuDataSouce getDataArray:ZYMenuDataSouceTypeRent];
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
