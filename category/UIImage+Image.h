//  techtion
//
//  Created by fsrk on 15/3/2.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
+ (UIImage *)fullscreenImageWithName:(NSString *)name;
// 返回一张已经经过拉伸处理的图片
+ (UIImage *)stretchImageWithName:(NSString *)name;
@end
