//
//  SZBalightVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/23.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZBalightVC.h"
#import "AppDelegate.h"
#import "SZImageTool.h"
#import "SZCollectionViewCell.h"
#import "SZCloundTableVC.h"
//每列显示的图书视图数
#define columnNum 3
@interface SZBalightVC ()
{
    NSArray *_imageArray;
}
@end
static NSString *cellID=@"cellID";
@implementation SZBalightVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Smart", nil)];
    self.view.backgroundColor=HexRGB(kThemeColor);
    //设置导航条左按钮
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseLeftVC)];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [self addCollectionView];

    
}
////添加ScrollView，作为图片容器,ScrollView容器里存储图片视图列表
-(void)addCollectionView
{
    //1通过图片工具单例获取归档的图片模型的数组
    NSArray *imageArray=[[SZImageTool sharedSZImageTool] allImageModel];
    _imageArray=imageArray;
    //1图片视图的宽及高
    CGFloat imageViewWidth = 100;
    //列间距
    CGFloat marginX = (kScreenWidth- (imageViewWidth*3))/4;
    //行间距
    CGFloat marginY=5;
    //图片视图的配置信息
    NSDictionary *vModelConfig = @{@"startX": [NSNumber numberWithFloat:marginX],
                                   @"startY": [NSNumber numberWithFloat:0],
                                   @"marginX": [NSNumber numberWithFloat:marginX],
                                   @"marginY":[NSNumber numberWithFloat:marginY],
                                   @"viewWdith": [NSNumber numberWithFloat:imageViewWidth],
                                   @"viewHeight": [NSNumber numberWithFloat:imageViewWidth],
                                   @"iconName": imageArray,
                                   @"iconNumber": [NSNumber numberWithFloat:3],
                                   @"iconNormal": @"",
                                   @"iconHigh": @""
                                   };

    //2.采用网格视图作为图片视图容器
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 135, kScreenWidth, kScreenHeight-64-135-kDockH)collectionViewLayout:flowLayout];
    //设置重用cellID
    [collectionView registerClass:[SZCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    //设置布局属性
    flowLayout.itemSize=CGSizeMake(imageViewWidth, imageViewWidth);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset=UIEdgeInsetsMake(marginY, marginX, marginY, marginX);
    [self.view addSubview:collectionView];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell)
    {
        cell=[[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor=[UIColor yellowColor];
    if (indexPath.row==0)
    {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
        lable.backgroundColor=[UIColor blueColor];
        lable.text=@"点我入云";
        lable.textAlignment=NSTextAlignmentCenter;
        [cell addSubview:lable];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section=%ld,row=%ld",indexPath.section,indexPath.row);
    if (indexPath.row==0)
    {
        SZCloundTableVC *cloundTableVC=[SZCloundTableVC sharedSZCloundTableVC];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:cloundTableVC];
        AppDelegate *TempAppDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        [TempAppDelegate.mainVC presentViewController:nav animated:YES completion:nil];
    }
}
@end
