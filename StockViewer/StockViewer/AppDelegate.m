//
//  AppDelegate.m
//  StockViewer
//
//  Created by Tolya on 25.11.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "AppDelegate.h"
#import "DataRequest.h"
#import "Bar.h"


@interface AppDelegate ()

- (void)updateRecentItemsList;
- (void)writeBarsToUrl:(NSURL *)anUrl;

@end

@implementation AppDelegate

- (IBAction)loadData:(id)sender
{
    @try {
        NSArray *bars = [self.request send];
        
        [self updateRecentItemsList];
        
        [self.barsController.content removeAllObjects];
        [self.barsController addObjects:bars];
        [self.barsTable reloadData];
    }
    @catch (NSException *exception) {
        NSRunAlertPanel(@"Load data failed", [exception reason], @"OK", nil, nil);
    }
}

- (IBAction)viewInBrowser:(id)sender
{
    @try {
        NSURL *url = [self.request htmlRequestUrl];
        [[NSWorkspace sharedWorkspace] openURL:url];
    }
    @catch (NSException *exception) {
        NSRunAlertPanel(@"Show data in browser failed.", [exception reason], @"OK", nil, nil);
    }

}

- (IBAction)csvExport:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.prompt = @"Export";
    savePanel.allowedFileTypes = [NSArray arrayWithObjects:@"csv", nil];
    if ([savePanel runModal] == NSFileHandlingPanelOKButton) {
        [self writeBarsToUrl:savePanel.URL];
    }
}

- (void)writeBarsToUrl:(NSURL *)anUrl
{
    NSArray *bars = self.barsController.content;
    NSInteger capacity = bars.count * 50;
    NSMutableString *data = [[NSMutableString alloc] initWithCapacity:capacity];
    
    [data appendString:@"Timestamp,Open,High,Low,Close,Volume\n"];
    for (Bar *bar in bars) {
        [data appendFormat:@"%@,%f,%f,%f,%f,%ld\n", bar.date, bar.open, bar.high, bar.low, bar.close, bar.volume];
    }
    
    NSError *error;
    [data writeToURL:anUrl atomically:YES encoding:NSASCIIStringEncoding error:&error];
    if (error) {
        NSString *title = [NSString stringWithFormat:@"Export to '%@' failed.", anUrl.absoluteString];
        NSString *message = error.localizedDescription;

        NSRunAlertPanel(title, message, @"OK", nil, nil);
    }
}

- (void)updateRecentItemsList
{
    NSString *symbol = [self.request.symbol uppercaseString];
    if (![self.recentSymbolsArrayController.content containsObject:symbol]) {
        [self.recentSymbolsArrayController addObject:symbol];
        [self.symbolsComboBox reloadData];
    }
    
    NSString *exchange = [self.request.exchange uppercaseString];
    if (![self.recentExchangesArrayController.content containsObject:symbol]) {
        [self.recentExchangesArrayController addObject:exchange];
        [self.exchangesComboBox reloadData];
    }
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.request resetToDefaults];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
