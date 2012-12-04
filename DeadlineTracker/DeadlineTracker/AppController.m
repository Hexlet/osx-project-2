//
//  AppController.m
//  DeadlineTracker
//
//  Created by Yaroslav Shukharev on 04.12.12.
//  Copyright (c) 2012 krkmetal. All rights reserved.
//

#import "AppController.h"
#import "AddCourseWindowController.h"
#import "AddTaskWindowController.h"

@implementation AppController

- (IBAction)addCourse:(id)sender {
    if (!addCourseController) {
        addCourseController = [[AddCourseWindowController alloc] initWithWindowNibName:@"AddCourseWindow"];
    }
    [addCourseController showWindow:self];
}

- (IBAction)addTask:(id)sender {
    if (!addTaskController) {
        addTaskController = [[AddTaskWindowController alloc] initWithWindowNibName:@"AddTaskWindow"];
    }
    [addTaskController showWindow:self];
}
@end
