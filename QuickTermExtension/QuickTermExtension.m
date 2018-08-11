//
//  FinderSync.m
//  QuickTermExtension
//
//  Created by Terry Lewis on 9/7/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "QuickTermExtension.h"
#import "TerminalServiceRegistry.h"

@interface QuickTermExtension ()

@property NSURL *myFolderURL;

@end

@implementation QuickTermExtension

- (instancetype)init {
    self = [super init];

    NSLog(@"%s launched from %@ ; compiled at %s", __PRETTY_FUNCTION__, [[NSBundle mainBundle] bundlePath], __TIME__);

    // Set up the directory we are syncing.
    self.myFolderURL = [NSURL fileURLWithPath:@"/"];
    [FIFinderSyncController defaultController].directoryURLs = [NSSet setWithObject:self.myFolderURL];

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
    return [NSImage imageNamed:NSImageNameCaution];
}

- (NSMenu *)menuForMenuKind:(FIMenuKind)whichMenu {
//    if (whichMenu == FIMenuKindContextualMenuForContainer){
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@""];
        [menu addItemWithTitle:@"Open in Terminal" action:@selector(sampleAction:) keyEquivalent:@""];
        
        return menu;
//    }
    
    return nil;
}

- (void)sampleAction:(id)sender {
    NSURL* target = [[FIFinderSyncController defaultController] targetedURL];
    NSString *fullPath = target.path;
    
    [TerminalServiceRegistry.sharedInstance executeServiceAtPath:fullPath];
}

@end

