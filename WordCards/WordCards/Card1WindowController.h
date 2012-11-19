//
//  Card1WindowController.h
//  WordCards
//
//  Created by alex on 19/11/2012.
//  Copyright (c) 2012 alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Card1WindowController : NSWindowController
@property (weak) IBOutlet NSTextField *word;
@property (weak) IBOutlet NSButton *speaker;
@property (weak) IBOutlet NSBox *box1;
@property (weak) IBOutlet NSBox *box2;
@property (weak) IBOutlet NSBox *translation;
@property (weak) IBOutlet NSButton *goButton;

@end
