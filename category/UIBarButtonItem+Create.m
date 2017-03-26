//  techtion
//
//  Created by fsrk on 15/3/2.
//  Copyright (c) 2015年 fsrk. All rights reserved.
//

#import "UIBarButtonItem+Create.h"
#import "UIButton+Bg.h"
@implementation UIBarButtonItem (Create)

+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action tag:(NSUInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置所有状态下的背景图片
    CGSize btnSize = [btn setAllStateBg:icon];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = (CGRect){CGPointZero, btnSize};
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置所有状态下的背景图片
    CGSize btnSize = [btn setAllStateBg:icon];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = (CGRect){CGPointZero, btnSize};
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)icon target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置所有状态下的背景图片
    CGSize btnSize = icon.size;
    [btn setImage:icon forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = (CGRect){CGPointZero, btnSize};
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置所有状态下的背景图片
    CGSize btnSize = [btn setAllStateBg:icon];
    btn.bounds = (CGRect){CGPointZero, btnSize};
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按钮文字
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    // 按钮背景
    [btn setAllStateBg:bg];
    // 按钮边框
    btn.bounds= (CGRect){CGPointZero, size};
    // 监听器
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
