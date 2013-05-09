//
//  ImageRenderManager.h
//  Young
//
//  Created by ManYou on 13-5-8.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "SynthesizeSingleton.h"
#import "Global.h"

#define kMax_Images 250
#define kMax_Textures 20

@interface ImageRenderManager : NSObject
{
    TexturedColoredVertex *iva;
    
    GLushort *ivaIndices;
    
    NSUInteger textureIndices[kMax_Textures][kMax_Images];
    
    NSUInteger texturesToRender[kMax_Textures];
    
    NSUInteger imageCountForTexture[kMax_Images];
    
    NSUInteger renderTextureCount;
    
    GLushort ivaIndex;
}

+ (ImageRenderManager *)sharedImageRenderManager;

- (void)addImageDetailsToRenderQueue:(ImageDetails *)aImageDetails;

- (void)addTexturedColoredQuadToRenderQueue:(TexturedColoredQuad *)aTCQ texture:(uint)aTexture;

- (void)renderImages;

@end
