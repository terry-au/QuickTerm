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
#import "Settings.h"

@implementation TerminalServiceRegistry

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}
- (instancetype)init {
    if (self = [super init]) {
        self.services = [Settings.sharedInstance defaultServices];
    }
    return self;
}

- (TerminalService *)activeService {
    for (TerminalService *terminalService in self.services) {
        if ([terminalService.identifier isEqualToString:Settings.sharedInstance.activeServiceIdentifier]) {
            return terminalService;
        }
    }

    return nil;
}

- (void)executeServiceNamed:(NSString *)serviceName atPath:(NSString *)path {
    BOOL isDirectory = NO;
    if (![NSFileManager.defaultManager fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory) {
        return;
    }

    NSPasteboard *pasteboard = [NSPasteboard pasteboardWithUniqueName];
    [pasteboard declareTypes:@[NSStringPboardType] owner:nil];
    [pasteboard setString:path forType:NSStringPboardType];

    BOOL success = NSPerformService(serviceName, pasteboard);
    if (!success) {
        NSLog(@"Failed to perform service: %@", serviceName);
    }
}

- (void)executeServiceAtPath:(NSString *)path {
    TerminalService *activeService = [self activeService];
    [self executeServiceNamed:activeService.serviceName atPath:path];
}

@end
