//
//  ViewController2.m
//  Спички1


#import "ViewController2.h"
#import "Setup.h"

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

-(NSNumber*) randomIndexInRange:(NSNumber*) range{
    return [NSNumber numberWithInt: arc4random() % [range intValue]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIImage *simpleImage = [UIImage imageNamed:@"spichka1.png"];
    int startPositionX = 30;
    int y = 316;
    int matchesCount = [Setup getInstance].MatchesCount;
    
    NSMutableArray *availableIndexes = [[NSMutableArray alloc] initWithCapacity:matchesCount];
    for (int i = 0; i < matchesCount; i++) {
        [availableIndexes addObject:[NSNumber numberWithInt:i]];
    }
    
    int shortMatchesCount = [Setup getInstance].ShortMatchesCount;
    NSMutableArray *shortIndexes = [[NSMutableArray alloc] initWithCapacity:shortMatchesCount];
    
    for (int i = 0; i<shortMatchesCount; i++) {
        //Count of items in DNA array which were not changed
        NSNumber* notChangedItemsCount = [NSNumber numberWithLong: [availableIndexes count]];
        //Get a random item index from not changed indexes array
        NSNumber*randomIndexPosition = [self randomIndexInRange: notChangedItemsCount];
        //Get a random item value from not changed indexes array
        //which is equal item index in DNA array
        int randomIndex = [[availableIndexes objectAtIndex:[randomIndexPosition intValue]] intValue];
        [shortIndexes addObject:[[NSNumber alloc] initWithInt: randomIndex]];
        [availableIndexes removeObjectAtIndex:[randomIndexPosition intValue]] ;
    }

    
    
    int step = ((320-60) - (matchesCount * 31))/(matchesCount - 1);
    for (int i = 0; i < matchesCount; i++) {
        
        bool isShort = NO;
        for (NSNumber *n 
             in shortIndexes) {
            if (n.intValue == i) {
                isShort = YES;
                break;
            }
        }
        NSString *imageFile = isShort ? @"spichka-s.png" : @"spichka1.png";
        int imageHeight = isShort ? 150 : 272;
        UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(startPositionX, y-imageHeight, 31,imageHeight)];
        UIImage *image = [UIImage imageNamed:imageFile];
        imageHolder.image = image;
        [self.view addSubview:imageHolder];
        startPositionX = startPositionX + 31 + step;
        imageHolder.userInteractionEnabled = YES;
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(controlPan1:)];
        [recognizer setMinimumNumberOfTouches:1];
        [recognizer setMaximumNumberOfTouches:1];
        [imageHolder addGestureRecognizer:recognizer];
    }
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320,128)];
    UIImage *image = [UIImage imageNamed:@"doski.png"];
    imageHolder.image = image;
    [self.view addSubview:imageHolder];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) controlPan1:(UIPanGestureRecognizer *)recogniser{
    CGPoint translation = [recogniser translationInView:self.view];
    recogniser.view.center = CGPointMake(recogniser.view.center.x, MIN(MAX (recogniser.view.center.y
                                                                        + translation.y, 180),320 ));
    [recogniser setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

@end
