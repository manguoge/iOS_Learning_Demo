//
//  SZDockView.h
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//
/*
 输入底座信息自动，生成底座视图
 */
#import <UIKit/UIKit.h>
#import "SZDockItem.h"
@interface SZDockView : UIView
@property (nonatomic,copy) void(^itemClickBlock)(NSUInteger tag);
@property (nonatomic,weak) SZDockItem *currentDockItem;
-(instancetype)initWithItemArray:(NSArray*)itemArray;
-(void)setSelectedItem:(SZDockItem*)selecteDockItem;
@end
