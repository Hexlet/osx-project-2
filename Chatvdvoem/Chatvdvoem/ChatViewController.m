//
//  ChatViewController.m
//  Chatvdvoem
//
//  Created by Dm on 11/25/12.
//  Copyright (c) 2012 Dm. All rights reserved.
//

#import "ChatViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"

#define kStatusBarHeight 20
#define kDefaultToolbarHeight 40
#define kDefaultNavbarHeight 44
#define kKeyboardHeightPortrait 216
//#define kKeyboardHeightLandscape 140
#define kKeyboardHeightLandscape 162

@implementation ChatViewController

@synthesize inputToolbar;

- (void)dealloc
{
    //    [inputToolbar release];
    //    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    keyboardIsVisible = NO;
    connected = YES;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWillHide:)];
    [self.bubbleTable addGestureRecognizer:gestureRecognizer];
    
    
    
    /* Calculate navigation bar height */
    CGRect navframe = [[self.navigationController navigationBar] frame];
    
    /* Calculate screen size */
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    //    self.view = [[UIView alloc] initWithFrame:screenFrame];
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    /* Create toolbar */
    inputToolbar = [[UIInputToolbar alloc] initWithFrame:CGRectMake(0, screenFrame.size.height-kDefaultToolbarHeight-navframe.size.height, screenFrame.size.width, kDefaultToolbarHeight)];
    [self.view addSubview:self.inputToolbar];
    inputToolbar.delegate = self;
    inputToolbar.textView.placeholder = @"Сообщение...";
    
    /* Fill test chat data */
    //    NSBubbleData *heyBubble = [NSBubbleData dataWithText:@"Hey, halloween is soon" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:BubbleTypeSomeoneElse];
    
    //    NSBubbleData *replyBubble = [NSBubbleData dataWithText:@"Wow.. Really cool picture out there. iPhone 5 has really nice camera, yeah?" date:[NSDate dateWithTimeIntervalSinceNow:-5] type:BubbleTypeMine];
    
    //    NSBubbleData *heyBubble2 = [NSBubbleData dataWithText:@"Hey, halloween is soon Hey, halloween is soon Hey, halloween is soonHey, halloween is soonHey, halloween is soonHey, halloween is soon Hey, halloween is soon  Hey, halloween is soon Hey, halloween is soonHey, halloween is soon Hey, halloween is soon Hey, halloween is soon Hey, halloween is soon Hey, halloween is soonHey, halloween is soonHey, halloween is soonHey, halloween is soon Hey, halloween is soon  Hey, halloween is soon Hey, halloween is soonHey, halloween is soon Hey, halloween is soon" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:BubbleTypeSomeoneElse];
    //
    //
    //    bubbleData = [[NSMutableArray alloc] initWithObjects:heyBubble, replyBubble, nil];
    
    bubbleData = [[NSMutableArray alloc] init];
    _bubbleTable.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    _bubbleTable.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    _bubbleTable.showAvatars = NO;
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
    //    _bubbleTable.typingBubble = NSBubbleTypingTypeSomebody;
    
    [_bubbleTable reloadData];
    
    /* Scroll table to bottom */
    //    CGFloat bubbleTableOffset = _bubbleTable.contentSize.height - _bubbleTable.bounds.size.height - navframe.size.height;
    //    [_bubbleTable setContentOffset:CGPointMake(0, bubbleTableOffset) animated:YES];
    
    //    NSLog(@"%f",_bubbleTable.contentSize.height - navframe.size.height);
    
    // Keyboard events
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	/* Listen for keyboard */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	/* No longer listen for keyboard */
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Rotations

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.inputToolbar setAlpha:0.0f];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    if (connected) {
        if ([bubbleData count]>0) {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([bubbleData count] ) inSection:0];
            [_bubbleTable scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        [UIView animateWithDuration: 0.3f animations:^{self.inputToolbar.alpha = 1.0f;}];
        CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
        CGRect navframe = [[self.navigationController navigationBar] frame];
        CGRect r = self.inputToolbar.frame;
        
        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
            r.origin.y = screenFrame.size.height - r.size.height - navframe.size.height;
            if (keyboardIsVisible) {
                r.origin.y -= kKeyboardHeightPortrait;
            }
            [self.inputToolbar.textView setMaximumNumberOfLines:13];
        } else {
            r.origin.y = screenFrame.size.width - r.size.height - navframe.size.height;
            if (keyboardIsVisible) {
                r.origin.y -= kKeyboardHeightLandscape;
            }
            [self.inputToolbar.textView setMaximumNumberOfLines:7];
            [self.inputToolbar.textView sizeToFit];
        }
        self.inputToolbar.frame = r;
    
//    }
    
}

