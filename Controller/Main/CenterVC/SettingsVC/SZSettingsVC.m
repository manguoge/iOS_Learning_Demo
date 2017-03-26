//
//  SZSettingsVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/23.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZSettingsVC.h"

@interface SZSettingsVC ()

@end

@implementation SZSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Settings", nil)];
    self.view.backgroundColor=HexRGB(kThemeColor);
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
