//
//  NSString+iphone.m
//  weightscale
//
//  Created by fsrk on 15/5/12.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import "NSString+iphone.h"

@implementation NSString (iphone)
- (NSString *)SETImage:(NSString *)append
{
    int height=(int) [UIScreen mainScreen].bounds.size.height;
    if(height==480){
        return append;
    }else if (height==568){
        return [NSString stringWithFormat:@"%@5",append];
    }else if (height==667){
        return [NSString stringWithFormat:@"%@6",append];
    }else if (height==736){
        return [NSString stringWithFormat:@"%@6_",append];
    }
    return [NSString stringWithFormat:@"%@",append];
}


- (NSString *)SETImage
{
    int height=(int) [UIScreen mainScreen].bounds.size.height;
    if(height==480){
        return self;
    }else if (height==568){
        return [NSString stringWithFormat:@"%@5",self];
    }else if (height==667){
        return [NSString stringWithFormat:@"%@6",self];
    }else if (height==736){
        return [NSString stringWithFormat:@"%@6_",self];
    }
    return [NSString stringWithFormat:@"%@",self];
}
@end
