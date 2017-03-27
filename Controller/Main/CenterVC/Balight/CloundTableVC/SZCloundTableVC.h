//
//  SZCloundTableVC.h
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface SZCloundTableVC : UITableViewController
singleton_interface(SZCloundTableVC)
@property (nonatomic,strong) NSMutableArray *photoArray;
@property (nonatomic,strong) NSMutableArray *photoList;

@end
