//
//  CustomFontLoader.m
//  testcalc1
//
//  Created by Alexander Shvets on 27.11.12.
//  Copyright (c) 2012 Alexander Shvets. All rights reserved.
//

#import "CustomFontLoader.h"

@implementation CustomFontLoader

+(BOOL) loadFont:(NSString*)fileName
{
   
    NSString *fontPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: fileName];
    NSData *fontData = [NSData dataWithContentsOfFile: fontPath];
    
    ATSFontContainerRef container;
    OSStatus err = ATSFontActivateFromMemory([fontData
                                              bytes], [fontData length],
                                             kATSFontContextLocal,
                                             kATSFontFormatUnspecified,
                                             NULL,
                                             kATSOptionFlagsDefault,
                                             &container );
    
    if(err != noErr){
        NSLog(@"failed to load font %@ into memory", fileName);
        return NO;
    }
    
    ATSFontRef fontRefs[100];
    ItemCount  fontCount;
    err = ATSFontFindFromContainer(container,
                                   kATSOptionFlagsDefault,
                                   100,
                                   fontRefs,
                                   &fontCount );
    
    if( err != noErr || fontCount < 1 ){
        NSLog(@"font %@ could not be loaded.", fileName);
        return NO;
    }
    
    //NSLog(@"font %@ loaded.", fileName);
    return YES;

}

@end
