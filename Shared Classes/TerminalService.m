//
//  TerminalService.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "TerminalService.h"

@implementation TerminalService

- (instancetype)initWithDisplayName:(NSString *)displayName serviceName:(NSString *)serviceName identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        self.displayName = displayName;
        self.serviceName = serviceName;
        self.identifier = identifier;
    }

    return self;
}

+ (instancetype)serviceWithDisplayName:(NSString *)displayName serviceName:(NSString *)serviceName identifier:(NSString *)identifier {
    return [[self alloc] initWithDisplayName:displayName serviceName:serviceName identifier:identifier];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.displayName=%@", self.displayName];
    [description appendFormat:@", self.serviceName=%@", self.serviceName];
    [description appendFormat:@", self.identifier=%@", self.identifier];
    [description appendString:@">"];
    return description;
}

@end
