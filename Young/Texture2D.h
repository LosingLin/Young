//
//  Texture2D.h
//  Young
//
//  Created by ManYou on 13-4-26.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <Foundation/Foundation.h>

// Enumerators for the different pixel format this class can handle
typedef enum {
    kTexture2DPixelFormat_Automatic = 0,
    kTexture2DPixelFormat_RGBA8888,
    kTexture2DPixelFormat_RGB565,
    kTexture2DPixelFormat_A8,
} Texture2DPixelFormat;

@interface Texture2D : NSObject
{
@private
    GLuint name; //holds the OpenGL name generated for this texture
    CGSize contentSize; //stores the actual size of image being loaded as a texture
    NSUInteger width; //the actual with and height of the texture once it has been adjusted to be
    NSUInteger height; //power of 2 compliant
    GLfloat maxS; //maximum texture coordinates for the image that has been placed inside our texture.
    GLfloat maxT; //
    CGSize textureRatio; //the ratio between pixel and texels(texture coordinates)
    Texture2DPixelFormat pixelFormat; //the pixel format of the image that has been loaded
}

@property(nonatomic, readonly) GLuint name; 
@property(nonatomic, readonly) CGSize contentSize; 
@property(nonatomic, readonly) NSUInteger width; 
@property(nonatomic, readonly) NSUInteger height; 
@property(nonatomic, readonly) GLfloat maxS; 
@property(nonatomic, readonly) GLfloat maxT; 
@property(nonatomic, readonly) CGSize textureRatio; 
@property(nonatomic, readonly) Texture2DPixelFormat pixelFormat;

// designated initializer that takes a UIImage and a filter (used for the MIN and MAG settings of the \
texture) and creates an OpenGL texture.
- (id) initWithImage:(UIImage *)aImage filter:(GLenum)aFilter;

@end
