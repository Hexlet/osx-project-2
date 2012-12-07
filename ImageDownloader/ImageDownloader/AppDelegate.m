//
//  AppDelegate.m
//  ImageDownloader
//
//  Created by Vitaly on 29.11.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_progressBar setHidden:YES];
    [_progressBar setIndeterminate:NO];
}

-(IBAction)download:(id)sender {
//    id <IImageFinder> imageFinder = [[ImageFinder alloc] init];
//    id <IImageSaver> imageSaver = [[ImageSaver alloc] init];
//    
//    LogToFile *log = [[LogToFile alloc] init];
//    [log redirectNSLog:_toPath.stringValue];
//    
//    NSArray *arr =  [imageFinder openURL:_fromURL.stringValue];
//    
//    [_progressBar setHidden:NO];
//    [_progressBar startAnimation:nil];
//    [_progressBar setMaxValue:[arr count]];
//    [_progressStatus setStringValue:[NSString stringWithFormat:@"0/%li",[arr count]]];
//
//    NSInteger i = 0;
//    for (NSString *image in arr) {
//        NSLog(@"%@", [image stringByReplacingOccurrencesOfString:@"/" withString:@""]);
//        [imageSaver downloadImage:[NSString stringWithFormat:@"%@%@",_toPath.stringValue, [image stringByReplacingOccurrencesOfString:@"/" withString:@""]] : image];
//        i++;
//        [_progressBar incrementBy:1];
//        [_progressStatus setStringValue:[NSString stringWithFormat:@"%li/%li",i,[arr count]]];
//    }
//    
//    [_progressBar stopAnimation:nil];
//    [_progressBar setHidden:YES];
    
    NSArray *extraParams = [[NSArray alloc] initWithObjects:_progressBar, _fromURL.stringValue, _toPath.stringValue, _progressStatus, nil];
    [NSThread detachNewThreadSelector:@selector(process:)
                             toTarget:[ImagesController class]
                             withObject:extraParams];
}

- (void) awakeFromNib {
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSBundle *bundle = [NSBundle mainBundle];
    _statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"download" ofType:@"png"]];
    _statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"arrow_down" ofType:@"png"]];
    [_statusItem setImage:_statusImage];
    [_statusItem setAlternateImage:_statusHighlightImage];
    [_statusItem setMenu:_statusMenu];
    [_statusItem setHighlightMode:YES];
}

- (IBAction)openWindow:(id)sender {
    [self openForm];
}

- (IBAction)openWindowFromStatus:(id)sender {
    [self openForm];
}

- (void) openForm {
    [_window makeKeyAndOrderFront:nil];
}

@end
