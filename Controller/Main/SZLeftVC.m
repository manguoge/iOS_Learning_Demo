//
//  SZLeftVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/22.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZLeftVC.h"
#import "UIView+BFKit.h"
#import "UIImageView+BFKit.h"
#import "UIView+Additions.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
//宏定义cell的图片和名称的key
#define name @"name"
#define iconImage @"iconImage"

@interface SZLeftVC ()

@end

@implementation SZLeftVC
//单例初始化接口实现
singleton_implementation(SZLeftVC);
//初始化tableview的风格
- (id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]))
    {
        self.tableView.bounces = YES;
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftbackiamge"]];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor=HexRGB(kThemeColor);
    //表头部条件头部视图
    //左控制器表视图数据
    self.cellItemArray=@[
                         @[
                             @{name:NSLocalizedString(@"User Guide",@""),iconImage:@"userguide"},
                             @{name:NSLocalizedString(@"Feedback",@""),iconImage:@"feedback_icon"},
                             @{name:NSLocalizedString(@"About",@""),iconImage:@"about_icon"}
                             ]
                         ];
    
}

-(void)userIconTap:(UITapGestureRecognizer*)tapGesture
{
    
}

#pragma mark --tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_cellItemArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[_cellItemArray objectAtIndex:section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewCell:%ld",[indexPath row]);
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //设置cell的图片和名称
    NSDictionary *cellDict=[[_cellItemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *cellImageName=[cellDict objectForKey:iconImage];
    cell.imageView.image=[UIImage imageNamed:cellImageName];
    cell.textLabel.text=[cellDict objectForKey:name];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = HexRGB(kThemeColor);
    cell.tintColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = HexRGB(0xdcdeeb);
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])     {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 102;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"viewForHeaderInSection");
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    headerView.backgroundColor=[UIColor yellowColor];
    self.tableView.tableHeaderView=headerView;
    if (section==0)
    {
        
    }
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated

{
    [self.tableView reloadData];
}
@end
