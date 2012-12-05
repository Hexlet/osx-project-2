//
//  AppDelegate.h
//  pTunes
//
//  Created by mindworm on 11/23/12.
//  Copyright (c) 2012 aquaxp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "iTunes.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSStatusItem *statusItem;
    IBOutlet NSMenu *menu;
    iTunesApplication* iTunes;
}
- (IBAction)play:(id)sender;
@property (weak) IBOutlet NSMenuItem *itemName;
- (IBAction)shuffle:(id)sender;
@property (weak) IBOutlet NSMenuItem *menuTrackName;
- (IBAction)next:(id)sender;
- (IBAction)prev:(id)sender;
- (IBAction)preferences:(id)sender;
@property (unsafe_unretained) IBOutlet NSPanel *lyricsWindows;
@property (weak) IBOutlet NSMenuItem *menuArtistName;
@property (weak) IBOutlet NSMenuItem *menuAlbumName;


@end
