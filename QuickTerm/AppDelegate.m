//
//  AppDelegate.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 9/7/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "AppDelegate.h"
#import "Third Party/PFMoveApplication.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    PFMoveToApplicationsFolderIfNecessary();
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
