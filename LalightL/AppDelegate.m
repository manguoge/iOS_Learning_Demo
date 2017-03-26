//
//  AppDelegate.m
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window=window;
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:HexRGB(kThemeColor)];
    //1.判断是否是第一次登陆，显示导航页
    //1.1取出沙盒存储的上一版本号
    NSString *versionKey=(NSString*)kCFBundleVersionKey;
    NSString* lastVersionNum=[[NSUserDefaults standardUserDefaults] stringForKey:versionKey];
    //1.2取出plist文件的当前版本号
    NSString *currentVersionNum=[[[NSBundle mainBundle] infoDictionary] objectForKey:versionKey];
    
    //1.3非第一次登陆
    if ([lastVersionNum isEqualToString:currentVersionNum])
    {
        NSLog(@"不是第一次登陆：%@，%@",lastVersionNum,currentVersionNum);
        [self startByMainVC];
    }
    //1.4第一次登陆
    else
    {
        NSLog(@"第一次登陆：%@，%@",lastVersionNum,currentVersionNum);
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionNum forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SZGuideVC *guideVC=[[SZGuideVC alloc] init];
        guideVC.startByMainVCBlock=^void()
        {
            [self startByMainVC];
        };
        self.window.rootViewController=guideVC;
    }
    return YES;
}

-(void)startByMainVC
{
    SZLeftVC *leftVC=[[SZLeftVC alloc] init];
    SZCenterVC *centerVC=[[SZCenterVC alloc] init];
    //将leftVC和centerVC保存在Applegate
    self.leftVC=leftVC;
    self.centerVC=centerVC;
    SZMainVC *mainVC=[[SZMainVC alloc] initWithLeftVC:leftVC andCenterVC:centerVC];
    self.mainVC=mainVC;
    self.window.rootViewController=mainVC;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LalightL"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