#pragma mark Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    connected =YES;
    if (connected) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        
        
        /* Move the toolbar to above the keyboard */
        CGRect frame = self.inputToolbar.frame;
        
        frame.origin.y = (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) ?
        (self.view.frame.size.height - frame.size.height - kKeyboardHeightPortrait) :
        (self.view.frame.size.height - frame.size.height - kKeyboardHeightLandscape);
        
        self.inputToolbar.frame = frame;
        
        keyboardIsVisible = YES;
        
        /* Resize bubble table */
        
        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
            _bubbleTable.contentInset = UIEdgeInsetsMake(0,0,kKeyboardHeightPortrait,0);
        } else {
            _bubbleTable.contentInset = UIEdgeInsetsMake(0,0,kKeyboardHeightLandscape,0);
        }
        
        [UIView commitAnimations];
        
        if ([bubbleData count]>0) {
            [self scrollBubbleTableToBottom];
        }
        
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    /* Move the toolbar back to bottom of the screen */
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
    
	CGRect frame = self.inputToolbar.frame;
    
    if (connected) {
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.inputToolbar.frame = frame;
    }
    
    keyboardIsVisible = NO;
    
    
    /* Resize bubble table */
    _bubbleTable.contentInset=UIEdgeInsetsMake(0,0,0,0);
    [UIView commitAnimations];
    
    if ([bubbleData count]>0) {
        [self scrollBubbleTableToBottom];
    }
    [self.inputToolbar.textView resignFirstResponder];
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

-(void)scrollBubbleTableToBottom {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([bubbleData count] ) inSection:0];
    [_bubbleTable scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [UIView commitAnimations];
    
}

-(void)inputButtonPressed:(NSString *)inputText
{
    /* Called when toolbar button is pressed */
    //    NSLog(@"Pressed button with text: '%@'", inputText);
    
    _bubbleTable.typingBubble = NSBubbleTypingTypeNobody;
    
    NSBubbleData *sayBubble = [NSBubbleData dataWithText:inputText date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeMine];
    [bubbleData addObject:sayBubble];
    [_bubbleTable reloadData];
    [self scrollBubbleTableToBottom];
}

#pragma mark - toggle input tool bar

- (void)hide:(UIView *)view
{
    [UIView animateWithDuration:0.2 //begin animation
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:^
     {
         [view setFrame:CGRectOffset([view frame], 0, view.frame.size.height)];
         NSLog(@"%f",self.inputToolbar.frame.origin.y);
     }
                     completion:nil];
}
- (void)show:(UIView *)view
{
    [UIView animateWithDuration:0.2 //begin animation
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:^
     {
         [view setFrame:CGRectOffset([view frame], 0, -view.frame.size.height)];
     }
                     completion:nil];
}

- (IBAction)toggleConnection:(UIBarButtonItem *)button {
    
    [self.inputToolbar.textView resignFirstResponder];
    [self.inputToolbar.textView clearText];
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
    
    /* Toggle connection */
    if ([button.title isEqualToString:@"Вкл."]) {
        [button setTitle:@"Откл."];
        self.inputToolbar.hidden = NO;
//        [self show:inputToolbar];
        
        
        
        [bubbleData removeAllObjects];
        [_bubbleTable reloadData];
        connected = YES;
        
    } else {
        [button setTitle:@"Вкл."];
        self.inputToolbar.hidden = YES;
//        [self hide:inputToolbar];
        connected = NO;
    }
    [UIView commitAnimations];
    
}
@end
