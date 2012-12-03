//
//  HelloWorldLayer.m
//  NALvlBuilder
//
//  Created by User on 15.11.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

#pragma mark Init Block
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init]))
    {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cocos2d view" fontName:@"Marker Felt" fontSize:64];
        [self addChild:label];

        CCSprite *back = [CCSprite node];
        
        CCTexture2D* backTexture = [[CCTextureCache sharedTextureCache]addImage:@"box.png"];
        ccTexParams tpBG2 = {GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
        [backTexture setTexParameters:&tpBG2];
        
        [back setDisplayFrame:[CCSpriteFrame frameWithTexture:backTexture rect:CGRectMake(0, 0, SPRITE_SIZE*41, 41*SPRITE_SIZE)]];
		// ask director the the window size
        back.anchorPoint = ccp(0.5f,0.5f);
        [self addChild:back];
		CGSize size = [[CCDirector sharedDirector] winSize];
        back.position = ccp( size.width /2 , size.height/2 );
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
        
		[[CCEventDispatcher sharedDispatcher] addMouseDelegate:self priority:0];
		// add the label as a child to this Layer
//		[self addChild: label];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark Mouse Events
-(BOOL) ccMouseDown:(NSEvent *)event
{
    NSLog(@"mouse");
	return YES;
}
-(BOOL) ccMouseDragged:(NSEvent*)event
{
    NSLog(@"mouse ccMouseDragged");
    return YES;
}
-(BOOL) ccMouseUp:(NSEvent*)event
{
    NSLog(@"mouse up");
    return YES;
}

@end
