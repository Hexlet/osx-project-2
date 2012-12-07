//
//  Model.h
//  passGen
//
//  Created by padawan on 13.11.12.
//  Copyright (c) 2012 padawan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Model : NSObject {
    IBOutlet NSNumber *lengthPass;
    IBOutlet NSTextField *passwordField;
    IBOutlet NSButton *enableUpperCase, *enableLowerCase, *enableNumeric;
    NSMutableArray *upperCase, *lowerCase, *numeric;
}
-(IBAction) generate:(id)sender;
-(IBAction)copyToClipboard:(id)sender;
@end
