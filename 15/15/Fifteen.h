//
//  Fifteen.h
//  15
//
//  Created by Evgeny Eschenko on 24.12.12.
//  Copyright (c) 2012 Evg33n. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUM_SHUFFLES 100

#ifndef TILE_DIRECTION
#define TILE_DIRECTION int

#define TILE_NONE 100
#define TILE_UP (TILE_NONE+1)
#define TILE_DOWN (TILE_UP+1)
#define TILE_LEFT (TILE_DOWN+1)
#define TILE_RIGHT (TILE_LEFT+1)
#endif

@interface Fifteen : NSObject {
    int board[4][4];
}

-(id)init;
-(void)scramble:(int)n;
-(void)cheat;
-(int)getTileAtRow:(int)row Column:(int)col;
-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile;
-(BOOL)isSolved;

-(BOOL)canSlideTileAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col;
-(TILE_DIRECTION)slideTileAtRow:(int)row Column:(int)col;

@end
