//
//  FirstViewController.m
//  VKPlayer
//
//  Created by phantom on 18.11.12.
//  Copyright (c) 2012 kipelovets. All rights reserved.
//

#import "AudioViewController.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController ()

@end

@implementation AudioViewController {
    NSArray* userAudio;
    AVAudioPlayer * player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    userAudio = [NSArray array];
    [self.table reloadData];
    [[Vkontakte sharedInstance] setDelegate:self];
    [[Vkontakte sharedInstance] getAudioForUser:nil];
}

- (void)vkontakteDidFinishGettingAudio:(NSArray*)audio forUser:(NSString*)userId
{
    NSLog(@"got audio %d", [audio count]);
    userAudio = audio;
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRows %d", [userAudio count]);
    return [userAudio count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath indexAtPosition:1];
    NSDictionary * track =[userAudio objectAtIndex:row];
    NSNumber* aid = [track objectForKey:@"aid"];
    NSString* ident = [NSString stringWithFormat:@"%@", aid];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@ — %@", [track objectForKey:@"artist"], [track objectForKey:@"title"]]];
    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath indexAtPosition:1];
    NSDictionary * track = [userAudio objectAtIndex:row];
    NSLog(@"play %@", [track objectForKey:@"url"]);
    NSURL * url = [NSURL URLWithString:[track objectForKey:@"url"]];
    NSError * error = nil;
    NSData * song = [NSData dataWithContentsOfURL:url];
    player = [[AVAudioPlayer alloc] initWithData:song error:&error];
    [player prepareToPlay];
    [player play];
}

@end
