//
//  main.m
//  IrregularVerbs
//
//  Created by Andrew on 23.08.12.
//  Copyright (c) 2012 AndrewVanyurin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVList.h"
#import "IVAppDelegate.h"
#import "IVPref.h"

IVList * wordList;
IVPref * preferences;

int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([IVAppDelegate class]));
    }
}
