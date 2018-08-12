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

- (void)executeServiceNamed:(NSString *)serviceName atPath:(NSString *)path;
- (void)executeServiceAtPath:(NSString *)path;

@property(nonatomic, strong, readonly) NSArray<TerminalService *> *services;

@end
