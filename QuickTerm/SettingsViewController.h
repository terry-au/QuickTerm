//
//  SettingsViewController.h
//  QuickTerm
//
//  Created by Terry Lewis on 12/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property(weak) IBOutlet NSButton *checkBoxContextMenu;
@property(weak) IBOutlet NSTableView *tableView;
- (IBAction)helpButtonClicked:(id)sender;

@end
