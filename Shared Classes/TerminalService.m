//
//  TerminalService.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "TerminalService.h"

@implementation TerminalService
- (instancetype)initWithApplicationName:(NSString *)applicationName serviceDescription:(NSString *)serviceDescription serviceName:(NSString *)serviceName identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        self.applicationName = applicationName;
        self.serviceDescription = serviceDescription;
        self.serviceName = serviceName;
        self.identifier = identifier;
    }

    return self;
}
+ (instancetype)serviceWithApplicationName:(NSString *)applicationName serviceDescription:(NSString *)serviceDescription serviceName:(NSString *)serviceName identifier:(NSString *)identifier {
    return [[self alloc] initWithApplicationName:applicationName
                              serviceDescription:serviceDescription
                                     serviceName:serviceName
                                      identifier:identifier];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.applicationName=%@", self.applicationName];
    [description appendFormat:@", self.serviceDescription=%@", self.serviceDescription];
    [description appendFormat:@", self.serviceName=%@", self.serviceName];
    [description appendFormat:@", self.identifier=%@", self.identifier];
    [description appendString:@">"];
    return description;
}

@end
