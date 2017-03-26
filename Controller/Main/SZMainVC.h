//
//  SZMainVC.h
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZLeftVC.h"
#import "SZCenterVC.h"
@interface SZMainVC : UIViewController
@property (nonatomic,strong) SZLeftVC *leftVC;
@property (nonatomic,strong) SZCenterVC *centerVC;
@property (nonatomic,assign) BOOL leftClosed;
-(instancetype)initWithLeftVC:(SZLeftVC*)leftVC andCenterVC:(SZCenterVC*)centerVC;
-(void)openLeftVC;
-(void)closeLeftVC;
@end
