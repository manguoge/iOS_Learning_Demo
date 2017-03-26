//
//  SZGuideVC.h
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultConfig.h"
#import "SZMainVC.h"
@interface SZGuideVC : UIViewController<UIScrollViewDelegate>
@property (copy,nonatomic) void(^startByMainVCBlock)(void);
@end
