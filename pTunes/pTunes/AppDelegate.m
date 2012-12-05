//
//  AppDelegate.m
//  pTunes
//
//  Created by mindworm on 11/23/12.
//  Copyright (c) 2012 aquaxp. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:menu];
    [statusItem setTitle:@"|>"];
    [statusItem setHighlightMode:YES];
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    
    //[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(iTunesPlayerStateChanged:)name:@"com.apple.iTunes.playerInfo" object:nil];
    
}
- (void) updateTrackInfo:(NSNotification *)notification {
    //NSDictionary *information = [notification ];
    //NSLog(@"track information: %@", information);
    NSLog(@"olol");
}

- (IBAction)play:(id)sender {
    //NSLog(@"play");
    //[_itemName setTitle:[[iTunes currentTrack] lyrics]];
    
    
    [iTunes playpause];
    [self updateMenuHead];
    
}

- (IBAction)shuffle:(id)sender {
    //[[iTunes currentPlaylist] setShuffle:(![[iTunes currentPlaylist] shuffle])];
    iTunes.currentPlaylist.shuffle = YES;
    NSLog(@"sh");
}
- (IBAction)next:(id)sender {
    [iTunes nextTrack];
    [self updateMenuHead];
}

- (IBAction)prev:(id)sender {
    [iTunes previousTrack];
     [self updateMenuHead];
}

- (IBAction)preferences:(id)sender {
    //[_lyricsWindows display];
}
- (void)updateMenuHead{
    [_menuTrackName setHidden:NO];
    [_menuArtistName setHidden:NO];
    [_menuAlbumName setHidden:NO];
    [_menuTrackName setTitle:[[iTunes currentTrack] name]];
    [_menuArtistName setTitle:[[iTunes currentTrack] artist]];
    [_menuAlbumName setTitle:[[iTunes currentTrack] album]];
}
@end
