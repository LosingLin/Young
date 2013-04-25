//
//  TriangleScene.m
//  Young
//
//  Created by ManYou on 13-4-25.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "TriangleScene.h"

@implementation TriangleScene

- (void)updateSceneWithDelta:(float)aDelta
{
    transY += 0.075;
}

- (void)renderScene
{
   static const GLfloat triangleVertices[] =
    {
        50, 50,
        250, 50,
        150, 250,
    };
    
    static const GLubyte triangleColors[] =
    {
        255, 0,   0, 255,
        255,   0, 255, 255,
        255,     255,   0,   0,
    };
    
    glTranslatef(0.0f, sinf(transY) / 0.15f, 0.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, triangleVertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, triangleColors);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

@end
