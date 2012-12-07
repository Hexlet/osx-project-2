//
//  AppDelegate.h
//  ImageDownloader
//
//  Created by Vitaly on 29.11.12.
//  Copyright (c) 2012 Vitaly Petrov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IImageFinder.h"
#import "ImageFinder.h"
#import "IImageSaver.h"
#import "ImageSaver.h"
#import "LogToFile.h"
#import "ImagesController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTextField *fromURL;
@property (strong) IBOutlet NSTextField *toPath;
@property (strong) IBOutlet NSProgressIndicator *progressBar;
@property (strong) IBOutlet NSTextField *progressStatus;
@property (strong) IBOutlet NSMenu *statusMenu;
@property NSStatusItem *statusItem;
@property NSImage *statusImage;
@property NSImage *statusHighlightImage;

- (IBAction)download:(id)sender;
- (IBAction)openWindow:(id)sender;
- (IBAction)openWindowFromStatus:(id)sender;

@end
