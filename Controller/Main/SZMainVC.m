//
//  SZMainVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZMainVC.h"

@interface SZMainVC ()
@property (nonatomic,strong) UIPanGestureRecognizer* panGesture;

@end

@implementation SZMainVC
-(instancetype)initWithLeftVC:(SZLeftVC *)leftVC andCenterVC:(SZCenterVC *)centerVC
{
    if (self=[super init])
    {
        //做控制器视图状态为关闭
        self.leftClosed=YES;
        //添加左控制器视图和中间控制器视图到主控制器视图上
        [self.view addSubview:leftVC.tableView];
        [self.view addSubview:centerVC.view];
        self.leftVC=leftVC;
        self.centerVC=centerVC;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
//打开左控制器视图
-(void)openLeftVC
{
    //开启动画
    [UIView beginAnimations:nil context:nil];
    //中间视图左移并缩小为原来0.8倍
    self.centerVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,kCenterVCScaleX ,kCenterVCScaleY);
    self.centerVC.view.center=kCenterVCCenter;
    self.leftClosed=NO;
    //左边视图显示
   //self.leftVC.tableView.center=CGPointMake((kScreenWidth-kCenterVCRemainDis)*0.5, kScreenHeight*0.5);
    //self.leftVC.tableView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    //动画提交
    [UIView commitAnimations];
}
//关闭左控制器视图
-(void)closeLeftVC
{
    //开启动画
    [UIView beginAnimations:nil context:nil];
    //中间视图左移并缩小为原来0.8倍
    self.centerVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.centerVC.view.center=CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    self.leftClosed=YES;
    //左边视图显示
    //self.leftVC.tableView.center=CGPointMake((kScreenWidth-kCenterVCRemainDis)*0.5, kScreenHeight*0.5);
    //self.leftVC.tableView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    //动画提交
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
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
