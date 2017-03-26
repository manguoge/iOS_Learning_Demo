//
//  SZBalightVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/23.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZBalightVC.h"
#import "AppDelegate.h"
@interface SZBalightVC ()

@end

@implementation SZBalightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Smart", nil)];
    self.view.backgroundColor=HexRGB(kThemeColor);
    //设置导航条做按钮
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftVC)];
    self.navigationItem.leftBarButtonItem=leftBtn;
}
-(void)openOrCloseLeftVC
{
    AppDelegate *tempDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    SZMainVC *mainVC=tempDelegate.mainVC;
    if (mainVC.leftClosed)
    {
        [mainVC openLeftVC];
    }
    else
    {
        [mainVC closeLeftVC];
    }
}
@end
