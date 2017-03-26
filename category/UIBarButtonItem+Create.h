//  techtion
//
//  Created by fsrk on 15/3/2.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Create)
+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action tag:(NSUInteger)tag;
+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)icon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon;
@end
