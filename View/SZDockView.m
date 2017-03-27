//
//  SZDockView.m
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZDockView.h"
@interface SZDockView()
{
    
}
@end
@implementation SZDockView
-(instancetype)initWithItemArray:(NSArray *)itemArray
{
    //底座视图的CGRect
    const CGFloat dockX=0;
    //dockH定义在宏DefaultConfig
    const CGFloat dockY=kScreenHeight-kDockH;
    const CGFloat dockW=kScreenWidth;
    
    if (self=[super initWithFrame:CGRectMake(dockX, dockY, dockW, kDockH)])
    {
        //底座视图Item的个数
        NSInteger itemNum=[itemArray count];
        //每个Item的大小
        CGFloat itemW=dockW/itemNum;
        CGFloat itemH=kDockH;
        NSDictionary *itemDict=nil;
        for (NSUInteger i=0; i<itemNum; i++)
        {
            //添加Dock的dockItem
            CGRect itemFrame=CGRectMake(i*itemW, 0, itemW, itemH);
            SZDockItem* dockItem=[[SZDockItem alloc] initWithFrame:itemFrame];
            //设置dockItem的标签，便于在点击响应时处理对应点击
            dockItem.tag=i;
            //把dockItem添加到dockView
            [self addSubview:dockItem];
            //取出字典里doclItem的图片和名称
            itemDict=[itemArray objectAtIndex:i];
            NSString *itemTitle=[itemDict objectForKey:kItemTitleNormal];
            NSString *name1=[itemDict objectForKey:kItemImageNormal];
            UIImage *imageNormal=[UIImage imageNamed:name1];
            NSString *name2=[itemDict objectForKey:kItemImageHightLight];
            UIImage *imageHightLight=[UIImage imageNamed:name2];
            [dockItem setTitle:itemTitle forState:UIControlStateNormal];
            [dockItem setImage:imageNormal forState:UIControlStateNormal];
            [dockItem setImage:imageHightLight forState:UIControlStateSelected];
            //设置最初的选中dockItem为最左边的
            if (i==0)
            {
                dockItem.selected=YES;
                self.currentDockItem=dockItem;
            }
            //点击dockItem的响应Block
            [dockItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    return  self;
}
//切换选中的dockItem
-(void)setSelectedItem:(SZDockItem *)selecteDockItem
{
    self.currentDockItem.selected=NO;
    selecteDockItem.selected=!selecteDockItem.selected;
    self.currentDockItem=selecteDockItem;
}
-(void)itemClick:(SZDockItem*)dockItem
{
    //切换dockItem选中状态
    [self setSelectedItem:dockItem];
    NSLog(@"itemClick:tag=%ld",dockItem.tag);
    _itemClickBlock(dockItem.tag);
}
@end
