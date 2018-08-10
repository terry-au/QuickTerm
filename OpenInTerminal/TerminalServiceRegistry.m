//
//  TerminalServiceRegistry.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 11/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

@import AppKit;

#import "TerminalServiceRegistry.h"
#import "TerminalService.h"

@implementation TerminalServiceRegistry

+ (instancetype)sharedInstance {
    static TerminalServiceRegistry *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }

    return sharedInstance;
}
- (instancetype)init {
    if (self = [super init]) {
        self.services = NSMutableArray.array;
    }
    return self;
}

- (void)registerService:(TerminalService *)service {
    [self registerService:service makeDefault:NO];
}

- (void)registerService:(TerminalService *)service makeDefault:(BOOL)makeDefault {
    [self.services addObject:service];
    if (makeDefault) {
        self.service = service;
    }
}

- (void)executeServiceAtPath:(NSString *)path {
    BOOL isDirectory = NO;
    if (![NSFileManager.defaultManager fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory) {
        return;
    }

    NSPasteboard *pasteboard = [NSPasteboard pasteboardWithUniqueName];
    [pasteboard declareTypes:@[NSStringPboardType] owner:nil];
    [pasteboard setString:path forType:NSStringPboardType];

    NSString *serviceString = self.service.serviceName;

    BOOL success = NSPerformService(serviceString, pasteboard);
    if (!success) {
        NSLog(@"Failed to perform service: %@", self.service);
    }
}

@end
