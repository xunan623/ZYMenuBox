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
#import "ZYMenuResultView.h"
#import "ZYMenuHeader.h"

@interface ViewController () <ZYMenuViewDelegate, ZYMenuViewDataSource, ZYMenuResultViewDelegate>

@property (strong, nonatomic) ZYMenuView *menuListView;
@property (strong, nonatomic) ZYMenuResultView *resultView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *bottomView;

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

- (ZYMenuResultView *)resultView {
    if (!_resultView) {
        _resultView = [[ZYMenuResultView alloc] init];
        _resultView.frame = CGRectMake(0, CGRectGetMaxY(self.menuListView.frame) + 5, kScreenWidth, 0);
        _resultView.bgColor = [UIColor colorWithHexString:MenuResultBgColor];
        _resultView.delegate = self;
    }
    return _resultView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.resultView.frame), kScreenWidth, 200)];
        _bottomView.backgroundColor = [UIColor redColor];
    }
    return _bottomView;
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
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.bottomView];
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

    [self.resultView setupWithArray:array withIndex:index dataArray:self.dataArray];
    
    self.bottomView.top = CGRectGetMaxY(self.resultView.frame);
    
}

#pragma mark - ZYMenuResultViewDelegate

- (void)didSelectedTagView {

    // 刷新标题
    [self.menuListView reloadTitle];
    
    self.bottomView.top = CGRectGetMaxY(self.resultView.frame);
}

- (void)resultViewFilterParams:(ZYMenuParamsModel *)model {
    NSLog(@"区域:(城区:%@ 片区:%@ 小区域:%@), 价格:%@, 户型:%@, 标签:%@, 面积:%@, 朝向:%@ 楼底层:%@", model.cityCode, model.districtcode, model.areaCode, model.priceCode, model.houseType, model.tagCode, model.acreageCode, model.directionCode, model.floorCode );

}

@end
