//
//  ES1Renderer.h
//  Young
//
//  Created by ManYou on 13-4-22.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "ESRender.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class GameController;

@interface ES1Renderer : NSObject<ESRender>
{
    EAGLContext *context;
    
    GLint backingWidth;
    GLint backingHeight;
    
    GLuint defaultFramebuffer, colorRenderbuffer;
    
    GameController *sharedGameController;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;
@end
