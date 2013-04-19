//
//  ES2Renderer.h
//  Young
//
//  Created by ManYou on 13-4-19.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "ESRender.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ES2Renderer : NSObject
{
@private
    EAGLContext *context;
    
    //The pixel dimensions of the CAEAGLLayer
    GLint backingWidth;
    GLint backingHeight;
    
    //The OpenGL names for the framebuffer and renderbuffer used to render to this view
    GLuint defaultFramebuffer, colorRenderbuffer;
    
    GLuint program;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
