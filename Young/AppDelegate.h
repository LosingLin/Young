//
//  AppDelegate.h
//  Young
//
//  Created by ManYou on 13-4-19.
//  Copyright (c) 2013年 ManYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAGLView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    EAGLView *glView;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end
