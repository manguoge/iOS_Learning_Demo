//
//  SZCenterVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZCenterVC.h"
//底座项Item的数量
#define kItemNum 3
@interface SZCenterVC ()

@end

@implementation SZCenterVC
-(instancetype)init
{
    if (self=[super init])
    {
        //1初始化底座并添加到MainVC视图底部
        //1.1重写itemArraygetter方法，初始化底座每个dockItem的信息,存储到素数组
        NSMutableArray *itemArray=[self itemArray];
        //1.2初始化底座dockView
        SZDockView* dockView=[[SZDockView alloc] initWithItemArray:itemArray];
        //1.3添加底座到MainVC
        [self.view addSubview:dockView];
        //2.1初始化底座切换的所有控制器
        SZBalightVC *balightVC=[[SZBalightVC alloc] init];
        SZRidingVC *ridingVC=[[SZRidingVC alloc] init];
        SZSettingsVC *settingsVC=[[SZSettingsVC alloc] init];
        //2.2将所有切换控制器添加到MainVC的子控制器，此处重写添加子控制器方法addChildViewController，为每个控制器添加导航控制器
        [self addChildViewController:balightVC];
        [self addChildViewController:ridingVC];
        [self addChildViewController:settingsVC];
        //2.3设置初始选中的控制器为最左边控制器
        [self selectdItem:0];
        //3.点击某doxkItem，处理界面跳转
        __block SZCenterVC *blockSelf=self;//避免循环引用
        dockView.itemClickBlock=^(NSUInteger tag)
        {
            NSLog(@"itemClickBlock:tag=%ld",tag);
            [blockSelf selectdItem:tag];
        };
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setNavigationTheme];
    
}
//重写itemArray的getter方法，初始化dokItem的数组信息
-(NSMutableArray*)itemArray
{
    NSMutableArray *itemArray=[[NSMutableArray alloc] initWithCapacity:kItemNum];
    
    NSDictionary *itemDict1=[[NSDictionary alloc] initWithObjectsAndKeys:@"balight_btn",kItemImageNormal,@"balight_btn_hl",kItemImageHightLight,NSLocalizedString(@"Smart", ni),kItemTitleNormal, nil];
    [itemArray addObject:itemDict1];
    NSDictionary *itemDict2=[[NSDictionary alloc] initWithObjectsAndKeys:@"riding_btn",kItemImageNormal,@"riding_btn_hl",kItemImageHightLight,NSLocalizedString(@"Run", nil),kItemTitleNormal, nil];
    [itemArray addObject:itemDict2];
    NSDictionary *itemDict3=[[NSDictionary alloc] initWithObjectsAndKeys:@"setting_btn",kItemImageNormal,@"setting_btn_hl",kItemImageHightLight,NSLocalizedString(@"Settings", nil),kItemTitleNormal, nil];
    [itemArray addObject:itemDict3];
    return itemArray;
}

#pragma mark 设置导航栏主题
- (void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    //[navBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor yellowColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:20],
                                     NSShadowAttributeName : shadow
                                     }];
}

//选中的某个dockItem切换控制器方法
-(void)selectdItem:(NSUInteger)tag
{
    UIViewController *newSelectedVC=self.childViewControllers[tag];
    //如果新选中的dockItem和之前选中的一样，则直接返回
    if ([newSelectedVC isEqual:self.curentSelectedVC]) return;
    else
    {
        //1移除之前选中的控制器的视图
        [self.curentSelectedVC.view removeFromSuperview];
        //2添加新选中的控制器的视图
        CGRect mainVCViewFrame=CGRectMake(0, 0, kScreenWidth, kScreenHeight-dockH);
        newSelectedVC.view.frame=mainVCViewFrame;
        [self.view addSubview:newSelectedVC.view];
        //3更改选中的控制器为新选中的
        self.curentSelectedVC=newSelectedVC;
        
    }
}
#pragma mark 重写父类方法addChildViewController:，添加一个带导航控制器的子控制器
-(void)addChildViewController:(UIViewController *)childController
{
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:childController];
    [super addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
