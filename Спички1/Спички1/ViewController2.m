//
//  ViewController2.m
//  Спички1


#import "ViewController2.h"

@interface ViewController2 ()

- (IBAction) controlPan1:(UIPanGestureRecognizer *)recogniser;
@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) controlPan1:(UIPanGestureRecognizer *)recogniser{
    CGPoint translation = [recogniser translationInView:self.view];
    recogniser.view.center = CGPointMake(recogniser.view.center.x, MAX (recogniser.view.center.y
                                                                        + translation.y, 180));
    [recogniser setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

@end
