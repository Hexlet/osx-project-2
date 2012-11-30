//
//  TLUtils.m
//  TrafficLaws
//
//  Created by Igor Smirnov on 16.11.12.
//  Copyright (c) 2012 Igor Smirnov. All rights reserved.
//

#import "TLUtils.h"

NSString * const csNewLine = @"\x0a";

@implementation TLUtils

// решил "закэшировать" путь до приложения
- (id) init {
    self = [super init];
    if (self) {
        _bundlePath = [NSBundle mainBundle].bundlePath;
    }
    return self;
}

// просто добавляем к имени файла путь до приложения
- (NSString *) makeFilePath: (NSString *) aFileName {
    return [NSString stringWithFormat: @"%@/Contents/Resources/%@", self.bundlePath, aFileName];
}

// ниже следует код, взятый у Google Toolbox for Mac
// немного переделанный для использования ARC,
// ну и комменты переведены на великий и могучий
- (NSString*)wrapString: (NSString *) aString
              withWidth: (CGFloat) aWidth
                andFont: (NSFont *) aFont {

    // инициализация объектов, которые нам пригодятся дальше
    NSRect targetRect = NSMakeRect(0, 0, aWidth, CGFLOAT_MAX);
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithContainerSize: targetRect.size];
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init];
    NSTextStorage * textStorage = [[NSTextStorage alloc] initWithString: aString];
    
    [textStorage addLayoutManager: layoutManager];
    [layoutManager addTextContainer: textContainer];

    // отступ между строк
    [textContainer setLineFragmentPadding: 2.0f];
    
    // применяем шрифт
    [textStorage setFont: aFont];
    
    // получаем NSMutableString и убираем из него все переносы строк (\x0a)
    NSMutableString* workerStr = [textStorage mutableString];
    [workerStr replaceOccurrencesOfString: csNewLine
                               withString: @""
                                  options: NSLiteralSearch
                                    range: NSMakeRange(0, [workerStr length])];

    // получаем высоту строки для последующего цикла
    CGFloat lineHeight = [layoutManager defaultLineHeightForFont: aFont];
    targetRect.size.height = lineHeight;
    
    // цикл до тех пор, пока не обработаем все буквы
    NSUInteger numGlyphsUsed = 0;
    while ( numGlyphsUsed < [layoutManager numberOfGlyphs] ) {
        // See what fits in the current rect
        NSRange range = [layoutManager glyphRangeForBoundingRect: targetRect
                                                 inTextContainer: textContainer];
        
        numGlyphsUsed = NSMaxRange(range);
        if (numGlyphsUsed < [layoutManager numberOfGlyphs]) {
            // Didn't all fit, add a break, and grow the rect to try again.
            NSRange charRange = [layoutManager glyphRangeForCharacterRange: range
                                                      actualCharacterRange: nil];
            [workerStr insertString: csNewLine
                            atIndex: NSMaxRange(charRange)];
            targetRect.size.height += lineHeight;
        }
    }
    return workerStr;
}

- (void) makeRadioGroupWarppableWithWidth: (NSMatrix *) aRadioGroup {
    NSSize cellSize = [aRadioGroup cellSize];
    NSRect rect = NSMakeRect(0, 0, cellSize.width, cellSize.height);
    NSFont *font = [aRadioGroup font];
    
    for ( NSCell * cell in aRadioGroup.cells ) {
        NSRect titleFrame = [cell titleRectForBounds: rect];
        NSString *newTitle = [self wrapString: [cell title]
                                    withWidth: NSWidth(titleFrame)
                                      andFont: font];
        [cell setTitle:newTitle];
    }
    [aRadioGroup setNeedsDisplay];
}

@end
