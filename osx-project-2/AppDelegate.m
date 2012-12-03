//
//  AppDelegate.m
//  osx-project-2
//
//  Created by Kirill Gorshkov on 30.11.12.
//  Copyright (c) 2012 Kirill Gorshkov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    pasteboardSemaphore = YES;
    pasteboardContainer = [[NSMutableArray alloc] init];
    mainPasteboard = [NSPasteboard generalPasteboard];
    [mainPasteboard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    copyCount = [mainPasteboard changeCount];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(onTick) userInfo:nil repeats:YES];
}

///
/// Вызывается таймером, при несовпадении copyCount и текущего числа изменений буфера перезаписывает
/// copyCount и вызывает copy
///
-(void) onTick {
    if (copyCount != [mainPasteboard changeCount]) {
        copyCount = [mainPasteboard changeCount];
        /// для предотвращения коллизий при изменении буфера функцией pasteNow
        if (pasteboardSemaphore) {
            [self copy];
        }
        else {
            pasteboardSemaphore = YES;
        }
    }
}

///
/// Вытаскивает строку из буфера обмена и записывает ее в pasteboardContainer,
/// а ее укороченное представление - в ComboBox
///
- (void)copy {
    NSString *pasteboardString;
    /// для предотвращения ошибок типа NSString == nil
    while (!pasteboardString) {
         pasteboardString = [mainPasteboard stringForType:NSStringPboardType];
    }
    NSString *comboString;
    /// проверяем, есть ли уже такая строка
    BOOL copyFlag = YES;
    for (int i = 0; i < [pasteboardContainer count]; i++) {
        if ([pasteboardString isEqualToString:[pasteboardContainer objectAtIndex:i]]) {
            copyFlag = NO;
            break;
        }
    }
    /// собираем строку для отображения в comboBox
    if ([pasteboardString length] > 50)
        comboString = [[[pasteboardString stringByReplacingOccurrencesOfString:@"\n" withString: @" "] substringToIndex:47] stringByAppendingString:@"..."];
    else
        comboString = [pasteboardString stringByReplacingOccurrencesOfString:@"\n" withString: @" "];
    
    if (copyFlag) {
        [pasteboardContainer addObject:pasteboardString];
        [_comboBox addItemWithObjectValue:comboString];
    }
    [_comboBox setStringValue:comboString];
}

///
/// Записывает текущую строку из ComboBox в буфер обмена
///
- (IBAction)pasteNow:(id)sender {
    pasteboardSemaphore = NO;
    [mainPasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [mainPasteboard setString: [pasteboardContainer objectAtIndex:[_comboBox indexOfSelectedItem]] forType:NSStringPboardType];
}

@end
