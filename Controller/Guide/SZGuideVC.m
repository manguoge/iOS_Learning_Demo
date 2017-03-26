//
//  SZGuideVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/21.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//
/*
用法：初始化，设置页面数，更改图片
 */
#import "SZGuideVC.h"
//#import "Masonry.h"
//页面数
#define kGuidePageNum 3
@interface SZGuideVC ()
{
    UIScrollView *_guideScrollView;
    UIPageControl *_pageControl;
    UIPanGestureRecognizer  *_panGesture;
}
@end

@implementation SZGuideVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    //1.添加滚动视图ScrollView
    UIScrollView *guideScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-200)];
    guideScrollView.showsHorizontalScrollIndicator=YES;
    guideScrollView.pagingEnabled=YES;
    guideScrollView.scrollEnabled=YES;
    guideScrollView.delegate=self;
    _guideScrollView=guideScrollView;
    CGSize guideScrollViewSize=guideScrollView.frame.size;
    guideScrollView.contentSize=CGSizeMake(kGuidePageNum*guideScrollViewSize.width ,guideScrollViewSize.height);
    [self.view addSubview:_guideScrollView];
    //2.添加ImageView
    for (NSUInteger index=0; index<kGuidePageNum; index++)
    {
        [self addImageViewofIndex:index inView:_guideScrollView];
    }
    //3.添加PageControl
    UIPageControl *pageControl=[[UIPageControl alloc] init];
    pageControl.center=CGPointMake(kScreenWidth*0.5, kScreenHeight*0.95);
    //设置pageControl的页个数
    pageControl.numberOfPages=kGuidePageNum;
    //设置选中的颜色和默认的颜色
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor=[UIColor  yellowColor];
    _pageControl=pageControl;
    [self.view addSubview:_pageControl];
}
//在scrollView的Contentsize添加导航页面图片视图
-(void)addImageViewofIndex:(NSInteger)index inView:(UIScrollView*)guideScrollView
{
    CGSize guideScrollViewSize=guideScrollView.frame.size;
    //1.创建ImageView
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*guideScrollViewSize.width, 0, guideScrollViewSize.width, guideScrollViewSize.height)];
    imageView.userInteractionEnabled=YES;
    //2.设置Image
    NSString *name = [NSString stringWithFormat:@"%@%ld.png",@"welcome", index + 1];
    imageView.image = [UIImage imageNamed:name];
    //3.添加到滚动视图
    [guideScrollView addSubview:imageView];
    NSLog(@"index:%ld,%@",index,[UIImage imageNamed:name]);
   
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //页面滚动减速后设置pageConrtol的当前页点
    NSUInteger offsetNum=scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage=offsetNum;
    
    //如果是最后一幅图，启动滑动手势，滑动进入主控制器页面
    if (offsetNum==kGuidePageNum-1)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"offsetNum");
            UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEnterToManinVC)];
            panGesture.maximumNumberOfTouches=3;
            _panGesture=panGesture;
            _guideScrollView.multipleTouchEnabled=YES;
            _guideScrollView.userInteractionEnabled=YES;
            [_guideScrollView addGestureRecognizer:panGesture];
        });
        
    }
}
//最后一页导航视图滑动手势响应方法
-(void)panEnterToManinVC
{
    NSLog(@"panEnterToManinVC");
    //重置跟控制器
    _startByMainVCBlock();
//    SZMainVC *mainVC=[[SZMainVC alloc] init];
//    [self presentModalViewController:mainVC animated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
