//
//  TerminalService.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "TerminalService.h"

@implementation TerminalService

+ (instancetype)serviceWithDisplayName:(NSString *)displayName serviceName:(NSString *)serviceName {
    TerminalService *instance = [[self alloc] init];
    instance.displayName = displayName;
    instance.serviceName = serviceName;

    return instance;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.displayName=%@", self.displayName];
    [description appendFormat:@", self.serviceName=%@", self.serviceName];
    [description appendString:@">"];
    return description;
}

@end
