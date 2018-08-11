//
// Created by Terry Lewis on 11/8/18.
// Copyright (c) 2018 Terry Lewis. All rights reserved.
//

#import "Settings.h"
#import "TerminalService.h"

@implementation Settings {
    NSUserDefaults *_defaults;
}

static NSString *kKeyDefaultServiceIdentifier = @"DefaultServiceIdentifier";
static NSString *kDefaultDefaultServiceIdentifier = @"com.apple.terminal.tab";

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:@"io.gitlab.terrylewis.OpenInTerminal"];
    }

    return self;
}

- (NSObject *)valueForSetting:(NSString *)settingName withDefault:(NSObject *)defaultValue {
    NSObject *value = [_defaults objectForKey:settingName];
    if (!value) {
        value = defaultValue;
    }

    return value;
}

- (NSArray<TerminalService *> *)defaultServices {
    if (!_defaultServices) {
        _defaultServices = @[
            [TerminalService serviceWithApplicationName:@"Terminal"
                                     serviceDescription:@"Open Terminal Tab"
                                            serviceName:@"New Terminal Tab at Folder"
                                             identifier:kDefaultDefaultServiceIdentifier],

            [TerminalService serviceWithApplicationName:@"Terminal"
                                     serviceDescription:@"Open Terminal Window"
                                            serviceName:@"New Terminal at Folder"
                                             identifier:@"com.apple.terminal.window"],

            [TerminalService serviceWithApplicationName:@"iTerm2"
                                     serviceDescription:@"Open iTerm Tab"
                                            serviceName:@"New iTerm2 Tab Here"
                                             identifier:@"com.googlecode.iterm2.tab"],

            [TerminalService serviceWithApplicationName:@"iTerm2"
                                     serviceDescription:@"Open iTerm Window"
                                            serviceName:@"New iTerm2 Window Here"
                                             identifier:@"com.googlecode.iterm2.window"],
        ];
    }
    return _defaultServices;
}

- (NSString *)activeServiceIdentifier {
    return static_cast<NSString *>(
        [self valueForSetting:kKeyDefaultServiceIdentifier withDefault:kDefaultDefaultServiceIdentifier]
    );
}

- (void)setActiveServiceIdentifier:(NSString *)activeServiceIdentifier {
    [_defaults setObject:activeServiceIdentifier forKey:kKeyDefaultServiceIdentifier];
}

@end
