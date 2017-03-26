//
//  UIButton+EnlargeEdge.h
//  shutter
//
//  Created by fsrk on 15/6/1.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
