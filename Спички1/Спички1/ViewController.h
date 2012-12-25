//
//  ViewController.h
//  Спички1
//


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UITextField* matcheCount;
    IBOutlet UITextField* shortMatchesCount;
    IBOutlet UIStepper* matchecCountStepper;
    IBOutlet UIStepper* shortMatchesCountStepper;

}

-(IBAction) matchesCountDidChanged:(id)sender;
-(IBAction) shortMatchesCountDidChanged:(id)sender;
-(IBAction) runButtonClicked:(id)sender;
@end
