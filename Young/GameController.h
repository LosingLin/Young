//
//  GameController.h
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import "SynthesizeSingleton.h"

@class AbstractScene;

@interface GameController : NSObject <UIAccelerometerDelegate>
{
    NSDictionary *gameScenes;
    AbstractScene *currentScene;
}

@property(nonatomic, retain) AbstractScene *currentScene;

+ (GameController *)sharedGameController;

- (void)updateCurrentSceneWithDelta:(float)aDelta;

- (void)renderCurrentScene;

@end
