//
//  SZDockItem.m
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZDockItem.h"

@implementation SZDockItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        //设置title属性
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:14.0];
        self.titleLabel.textColor=[UIColor blueColor];
        // 2.设置图片属性
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        self.backgroundColor = HexRGB(0x323341);
        
    }
    return self;
}
//重写方法，重新布置Button的ImageView的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width* kImageRatio, contentRect.size.height*0.2, contentRect.size.width*(1-kImageRatio), contentRect.size.height*0.6 );
}

//重写方法，重新布置Button的Title的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(12, contentRect.size.height*0.2, contentRect.size.width* kImageRatio, contentRect.size.height*0.6 );
}
@end
