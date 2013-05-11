//
//  GameScene.h
//  Young
//
//  Created by ManYou on 13-4-23.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "AbstractScene.h"
#import "Global.h"

@class Image;
@class ImageRenderManager;

@interface GameScene : AbstractScene
{
    float transY;
    Image *myImage;
    Image *myImage1;
    ImageRenderManager *sharedImageRenderManager;
    float scaleAmount;
}

@end
