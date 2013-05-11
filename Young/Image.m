//
//  Image.m
//  Young
//
//  Created by ManYou on 13-5-10.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import "Image.h"
#import "Texture2D.h"
#import "TextureManager.h"
#import "ImageRenderManager.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Transform2D.h"

#pragma mark - 
#pragma mark Private interface

@interface Image (Private)

- (void)initializeImage:(NSString*)aName filter:(GLenum)aFilter;

- (void)initializeImageDetails;

@end

#pragma mark - 
#pragma mark Public implementation

@implementation Image

@synthesize imageFileName;
@synthesize imageFileType;
@synthesize texture;
@synthesize fullTextureSize;
@synthesize textureSize;
@synthesize textureRatio;
@synthesize maxTextureSize;
@synthesize imageSize;
@synthesize textureOffset;
@synthesize rotation;
@synthesize scale;
@synthesize flipHorizontally;
@synthesize flipVertically;
@synthesize IVAIndex;
@synthesize textureName;
@synthesize point;
@synthesize color;
@synthesize rotationPoint;
@synthesize minMagFilter;
@synthesize imageDetails;
@synthesize subImageRectangle;

- (void)dealloc
{
    if (texture)
    {
        [texture release];
    }
    
    if (imageDetails)
    {
        if (imageDetails->texturedColoredQuad)
        {
            free(imageDetails->texturedColoredQuad);
        }
        free(imageDetails);
    }
    
    
    [super dealloc];
}

- (id)initWithImageNamed:(NSString *)aName filter:(GLenum)aFilter
{
    self = [super init];
    if (self != nil)
    {
        [self initializeImage:aName filter:aFilter];
        
        imageSize = texture.contentSize;
        originalImageSize = imageSize;
        
        textureSize.width = texture.maxS;
        textureSize.height = texture.maxT;
        
        textureOffset = CGPointZero;
        
        [self initializeImageDetails];
    }
    return self;
}

- (id)initWithImageNamed:(NSString *)aName filter:(GLenum)aFilter subTexture:(CGRect)aSubTexture
{
    self = [super init];
    if (self != nil)
    {
        subImageRectangle = aSubTexture;
        
        [self initializeImage:aName filter:aFilter];
        
        imageSize = aSubTexture.size;
        originalImageSize = imageSize;
        
        textureOffset.x = textureRatio.width * aSubTexture.origin.x;
        textureOffset.y = textureRatio.height * aSubTexture.origin.y;
        
        textureSize.width = (textureRatio.width * imageSize.width) + textureOffset.x;
        textureSize.height = (textureRatio.height * imageSize.height) + textureOffset.y;
        
        [self initializeImageDetails];
    }
    
    return self;
}

#pragma mark - 

- (Image*)subImageInRect:(CGRect)aRect
{
    Image *subImage = [[Image alloc] initWithImageNamed:imageFileName filter:minMagFilter subTexture:aRect];
    
    subImage.scale = scale;
    subImage.color = color;
    subImage.flipHorizontally = flipHorizontally;
    subImage.flipVertically = flipVertically;
    subImage.rotation = rotation;
    subImage.rotationPoint = rotationPoint;
    
    return [subImage autorelease];
}

- (Image*)imageDuplicate
{
    Image *imageCopy = [[self subImageInRect:subImageRectangle] retain];
    return [imageCopy autorelease];
}
- (void)setImageSizeToRender:(CGSize)aImageSize
{
    if (aImageSize.width < 0 || aImageSize.width > 100 || aImageSize.height < 0 || aImageSize.height > 100)
    {
        SLQLOG(@"ERROR - Image: Illegal %% provided to setImageSizeToRender 'width=%f, height=%f'", aImageSize.width, aImageSize.height);
        return;
    }
    
    imageSize.width = (originalImageSize.width / 100) * aImageSize.width;
	imageSize.height = (originalImageSize.height / 100) * aImageSize.height;
	
	// Calculate the width and height of the sub region this image is going to use.
	textureSize.width = (textureRatio.width * imageSize.width) + textureOffset.x;
	textureSize.height = (textureRatio.height * imageSize.height) + textureOffset.y;
    
    [self initializeImageDetails];
}


#pragma mark - 
#pragma mark Image Rendering

- (void)renderAtPoint:(CGPoint)aPoint
{
    [self renderAtPoint:aPoint scale:scale rotation:rotation];
}

- (void)renderAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation
{
    point = aPoint;
    scale = aScale;
    rotation = aRotation;
    dirty = YES;
    [self render];
}

- (void)renderCenteredAtPoint:(CGPoint)aPoint
{
    [self renderCenteredAtPoint:aPoint scale:scale rotation:rotation];
}

- (void)renderCenteredAtPoint:(CGPoint)aPoint scale:(Scale2f)aScale rotation:(float)aRotation
{
    scale = aScale;
    rotation = aRotation;
    point.x = aPoint.x - (imageSize.width * scale.x / 2);
    point.y = aPoint.y - (imageSize.height * scale.y / 2);
    
    dirty = YES;
    [self render];
}

