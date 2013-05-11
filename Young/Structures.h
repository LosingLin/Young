//
//  Structures.h
//  Young
//
//  Created by ManYou on 13-4-25.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#ifndef Young_Structures_h
#define Young_Structures_h

#import <OpenGLES/ES1/gl.h>


//Structure to hold the x and y scale
typedef struct {
    float x;
    float y;
}Scale2f;

//Structure that defines the elements which make up a color
typedef struct {
    float red;
    float green;
    float bule;
    float alpha;
}Color4f;

// stores geometry, texture and color information for a single vertex
typedef struct {
    CGPoint geometryVertex;
    Color4f vertexColor;
    CGPoint textureVertex;
}TexturedColoredVertex;

//stores 4 TexturedColoredVetex struectures needed to defin a quad
typedef struct {
    TexturedColoredVertex vertex1;
    TexturedColoredVertex vertex2;
    TexturedColoredVertex vertex3;
    TexturedColoredVertex vertex4;
}TexturedColoredQuad;

//stores information about each image which is created. texturedColoredQuad
//holds the original zero origin quad for the image and the texturedColoredIVA
//holds a pointer to the iamges entry within the IVA
typedef struct {
    TexturedColoredQuad *texturedColoredQuad;
    TexturedColoredQuad *texturedColoredQuadIVA;
    GLuint textureName;
    NSUInteger renderIndex;
}ImageDetails;



#endif
