//
//  SZCenterVC.h
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZDockView.h"
#import "SZBalightVC.h"
#import "SZRidingVC.h"
#import "SZSettingsVC.h"
@interface SZCenterVC : UIViewController
//itemArray包含每个底座项的字典，字典包含图片和名称
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) UIViewController *curentSelectedVC;
@end
