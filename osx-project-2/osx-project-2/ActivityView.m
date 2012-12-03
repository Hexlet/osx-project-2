//
//  ActivityView.m
//  osx-project-2
//
//  Created by Pavel Popchikovsky on 04.12.2012.
//  Copyright (c) 2012 Pavel Popchikovsky. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);

    [self drawTestFigure];
    
    glFlush();
}

- (void)drawTestFigure
{
    glBegin(GL_TRIANGLES);
    {
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex2f(-0.9f, -0.9f);
        
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex2f(0.0f, 0.9f);

        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex2f(0.9f, -0.9f);
    }
    glEnd();
}

@end
