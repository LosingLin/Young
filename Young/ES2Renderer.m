//
//  ES2Renderer.m
//  Young
//
//  Created by ManYou on 13-4-19.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "ES2Renderer.h"

//uniform index
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS,
};

GLint uniforms[NUM_UNIFORMS];

//attribute index
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES,
};

@interface ES2Renderer (PrivateMethods)

- (BOOL) loadShaders;
- (BOOL) compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL) linkProgram:(GLuint)prog;
- (BOOL) validateProgram:(GLuint)prog;

@end

@implementation ES2Renderer

@end
