//
//  ESRender.h
//  Young
//
//  Created by ManYou on 13-4-19.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@protocol ESRender <NSObject>

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
