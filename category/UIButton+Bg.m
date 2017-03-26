//  techtion
//
//  Created by fsrk on 15/3/2.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import "UIButton+Bg.h"
#import "UIImage+Image.h"
#import "NSString+File.h"
@implementation UIButton (Bg)
- (CGSize)setAllStateBg:(NSString *)icon
{
    UIImage *normal = [UIImage stretchImageWithName:icon];
    UIImage *highlighted = [UIImage stretchImageWithName:[icon filenameAppend:@"_up"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    return normal.size;
}
@end
