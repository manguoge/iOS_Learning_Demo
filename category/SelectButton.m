//
//  SelectButton.m
//  finder
//
//  Created by fsrk on 15/1/4.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//
#define kImageRatio 1.0
#import "SelectButton.h"

@implementation SelectButton


- (void)setHighlighted:(BOOL)highlighted {}



#pragma mark 返回是按钮内部UILabel的边框
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//    CGFloat titleY = contentRect.size.height * kImageRatio - 18;
    CGFloat titleY = contentRect.size.height + 28;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
    
}

#pragma mark 返回是按钮内部UIImageView的边框
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}



@end
