//
//  TextureManager.m
//  Young
//
//  Created by ManYou on 13-5-6.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "TextureManager.h"
#import "Global.h"
#import "SynthesizeSingleton.h"
#import "Texture2D.h"


@implementation TextureManager

SYNTHESIZE_SINGLETON_FOR_CLASS(TextureManager);

- (void)dealloc
{
    [cachedTextures release];
    
    [super dealloc];
}

- (id)init
{
    if (self = [self init])
    {
        cachedTextures = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (Texture2D*)textureWithFileName:(NSString *)aName filter:(GLenum)aFilter
{
    Texture2D *cachedTexture;
    
    if ((cachedTexture = [cachedTextures objectForKey:aName]))
    {
        return cachedTexture;
    }
    
    NSString *filename = [aName stringByDeletingPathExtension];
    NSString *filetype = [aName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];
    cachedTexture = [[Texture2D alloc] initWithImage:[UIImage imageWithContentsOfFile:path] filter:aFilter];
    [cachedTextures setObject:cachedTexture forKey:aName];
    
    return [cachedTexture autorelease];
}

- (BOOL)releaseTextureWithName:(NSString *)aName
{
    if ([cachedTextures objectForKey:aName])
    {
        [cachedTextures removeObjectForKey:aName];
        return YES;
    }
    
    NSLog(@"INFO - Resouce Manager : A texture with the key '%@' could not be found to relase.", aName);
    return NO;
}

- (void)releaseAllTextures
{
    SLQLOG(@"INFO - Resource Manager : Releaseing all cached texture");
    [cachedTextures removeAllObjects];
}

@end
