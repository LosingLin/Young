//
//  AbstractScene.m
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "AbstractScene.h"

@implementation AbstractScene

@synthesize sceneState, sceneAlpha;

- (void) updateSceneWithDelta:(float)aDelta{}
- (void) renderScene{}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView{}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView{}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView{}
- (void)touchesCancelled:(NSSet  *)touches withEvent:(UIEvent *)event view:(UIView *)aView{}

- (void)updateWithAccelerometer:(UIAcceleration *)aAcceleration{}

@end
