//
//  GameController.m
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "GameController.h"
#import "GameScene.h"
#import "Common.h"
#import "TriangleScene.h"

@interface GameController (Private)

- (void) initGame;

@end

@implementation GameController

@synthesize currentScene;

SYNTHESIZE_SINGLETON_FOR_CLASS(GameController);

- (void)dealloc
{
    [gameScenes release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        currentScene = nil;
        [self initGame];
    }
    return self;
}

- (void) updateCurrentSceneWithDelta:(float)aDelta
{
    [currentScene updateSceneWithDelta:aDelta];
}

- (void) renderCurrentScene
{
    [currentScene renderScene];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
}

@end


@implementation GameController (Private)

- (void)initGame
{
    SLQLOG(@"INFO - GameController: Starting game initialization.");
    
    gameScenes = [[NSMutableDictionary alloc] initWithCapacity:5];
    AbstractScene *scene = [[GameScene alloc] init];
    [gameScenes setValue:scene forKey:@"game"];
    [scene release];
    
    TriangleScene *tScene = [[TriangleScene alloc] init];
    [gameScenes setValue:tScene forKey:@"triangle"];
    [tScene release];
    
    currentScene = [gameScenes objectForKey:@"game"];
    
    SLQLOG(@"INFO - GameController: Finished game initialization.");
}

@end
