//
//  SZCloundTableVC.m
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZCloundTableVC.h"
#import "UIBarButtonItem+Create.h"
#import "SZdownloader.h"
#import "SZDownloadTableCell.h"
@interface SZCloundTableVC ()
{
    NSString *_requestStringURL;
}
@end

@implementation SZCloundTableVC
singleton_implementation(SZCloundTableVC);
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor blackColor];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        self.title = NSLocalizedString(@"Cloud Pictures",@"");
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"back" target:self action:@selector(buttionClick:) tag:1];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //本类为单例，如果没有照片数组为空，则到网络加载
    if (self.photoArray.count)  return;
    else
    {
        [self auth];
    }
}
-(void)auth
{
    _requestStringURL=kCloudURL;
    NSURL *requestURL=[NSURL URLWithString:_requestStringURL];
    SZDownloader *downloader=[[SZDownloader alloc] initWithURL:requestURL timeout:6.0];
    [downloader startWithDownloading:^(float progressValue, NSInteger percentage)
    {
        NSLog(@"progressValue=%f,percentage=%ld",progressValue,percentage);
    } onFinished:^(NSData *fileData)
    {
        NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"jsonDict=%@",jsonDict);
        NSInteger result = [[jsonDict objectForKey:@"result"] integerValue];
        _photoArray = [[NSMutableArray alloc]init];
        NSMutableArray *temArray = [[NSMutableArray alloc]init];
        int u = 0;
        if (result == 0)
        {
            _photoList = [jsonDict objectForKey:@"photoList"];
            NSLog(@"photoList-%@",_photoList);
            for (int i = 0; i<_photoList.count; i++)
            {
                NSDictionary *dic = [_photoList objectAtIndex:i];
                if (u == 0)
                {
                    temArray = [[NSMutableArray alloc]init];
                }
                [temArray addObject:dic];
                if (u == 1)
                {
                    [_photoArray addObject:temArray];
                    u =0;continue;
                }
                u++;
                if (i == _photoList.count -1)
                {
                    [_photoArray addObject:temArray];
                    u = 0;
                }
            }
        }
        NSLog(@"_photoArray.count=%ld",_photoArray.count);
        [self.tableView reloadData];
        [downloader cancel];
    }
    onFail:^(NSError *error)
     {
        NSLog(@"auth error=%@",error);
        [downloader cancel];
        [self.tableView reloadData];
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Timeout",@"") message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil, nil] show];
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)buttionClick:(UIBarButtonItem*)btn
{
    switch (btn.tag)
    {
        case 1:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 2:
        {
            //NSLog(@"打开照相机");[self deleteIcon:sender];
        }
            break;
        default:
            break;
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identified = @"cell";
    SZDownloadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (cell == nil)
    {
    cell = [[SZDownloadTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identified];
    }
    //多线程处理cell加载
    //全局并发队列并异步提交任务
    //注意更新UI时回到主线程更新
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^
    {
        [cell cellViewWithArray:[_photoArray objectAtIndex:indexPath.row] index:indexPath.row];
        cell.downloadBtnClickBlock =  ^(NSInteger index)
        {
            NSLog(@"download icon = %ld",index);
            [self loadImageWithIndex:index];
        };
    });
    
    return cell;

}
-(void)loadImageWithIndex:(NSInteger) index
{
    NSString *sourePath = [[_photoList objectAtIndex:index] objectForKey:@"photoPath"];
    //NSString *photoId = [[_photoList objectAtIndex:index] objectForKey:@"photoId"];
    //NSString *fileName = [[_photoList objectAtIndex:index] objectForKey:@"photoName"];
    SZDownloader *downloader = [[SZDownloader alloc]initWithURL:[NSURL URLWithString:sourePath] timeout:6.];
    [downloader startWithDownloading:^(float progressValue, NSInteger percentage)
    {
    } onFinished:^(NSData *fileData)
    {
        NSLog(@"Image%ld Load sucessful!fileData=%@",index,fileData);
        //下载完保存到沙盒
    } onFail:^(NSError *error)
    {
        NSLog(@"getServerVersion error = %@",error.description);
        [downloader cancel];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
