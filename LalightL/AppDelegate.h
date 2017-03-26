//
//  AppDelegate.h
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SZGuideVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic,strong) SZLeftVC *leftVC;
@property (nonatomic,strong) SZCenterVC *centerVC;
@property (nonatomic,strong) SZMainVC *mainVC;
- (void)saveContext;


@end

