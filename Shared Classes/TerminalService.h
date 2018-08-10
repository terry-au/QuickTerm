//
//  TerminalService.h
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TerminalService : NSObject
- (instancetype)initWithDisplayName:(NSString *)displayName serviceName:(NSString *)serviceName identifier:(NSString *)identifier;
+ (instancetype)serviceWithDisplayName:(NSString *)displayName serviceName:(NSString *)serviceName identifier:(NSString *)identifier;

@property(nonatomic, strong) NSString *displayName;
@property(nonatomic, strong) NSString *serviceName;
@property(nonatomic, strong) NSString *identifier;

- (NSString *)description;

@end
