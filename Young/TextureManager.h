//
//  TextureManager.h
//  Young
//
//  Created by ManYou on 13-5-6.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Texture2D;

@interface TextureManager : NSObject
{
    NSMutableDictionary *cachedTextures;
}

+ (TextureManager*)sharedTextureManager;

- (Texture2D *)textureWithFileName:(NSString *)aName filter:(GLenum)aFilter;
- (BOOL)releaseTextureWithName:(NSString *)aName;
- (void)releaseAllTextures;

@end
