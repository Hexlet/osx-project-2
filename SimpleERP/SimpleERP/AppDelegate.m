//
//  AppDelegate.m
//  SimpleERP
//
//  Created by Admin on 27.11.12.
//  Copyright (c) 2012 Kabest. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import "POrders.h"

@implementation AppDelegate

@synthesize window;
@synthesize leftMenu;
@synthesize mainTableView;
@synthesize webView;
@synthesize pOrders;

-(id) init {
    self = [super init];
    if (self) {
        pOrders = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) awakeFromNib {
    [mainTableView setHidden:YES];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    leftMenuValues = [NSArray arrayWithObjects:@"Purchases", @"Orders", @"Bills", @"Sales", @"Orders", @"Invoices", @"Clients", @"Companies", @"People", nil];
    leftMenuObjects = [NSArray arrayWithObjects:@"PurchasesTitleCellView", @"POrdersCellView", @"BillsCellView", @"SalesTitleCellView", @"SOrdersCellView", @"InvoicesCellView", @"ClientsTitleCellView", @"CompaniesCellView", @"PeopleCellView", nil];
    leftMenuSelectable = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], nil];
    [leftMenu setDataSource:self];
    [leftMenu reloadData];
    [leftMenu selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
    [[webView mainFrame] loadHTMLString:@"<HTML><BODY><H2 ALIGN=\"CENTER\" STYLE=\"font-family:Arial,Helvetica;\">Orders</H2></BODY></HTML>" baseURL:[NSURL URLWithString:@""]];
}

-(NSInteger)numberOfRowsInTableView:(NSTableCellView*)tableView {
    return leftMenuValues.count;
}

-(NSView*)tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *result = nil;
    result = [tableView makeViewWithIdentifier:[leftMenuObjects objectAtIndex:row] owner:self];
    result.textField.stringValue = [leftMenuValues objectAtIndex:row];
    return result;
}

-(BOOL) tableView:(NSTableView*)tableView shouldSelectRow:(NSInteger)row {
    return [[leftMenuSelectable objectAtIndex:row] boolValue];
}

-(IBAction) tableViewSelectionDidChange:(NSNotification *)notification {
    [mainTableView setHidden:NO];
    NSInteger selectedRow = [leftMenu selectedRow];
    NSString *html = [NSString stringWithFormat:@"<HTML><BODY><H2 ALIGN=\"CENTER\" STYLE=\"font-family:Arial,Helvetica;\">%@</H2></BODY></HTML>", [leftMenuValues objectAtIndex:selectedRow]];
    [[webView mainFrame] loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
}

@end
