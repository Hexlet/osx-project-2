//
//  AppDelegate.h
//  SimpleTranslator
//
//  Created by Администратор on 11/28/12.
//  Copyright (c) 2012 Kirill.Muratov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSTextField *labelResult;
@property (weak) IBOutlet NSPopUpButton *srcLang;
@property (weak) IBOutlet NSPopUpButton *destLang;

- (IBAction)translateText:(id)sender;

@end
