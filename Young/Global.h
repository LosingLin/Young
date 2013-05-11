//
//  Global.h
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#ifndef Young_Global_h
#define Young_Global_h

#import <OpenGLES/ES1/gl.h>
#import "Structures.h"

#pragma mark - 
#pragma mark Debug

#define SLQLOG(...) NSLog(__VA_ARGS__);

#define SCB 0

#pragma mark -
#pragma mark Macros

#define RANDOM_MINUS_1_TO_1() ((random() / (GLfloat)0x3fffffff) - 1.0f)

#define RANDOM_0_TO_1() (random() / (GLfloat)0x7fffffff);

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI);

#define CLAMP(X, A, B) ((X < A) ?  A : ((X > B) ? B : X))


#pragma mark - 
#pragma mark Inline Functions

static const Color4f Color4fOnes = {1.0f, 1.0f, 1.0f, 1.0f};

static inline Scale2f Scale2fMake(float x, float y)
{
    return (Scale2f) {x, y};
}

static inline Color4f Color4fMake(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha)
{
    return (Color4f){red, green, blue, alpha};
}

#endif
