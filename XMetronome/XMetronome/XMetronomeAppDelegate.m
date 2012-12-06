//
//  XMetronomeAppDelegate.m
//  XMetronome
//
//  Created by Mykola Makhin on 12/2/12.
//  Copyright (c) 2012 mvmn. All rights reserved.
//

#import "XMetronomeAppDelegate.h"

@implementation XMetronomeAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [_tempoSelectBox removeAllItems];
    [_tempoSelectBox addItemWithTitle:@"Larghissimo"];
    [_tempoSelectBox addItemWithTitle:@"Grave"];
    [_tempoSelectBox addItemWithTitle:@"Largo"];
    [_tempoSelectBox addItemWithTitle:@"Adagio"];
    [_tempoSelectBox addItemWithTitle:@"Andante"];
    [_tempoSelectBox addItemWithTitle:@"Moderato"];
    [_tempoSelectBox addItemWithTitle:@"Allegretto"];
    [_tempoSelectBox addItemWithTitle:@"Allegro"];
    [_tempoSelectBox addItemWithTitle:@"Vivace"];
    [_tempoSelectBox addItemWithTitle:@"Vivacissimo"];
    [_tempoSelectBox addItemWithTitle:@"Presto"];
    [_tempoSelectBox addItemWithTitle:@"Prestissimo"];
    [_tempoSelectBox setTarget:self];
    [_tempoSelectBox setAction:@selector(updateTempoByTempoSelector)];
    [self updateTempoSelectorByTempo];    
}

int tempoBoundary[13];

-(id)init {
    tempo = 120;
    timeSignature = 1;
    playNotes = 1;
    
    /*
     Larghissimo – very, very slow (20 BPM and below)
     Grave – slow and solemn (21–40 BPM)
     Largo – broadly (41–50 BPM)
     Adagio – slow and stately (literally, "at ease") (51–60 BPM)
     Andante – at a walking pace (61–80 BPM)
     Moderato – moderately (81–90 BPM)
     Allegretto – moderately quick (91–104 BPM)
     Allegro – fast, quickly and bright (105–132 BPM)
     Vivace – lively and fast (≈132-150 BPM)
     Vivacissimo – very fast and lively (151-167)
     Presto – very fast (168–177 BPM)
     Prestissimo – extremely fast (178–208 BPM)
     */
    tempoBoundary[0]=0;
    tempoBoundary[1]=21;
    tempoBoundary[2]=41;
    tempoBoundary[3]=51;
    tempoBoundary[4]=61;
    tempoBoundary[5]=81;
    tempoBoundary[6]=91;
    tempoBoundary[7]=105;
    tempoBoundary[8]=131;
    tempoBoundary[9]=151;
    tempoBoundary[10]=168;
    tempoBoundary[11]=178;
    tempoBoundary[12]=240;
    
    return self;
}

-(void)setTempo:(long)val {
    if(val<1) {
        tempo=1;
        [_tempoInputField setStringValue:[NSString stringWithFormat:@"%d", 1]];
    } else if(val>240) {
        tempo=240;
        [_tempoInputField setStringValue:[NSString stringWithFormat:@"%d", 240]];
    } else {
        tempo = val;
    }
    [self updateTempoSelectorByTempo];
}

-(long)getTempoForTempoSelectorIndex:(long)tempoSelectorIndex {
    return (tempoBoundary[tempoSelectorIndex+1]+tempoBoundary[tempoSelectorIndex])/2;
}

-(int)getTempoSelectorIndexForTempo:(long)tempoValue {
    int result = 0;
    for(int i=0; i<12; i++) {
        if(tempoBoundary[i]<=tempoValue && tempoBoundary[i+1]>=tempoValue) {
            result = i;
            break;
        }
    }
    
    return result;
}

-(void)updateTempoByTempoSelector {
    [self setTempo:[self getTempoForTempoSelectorIndex:[_tempoSelectBox indexOfSelectedItem]]];
}

-(void)updateTempoSelectorByTempo {
    [_tempoSelectBox selectItemAtIndex:[self getTempoSelectorIndexForTempo:tempo]];
}

@end