- (void)renderCentered
{
    CGPoint pointCopy = point;
    
    point.x = point.x - (imageSize.width * scale.x / 2);
    point.y = point.y - (imageSize.height * scale.y / 2);
    
    dirty = YES;
    [self render];
    
    point = pointCopy;
}

- (void)render
{
    imageDetails->texturedColoredQuad->vertex1.vertexColor =
    imageDetails->texturedColoredQuad->vertex2.vertexColor =
    imageDetails->texturedColoredQuad->vertex3.vertexColor =
    imageDetails->texturedColoredQuad->vertex4.vertexColor = color;
    
    [sharedImageRenderManager addImageDetailsToRenderQueue:imageDetails];
    
    if (dirty)
    {
        loadIdentityMatrix(matrix);
        
        translateMatrix(matrix, point);
        
        if (flipHorizontally)
        {
            scaleMatrix(matrix, Scale2fMake(1, -1));
            translateMatrix(matrix, CGPointMake(-imageSize.width * scale.x, 0));
        }
        if (flipVertically)
        {
            scaleMatrix(matrix, Scale2fMake(1, -1));
            translateMatrix(matrix, CGPointMake(0, -imageSize.height * scale.y));
        }
        
        if (rotation)
        {
            rotateMatrix(matrix, rotationPoint, rotation);
        }
        
        if (scale.x != 1.0f || scale.y != 1.0f)
        {
            scaleMatrix(matrix, scale);
        }
        
        transformMatrix(matrix, imageDetails->texturedColoredQuad, imageDetails->texturedColoredQuadIVA);
        
        dirty = NO;
    }
}

@end


#pragma mark -
#pragma mark Private implementation

@implementation Image (Private)

- (void)initializeImage:(NSString *)aName filter:(GLenum)aFilter
{
    textureManager = [TextureManager sharedTextureManager];
    sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
    sharedGameController = [GameController sharedGameController];
    
    self.imageFileName = aName;
    self.texture = [textureManager textureWithFileName:aName filter:aFilter];
    
    textureName = texture.name;
    
    fullTextureSize.width = texture.width;
    fullTextureSize.height = texture.height;
    
    textureRatio.width = texture.textureRatio.width;
    textureRatio.height = texture.textureRatio.height;
    
    color = Color4fMake(1.0f, 1.0f, 1.0f, 1.0f);
    
    rotationPoint = CGPointZero;
    
    minMagFilter = aFilter;
    
    rotation = 0.0f;
    scale.x = 1.0f;
    scale.y = 1.0f;
    flipHorizontally = NO;
    flipVertically = NO;
}

- (void)initializeImageDetails
{
    if (!imageDetails)
    {
        imageDetails = calloc(1, sizeof(ImageDetails));
        imageDetails->texturedColoredQuad = calloc(1, sizeof(TexturedColoredQuad));
    }
    
    imageDetails->texturedColoredQuad->vertex1.geometryVertex = CGPointMake(0.0f, 0.0f);
    imageDetails->texturedColoredQuad->vertex2.geometryVertex = CGPointMake(imageSize.width, 0.0f);
    imageDetails->texturedColoredQuad->vertex3.geometryVertex = CGPointMake(0.0f, imageSize.height);
    imageDetails->texturedColoredQuad->vertex4.geometryVertex = CGPointMake(imageSize.width, imageSize.height);
    
    imageDetails->texturedColoredQuad->vertex1.textureVertex = CGPointMake(textureOffset.x, textureSize.height);
    imageDetails->texturedColoredQuad->vertex2.textureVertex = CGPointMake(textureSize.width, textureSize.height);
    imageDetails->texturedColoredQuad->vertex3.textureVertex = CGPointMake(textureOffset.x, textureOffset.y);
    imageDetails->texturedColoredQuad->vertex4.textureVertex = CGPointMake(textureSize.width, textureOffset.y);
    
    imageDetails->texturedColoredQuad->vertex1.vertexColor =
    imageDetails->texturedColoredQuad->vertex2.vertexColor =
    imageDetails->texturedColoredQuad->vertex3.vertexColor =
    imageDetails->texturedColoredQuad->vertex4.vertexColor = color;
    
    imageDetails->textureName = textureName;
    
    dirty = YES;
}

- (void)setPoint:(CGPoint)aPoint {
	point = aPoint;
	dirty = YES;
}

- (void)setRotation:(float)aRotation {
	rotation = aRotation;
	dirty = YES;
}

- (void)setScale:(Scale2f)aScale {
    scale = aScale;
	dirty = YES;
}

- (void)setFlipVertically:(BOOL)aFlip {
	flipVertically = aFlip;
	dirty = YES;
}

- (void)setFlipHorizontally:(BOOL)aFlip {
	flipHorizontally = aFlip;
	dirty = YES;
}

@end
