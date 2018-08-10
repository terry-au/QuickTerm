//
//  AppDelegate.m
//  OpenInTerminal
//
//  Created by Terry Lewis on 9/7/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "AppDelegate.h"
#import "TerminalService.h"
#import "TerminalServiceRegistry.h"

@interface AppDelegate ()

@property(weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  TerminalService *terminalTabService =
      [TerminalService serviceWithDisplayName:@"Terminal: New Tab" serviceName:@"New Terminal Tab at Folder"];
  TerminalService *terminalWindowService =
      [TerminalService serviceWithDisplayName:@"Terminal: New Tab" serviceName:@"New Terminal Tab at Folder"];

  TerminalServiceRegistry *terminalServiceRegistry = TerminalServiceRegistry.sharedInstance;
  [terminalServiceRegistry registerService:terminalTabService makeDefault:YES];
  [terminalServiceRegistry registerService:terminalWindowService];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)application:(NSApplication *)application openURLs:(NSArray<NSURL *> *)urls {
  for (NSURL *URL in urls) {
    [self handleURL:URL];
  }
}

- (void)handleURL:(NSURL *)URL {
  NSURLComponents *URLComponents = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];

  if ([URLComponents.host isEqualToString:@"terminal"]) {
    [TerminalServiceRegistry.sharedInstance executeServiceAtPath:URLComponents.path];
  }
}

@end
