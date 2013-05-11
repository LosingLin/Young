//
//  ImageRenderManager.m
//  Young
//
//  Created by ManYou on 13-5-8.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "ImageRenderManager.h"

@interface ImageRenderManager (Private)

- (void)copyImageDetails:(ImageDetails *)aImageDetails;

- (void)addToTextureList:(uint)aTextureName;

@end

@implementation ImageRenderManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ImageRenderManager);

- (void)dealloc
{
    if (iva)
    {
        free(iva);
    }
    if (ivaIndices)
    {
        free(ivaIndices);
    }
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        iva = calloc(kMax_Images, sizeof(TexturedColoredQuad));
        
        ivaIndices = calloc(kMax_Images * 6, sizeof(GLushort));
        
        ivaIndex = 0;
        
        renderTextureCount = 0;
        
        memset(imageCountForTexture, 0, kMax_Images);
    }
    
    return self;
}

- (void)addImageDetailsToRenderQueue:(ImageDetails *)aImageDetails
{
    [self copyImageDetails:aImageDetails];
    
    [self addToTextureList:aImageDetails->textureName];
    
    ivaIndex ++;
}

- (void)addTexturedColoredQuadToRenderQueue:(TexturedColoredQuad *)aTCQ texture:(uint)aTexture
{
    memcpy((TexturedColoredQuad *)iva + ivaIndex, aTCQ, sizeof(TexturedColoredQuad));
    
    [self addToTextureList:aTexture];
    
    ivaIndex ++;
}

- (void)renderImages
{
    glVertexPointer(2, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].geometryVertex);
    glTexCoordPointer(2, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].textureVertex);
    glColorPointer(4, GL_FLOAT, sizeof(TexturedColoredVertex), &iva[0].vertexColor);
    
    for (NSInteger textureIndex = 0; textureIndex < renderTextureCount; textureIndex ++)
    {
        glBindTexture(GL_TEXTURE_2D, texturesToRender[textureIndex]);
        
        int vertexCounter = 0;
        
        for (NSInteger imageIndex = 0; imageIndex < imageCountForTexture[texturesToRender[textureIndex]]; imageIndex ++)
        {
            NSUInteger index = textureIndices[texturesToRender[textureIndex]][imageIndex] * 4;
            
            ivaIndices[vertexCounter ++] = index;   //bottom left
            ivaIndices[vertexCounter ++] = index + 2; //top left
            ivaIndices[vertexCounter ++] = index + 1; //bottom right
            ivaIndices[vertexCounter ++] = index + 1; //bottom right
            ivaIndices[vertexCounter ++] = index + 2; //top left
            ivaIndices[vertexCounter ++] = index + 3; //top right
        }
        
        glDrawElements(GL_TRIANGLES, vertexCounter, GL_UNSIGNED_SHORT, ivaIndices);
        
        
        imageCountForTexture[texturesToRender[textureIndex]] = 0;
    }
    
    renderTextureCount = 0;
    ivaIndex = 0;
}

@end

@implementation ImageRenderManager (Private)

- (void)copyImageDetails:(ImageDetails *)aImageDetails
{
    if (ivaIndex + 1 > kMax_Images)
    {
        NSLog(@"ERROR - RenderManager: Render queue size exceeded. Consider increasing the default size. %d", ivaIndex + 1);
        [self renderImages];
    }
    
    aImageDetails->texturedColoredQuadIVA = (TexturedColoredQuad *)iva + ivaIndex;
    
    memcpy(aImageDetails->texturedColoredQuadIVA, aImageDetails->texturedColoredQuad, sizeof(TexturedColoredQuad));
}

- (void)addToTextureList:(uint)aTextureName
{
    BOOL textureFound = NO;
    for (int index = 0; index < renderTextureCount; index ++)
    {
        if (texturesToRender[index] == aTextureName)
        {
            textureFound = YES;
            break;
        }
    }
    
    if (!textureFound)
    {
        texturesToRender[renderTextureCount++] = aTextureName;
    }
    textureIndices[aTextureName][imageCountForTexture[aTextureName]] = ivaIndex;
    
    imageCountForTexture[aTextureName] += 1;
}

@end
