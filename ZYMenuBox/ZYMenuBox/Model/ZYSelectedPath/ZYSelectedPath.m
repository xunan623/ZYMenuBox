//
//  ZYSelectedPath.m
//  ZYMenuBox
//
//  Created by xunan on 2017/4/25.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "ZYSelectedPath.h"


@interface ZYSelectedPath () <NSCopying>
@end

@implementation ZYSelectedPath

- (instancetype)init {
    self = [super init];
    if (self) {
        self.secondPath = -1;
        self.thirdPath = -1;
        self.isKindOfAlternative = NO;
    }
    return self;
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath
                        thirdPath:(NSInteger)thirdPath {
    
    
    return [self pathWithFirstPath:firstPath
                        secondPath:secondPath
                         thirdPath:thirdPath
               isKindOfAlternative:NO
                              isOn:NO];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath {
    return [self pathWithFirstPath:firstPath
                        secondPath:secondPath
                         thirdPath:-1
               isKindOfAlternative:NO
                              isOn:NO];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath {
    
    return [self pathWithFirstPath:firstPath
                        secondPath:-1
               isKindOfAlternative:NO
                              isOn:NO];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                             isOn:(BOOL)isOn {
    
    return [self pathWithFirstPath:firstPath
                        secondPath:-1
               isKindOfAlternative:YES
                              isOn:isOn];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath
              isKindOfAlternative:(BOOL)isKindOfAlternative
                             isOn:(BOOL)isOn {
    
    return [self pathWithFirstPath:firstPath
                        secondPath:-1
                         thirdPath:-1
               isKindOfAlternative:YES
                              isOn:isOn];
}

+ (instancetype)pathWithFirstPath:(NSInteger)firstPath
                       secondPath:(NSInteger)secondPath
                        thirdPath:(NSInteger)thirdPath
              isKindOfAlternative:(BOOL)isKindOfAlternative
                             isOn:(BOOL)isOn {
    ZYSelectedPath *path = [[[self class] alloc] init];
    path.firstPath = firstPath;
    path.secondPath = secondPath;
    path.thirdPath = thirdPath;
    path.isKindOfAlternative = isKindOfAlternative;
    path.isOn = isOn;
    return path;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    ZYSelectedPath *path = [[self class] pathWithFirstPath:self.firstPath
                                                secondPath:self.secondPath
                                                 thirdPath:self.thirdPath
                                       isKindOfAlternative:self.isKindOfAlternative
                                                      isOn:self.isOn];
    return path;
}

- (void)resetFirstPath:(NSInteger)firstPath {
    self.firstPath  = firstPath;
    self.secondPath = -1;
    self.thirdPath = -1;
}
@end
