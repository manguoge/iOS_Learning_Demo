//
//  Default.h
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//
//
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//手机设备的屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenSize [[UIScreen mainScreen] bounds].size

#define kThemeColor 0x20202c
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kItemImageNormal @"kItemImageNormal"
#define kItemImageHightLight @"kItemImageHightLight"
#define kItemTitleNormal @"kItemTitleNormal"
#define kItemTitleHightLight @"kItemTitleHightLight"

#define dockH 44

#define NSLocalizedString(key, comment) \
[NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]

//centerVC控制器视图缩放比例
#define kCenterVCScaleX 0.8
#define kCenterVCScaleY 0.8
#define kCenterVCRemainDis 100
//打开左侧窗时，中视图中心点
#define kCenterVCCenter  CGPointMake(kScreenWidth + kScreenWidth * kCenterVCScaleX / 2.0 - kCenterVCRemainDis, kScreenHeight / 2)

#define kUserLogin @"userlogin"
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]










