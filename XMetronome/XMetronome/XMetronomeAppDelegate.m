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

int tempoMin[12];
int tempoMax[12];

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
    tempoMin[0]=0;
    tempoMax[0]=20;
    tempoMin[1]=21;
    tempoMax[1]=40;
    tempoMin[2]=41;
    tempoMax[2]=50;
    tempoMin[3]=51;
    tempoMax[3]=60;
    tempoMin[4]=61;
    tempoMax[4]=80;
    tempoMin[5]=81;
    tempoMax[5]=90;
    tempoMin[6]=91;
    tempoMax[6]=104;
    tempoMin[7]=105;
    tempoMax[7]=130;
    tempoMin[8]=131;
    tempoMax[8]=150;
    tempoMin[9]=151;
    tempoMax[9]=167;
    tempoMin[10]=168;
    tempoMax[10]=177;
    tempoMin[11]=178;
    tempoMax[11]=240;
    
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
    return (tempoMax[tempoSelectorIndex]+tempoMin[tempoSelectorIndex])/2;
}

-(int)getTempoSelectorIndexForTempo:(long)tempoValue {
    int result = 0;
    for(int i=0; i<12; i++) {
        if(tempoMin[i]<=tempoValue && tempoMax[i]>=tempoValue) {
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
