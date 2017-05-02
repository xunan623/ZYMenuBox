//
//  ZYItem.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYItem.h"

@implementation ZYItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.displayType = ZYPopupViewDisplayTypeNormal;
        self.childrenNodes = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                       titleName:(NSString *)title
                     subTileName:(NSString *)subTile{
    return [self itemWithItemType:type
                       isSelected:NO
                        titleName:title
                     subtitleName:subTile
                             code:nil];
}

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                       titleName:(NSString *)title {
    return [self itemWithItemType:type
                       isSelected:NO
                        titleName:title
                     subtitleName:nil
                             code:nil];
}

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                      isSelected:(BOOL)isSelected
                       titleName:(NSString *)title
                    subtitleName:(NSString *)subTile {
    return [self itemWithItemType:type
                       isSelected:isSelected
                        titleName:title
                     subtitleName:subTile
                             code:nil];
}

+ (instancetype)itemWithItemType:(ZYPopupViewMarkType)type
                      isSelected:(BOOL)isSelected
                       titleName:(NSString *)title
                    subtitleName:(NSString *)subtitle
                            code:(NSString *)code {
    
    ZYItem *item = [[[self class] alloc] init];
    item.markType = type;
    item.isSelected = isSelected;
    item.title = title;
    item.subTitle = subtitle;
    item.code = code;
    return item;
}

- (instancetype)initWithType:(ZYPopupViewMarkType)type
                  isSelected:(BOOL)isSelected
                   titleName:(NSString *)title
                subtitleName:(NSString *)subtitle
                        code:(NSString *)code {
    self = [self init];
    if (self) {
        self.markType = type;
        self.isSelected = isSelected;
        self.title = title;
        self.subTitle = subtitle;
        self.code = code;
    }
    return self;
}

#pragma mark - public method

- (void)addNode:(ZYItem *)node {
    NSParameterAssert(node);
    [self.childrenNodes addObject:node];
}

- (NSString *)findTitleBySelectedPath:(ZYSelectedPath *)selectedPath {
    if (selectedPath.thirdPath != -1) {
        return self.childrenNodes[selectedPath.firstPath].childrenNodes[selectedPath.secondPath].childrenNodes[selectedPath.thirdPath].title;
    }
    if (selectedPath.secondPath != -1) {
        return [(ZYItem *)self.childrenNodes[selectedPath.firstPath].childrenNodes[selectedPath.secondPath] title];
    }
    return [self.childrenNodes[selectedPath.firstPath] title];

}

@end
