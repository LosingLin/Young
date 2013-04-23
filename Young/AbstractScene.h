//
//  AbstractScene.h
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface AbstractScene : NSObject
{
    CGRect      screenBounds;
    uint        sceneState;
    GLfloat     sceneAlpha;
    NSString    *nextSceneKey;
    float       sceneFadeSpeed;
}

#pragma mark - Properties

@property (nonatomic, assign) uint sceneState;
@property (nonatomic, assign) GLfloat sceneAlpha;

#pragma mark - Methods

- (void) updateSceneWithDelta:(float)aDelta;
- (void) renderScene;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;
- (void)touchesCancelled:(NSSet  *)touches withEvent:(UIEvent *)event view:(UIView *)aView;

- (void)updateWithAccelerometer:(UIAcceleration *)aAcceleration;

@end
