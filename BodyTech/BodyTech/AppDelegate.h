//
//  AppDelegate.h
//  BodyTech
//
//  Created by Dmitry Davidov on 02.12.12.
//  Copyright (c) 2012 Dmitry Davidov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
    
@property (readwrite, retain) NSMutableArray *exercises;
@property NSInteger currentExercise;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSArrayController *exerciseArrayController;

- (IBAction)createExercise:(id)sender;

@end
