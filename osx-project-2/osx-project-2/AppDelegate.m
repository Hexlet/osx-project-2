#import "AppDelegate.h"
#import "OBMenuBarWindow.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.window.menuBarIcon = [NSImage imageNamed:@"clock"];
    self.window.highlightedMenuBarIcon = [NSImage imageNamed:@"clock_invert"];
    self.window.hasMenuBarIcon = YES;
    self.window.attachedToMenuBar = YES;
    
    //Update timer
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (IBAction)editPlaces:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Верю"];
    [alert setMessageText:@"Реалиазиция редактирования обьектов"];
    [alert setInformativeText:@"Реализация будет, обязательно!!!"];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert runModal];
}

- (void)updateTime {
    NSDateFormatter *dFormatter = [[NSDateFormatter alloc] init];
    [dFormatter setDateFormat:@"hh:mm"];
    
    //Грязный хак, только для того, что бы показать функциональность
    NSDate *date = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:date];
    
    _timeLabel.stringValue = [dFormatter stringFromDate:date];
    _timeLabel2.stringValue = [dFormatter stringFromDate:date2];
}

@end
