//
//  SZLeftVC.h
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "SZUserInfoTVC.h"
#import "SZLoginTVC.h"
@interface SZLeftVC : UITableViewController
@property (nonatomic,strong) NSArray *cellItemArray;
singleton_interface(SZLeftVC);
@end
