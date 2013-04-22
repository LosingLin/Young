//
//  EAGLView.h
//  Young
//
//  Created by ManYou on 13-4-22.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ESRender.h"

@interface EAGLView : UIView
{
    id <ESRender> renderer;
    BOOL animating;
    BOOL displayLinkSupported;
    NSInteger animationFrameInterval;
    id displayLink;
    NSTimer *animationTimer;
}

@property (readonly, nonatomic, getter = isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void) startAnimation;
- (void) stopAnimation;
- (void) drawView:(id)sender;

@end
