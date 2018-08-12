//
// Created by Terry Lewis on 11/8/18.
// Copyright (c) 2018 Terry Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TerminalService;
@interface Settings : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, strong) NSString *activeServiceIdentifier;

@property(nonatomic, assign) BOOL enableContextMenu;

@property(nonatomic, strong, readonly) NSArray<TerminalService *> *defaultServices;

@end
