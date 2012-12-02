#import <Cocoa/Cocoa.h>

@class OBMenuBarWindow;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSTimer *timer;
}

@property (assign) IBOutlet OBMenuBarWindow *window;

 //Грязный хак, только для того, что бы показать функциональность
@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSTextField *timeLabel2;

- (IBAction)editPlaces:(id)sender;

- (void)updateTime;

@end
