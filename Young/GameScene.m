//
//  GameScene.m
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "GameScene.h"
#import "Image.h"
#import "ImageRenderManager.h"

@implementation GameScene

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
        myImage = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
        myImage.color = Color4fMake(1.0, 0.5, 0.5, 0.75);
        myImage1 = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
        scaleAmount = 2;
    }
    return self;
}

- (void)updateSceneWithDelta:(float)aDelta
{
    transY += 0.075f;
}

- (void)renderScene
{
    [myImage1 renderCenteredAtPoint:CGPointMake(160, 240)];
//    [myImage renderCenteredAtPoint:CGPointMake(160, 240)];
    [sharedImageRenderManager renderImages];
}

@end
