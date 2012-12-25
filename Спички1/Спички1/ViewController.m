//
//  ViewController.m
//  Спички1
//


#import "ViewController.h"
#import "Setup.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    matchecCountStepper.value = [Setup getInstance].MatchesCount;
    shortMatchesCountStepper.value = [Setup getInstance].ShortMatchesCount;
    [self matchesCountDidChanged:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) matchesCountDidChanged:(id)sender{
    matcheCount.text = [NSString stringWithFormat:@"%d", (int)matchecCountStepper.value];
    shortMatchesCountStepper.maximumValue = matchecCountStepper.value - 1;
    shortMatchesCount.text = [NSString stringWithFormat:@"%d", (int)shortMatchesCountStepper.value];
    
    
}

-(IBAction) shortMatchesCountDidChanged:(id)sender{
    
    shortMatchesCount.text = [NSString stringWithFormat:@"%d", (int)shortMatchesCountStepper.value];
}

-(IBAction) runButtonClicked:(id)sender{
    [Setup getInstance].MatchesCount = (int)matchecCountStepper.value;
    [Setup getInstance].ShortMatchesCount = (int)shortMatchesCountStepper.value;
}

@end
