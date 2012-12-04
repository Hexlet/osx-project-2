//
//  AppController.h
//  DeadlineTracker
//
//  Created by Yaroslav Shukharev on 04.12.12.
//  Copyright (c) 2012 krkmetal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddCourseWindowController;
@class AddTaskWindowController;

@interface AppController : NSObject {
    @private
    AddCourseWindowController *addCourseController;
    AddTaskWindowController *addTaskController;
}

- (IBAction)addCourse:(id)sender;
- (IBAction)addTask:(id)sender;


@end
