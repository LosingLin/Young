//
//  GameScene.m
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (void)updateSceneWithDelta:(float)aDelta
{
    transY += 0.075f;
}

- (void)renderScene
{
    static const GLfloat squareVertices[] = {
        50,  50, // 1
		250,  50,// 2
        50,   250, // 3
		250,   250, // 4
        
    };
	
	
    static const GLubyte squareColors[] = {
        255, 0,   0, 255,
        255,   0, 0, 255,
        255,     255,   0,   0,
        255,   0, 0, 255,
    };
    
    glTranslatef(0.0f, sinf(transY) / 0.15f, 0.0f);
    
    glVertexPointer(2, GL_FLOAT, 0, squareVertices);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

@end
