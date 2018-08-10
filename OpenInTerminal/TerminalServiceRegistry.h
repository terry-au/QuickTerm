//
//  TerminalServiceRegistry.h
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TerminalService;
@interface TerminalServiceRegistry : NSObject

+ (instancetype)sharedInstance;

- (void)registerService:(TerminalService *)service;
- (void)executeServiceAtPath:(NSString *)path;
- (void)registerService:(TerminalService *)service makeDefault:(BOOL)makeDefault;

@property(nonatomic, strong) NSMutableArray *services;
@property(nonatomic, weak) TerminalService *service;

@end
