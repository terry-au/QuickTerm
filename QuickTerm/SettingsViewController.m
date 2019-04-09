//
//  SettingsViewController.m
//  QuickTerm
//
//  Created by Terry Lewis on 12/8/18.
//  Copyright © 2018 Terry Lewis. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"
#import "TerminalService.h"
#import <FinderSync/FinderSync.h>

@interface SettingsViewController () {
    NSArray<TerminalService *> *_services;
}

@end

@implementation SettingsViewController

static NSString *const kIdentifierApplicationName = @"ApplicationCellID";
static NSString *const kIdentifierServiceName = @"ServiceCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL contextMenuEnabled = Settings.sharedInstance.enableContextMenu;
    self.checkBoxContextMenu.state = contextMenuEnabled ? NSOnState : NSOffState;
    self.checkBoxContextMenu.target = self;
    self.checkBoxContextMenu.action = @selector(checkBoxContextMenuClicked:);
    
    self.tableView.target = self;
    self.tableView.action = @selector(tableViewRowClicked:);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setTableViewEnabled:contextMenuEnabled];;
    
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    _services = [Settings.sharedInstance.defaultServices copy];
    [self.tableView reloadData];
    
    for (NSUInteger i = 0; i < _services.count; ++i) {
        TerminalService *service = _services[i];
        if ([service.identifier isEqualToString:Settings.sharedInstance.activeServiceIdentifier]) {
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:i];
            [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        }
    }
    
    // Prompt to enable the extension.
    static NSString *settingsKey = @"ShownEnableExtensionAlert";
    if (![self isExtensionEnabled] || ![NSUserDefaults.standardUserDefaults boolForKey:settingsKey]) {
        [self promptToEnableExtension];
        [NSUserDefaults.standardUserDefaults setBool:YES forKey:settingsKey];
    }
}

- (BOOL)isExtensionEnabled {
    if (@available(macOS 10.14, *)) {
        return [FIFinderSyncController isExtensionEnabled];
    } else {
        // Assume it is enabled.
        return YES;
    }
}

- (void)promptToEnableExtension {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Enable Extension";
    alert.informativeText = @"The QuickTerm Finder extension must be enabled in System Preferences";
    [alert addButtonWithTitle:@"Open System Preferences"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            [self openSystemPreferences];
        }
    }];
}

- (void)openSystemPreferences {
    if (@available(macOS 10.14, *)) {
        [FIFinderSyncController showExtensionManagementInterface];
    } else {
        NSString *urlString = @"x-apple.systempreferences://";
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
    }
}

- (IBAction)helpButtonClicked:(id)sender {
    [self promptToEnableExtension];
}

- (void)setTableViewEnabled:(BOOL)enabled {
    self.tableView.enabled = enabled;
    self.tableView.alphaValue = enabled ? 1.0 : 0.5;
}

- (void)checkBoxContextMenuClicked:(NSButton *)sender {
    BOOL enabled = (sender.state == NSOnState);
    Settings.sharedInstance.enableContextMenu = enabled;
    [self setTableViewEnabled:enabled];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _services.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TerminalService *terminalService = _services[row];
    NSString *cellIdentifier = nil;
    NSString *displayString = nil;
    
    if (tableColumn == tableView.tableColumns[0]) {
        cellIdentifier = kIdentifierApplicationName;
        displayString = terminalService.applicationName;
    } else if (tableColumn == tableView.tableColumns[1]) {
        cellIdentifier = kIdentifierServiceName;
        displayString = terminalService.serviceName;
    }
    
    NSTableCellView *cell = [tableView makeViewWithIdentifier:cellIdentifier owner:nil];
    cell.textField.stringValue = displayString;
    
    return cell;
}

- (void)tableViewRowClicked:(NSTabView *)tableView {
    NSUInteger selectedRow = self.tableView.selectedRow;
    TerminalService *terminalService = _services[selectedRow];
    Settings.sharedInstance.activeServiceIdentifier = terminalService.identifier;
    
}

@end
