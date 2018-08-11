//
//  FinderSync.m
//  QuickTermExtension
//
//  Created by Terry Lewis on 9/7/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "QuickTermExtension.h"
#import "TerminalServiceRegistry.h"
#import "TerminalService.h"

@implementation QuickTermExtension

- (instancetype)init {
    self = [super init];

    NSLog(@"%s launched from %@ ; compiled at %s", __PRETTY_FUNCTION__, [[NSBundle mainBundle] bundlePath], __TIME__);

    // Set up the directory we are syncing.
    [FIFinderSyncController defaultController].directoryURLs = [NSSet setWithObject:[NSURL fileURLWithPath:@"/"]];

    return self;
}

#pragma mark - Menu and toolbar item support

- (NSString *)toolbarItemName {
    return @"QuickTerm";
}

- (NSString *)toolbarItemToolTip {
    return @"QuickTermExtension: Click the toolbar item for a menu.";
}

- (NSImage *)toolbarItemImage {
    return [NSImage imageNamed:@"Console-Icon"];
}

- (NSMenu *)menuForMenuKind:(FIMenuKind)whichMenu {
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@""];

    switch (whichMenu) {
        case FIMenuKindContextualMenuForItems:
            break;
        case FIMenuKindContextualMenuForContainer:
        case FIMenuKindContextualMenuForSidebar:
            [menu addItemWithTitle:@"Open in Terminal" action:@selector(openDirectoryInDefaultTerminal:) keyEquivalent:@""];
            break;
        case FIMenuKindToolbarItemMenu:
            for (TerminalService *service in TerminalServiceRegistry.sharedInstance.services) {
                [menu addItemWithTitle:service.serviceName
                                action:@selector(openDirectoryInTerminal:)
                         keyEquivalent:@""];
            }
            break;
    }

    return menu;
}

- (void)openDirectoryInDefaultTerminal:(id)sender {
    NSURL *target = [[FIFinderSyncController defaultController] targetedURL];
    NSString *fullPath = target.path;

    [TerminalServiceRegistry.sharedInstance executeServiceAtPath:fullPath];
}

- (void)openDirectoryInTerminal:(NSMenuItem *)sender {
    NSURL *target = [[FIFinderSyncController defaultController] targetedURL];
    NSString *fullPath = target.path;

    [TerminalServiceRegistry.sharedInstance executeServiceNamed:sender.title atPath:fullPath];
}

@end

