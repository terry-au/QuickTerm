//
//  TerminalService.h
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TerminalService : NSObject
- (NSString *)description;
- (instancetype)initWithApplicationName:(NSString *)applicationName serviceDescription:(NSString *)serviceDescription serviceName:(NSString *)serviceName identifier:(NSString *)identifier;
+ (instancetype)serviceWithApplicationName:(NSString *)applicationName serviceDescription:(NSString *)serviceDescription serviceName:(NSString *)serviceName identifier:(NSString *)identifier;

@property(nonatomic, strong) NSString *applicationName;
@property(nonatomic, strong) NSString *serviceDescription;
@property(nonatomic, strong) NSString *serviceName;
@property(nonatomic, strong) NSString *identifier;

@end
