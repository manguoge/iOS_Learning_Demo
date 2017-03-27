//
//  SZDownloadTableCell.m
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZDownloadTableCell.h"
#import "UIImageView+WebCache.h"
#import "SelectButton.h"
#import "UIButton+BFKit.h"
@implementation SZDownloadTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_bg.png"]];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, 60)];
        bgView.backgroundColor = HexRGB(kThemeColor);
        self.selectedBackgroundView = bgView;
    }
    return self;
}
-(void)cellViewWithArray:(NSArray*)array index:(NSInteger)index
{
    float iconWidth = 150;
    float betweenGap = (kScreenWidth - (iconWidth*2))/3;
    NSDictionary *vButtonConfig = @{@"startX": [NSNumber numberWithFloat:betweenGap],
                                   @"startY": [NSNumber numberWithFloat:5],
                                   @"marginX": [NSNumber numberWithFloat:betweenGap],
                                   @"marginY": [NSNumber numberWithFloat:5],
                                   @"viewWdith": [NSNumber numberWithFloat:iconWidth],
                                   @"viewHeight": [NSNumber numberWithFloat:iconWidth],
                                   @"iconName": array,
                                   @"iconNumber": [NSNumber numberWithFloat:2],
                                   @"rowIndex": [NSNumber numberWithFloat:index],
                                   @"iconHigh": @"balight_theme_02"
                                   };
    for (NSInteger i=0; i<array.count; i++)
    {
        CGFloat viewWdith = [[vButtonConfig objectForKey:@"viewWdith"] floatValue];
        CGFloat viewHeight = [[vButtonConfig objectForKey:@"viewWdith"] floatValue];
        //水平间距
        CGFloat marginX = [[vButtonConfig objectForKey:@"marginX"] floatValue];
        //垂直间距
        CGFloat marginY = [[vButtonConfig objectForKey:@"marginY"] floatValue];
        // 开始的y
        CGFloat startY = [[vButtonConfig objectForKey:@"startY"] floatValue];
        NSInteger rowIndex = [[vButtonConfig objectForKey:@"rowIndex"] integerValue];
        //2.icon 排布
        NSArray *nameArray = (NSArray *)[vButtonConfig objectForKey:@"iconName"];
        
        NSInteger count = [[vButtonConfig objectForKey:@"iconNumber"] floatValue];
        for (int i = 0; i < nameArray.count; i++) {
            //2.2 创建icon的view
            NSString *imagePath = [[nameArray objectAtIndex:i] objectForKey:@"shrinkPhotoPath"];
            NSString *imageID = [[nameArray objectAtIndex:i] objectForKey:@"photoId"];
            NSString *uploadTime = [[nameArray objectAtIndex:i] objectForKey:@"uploadTime"];
            uploadTime = [uploadTime substringToIndex:10];
            NSString *downloadCounts = [NSString stringWithFormat:@"%@", [[nameArray objectAtIndex:i] objectForKey:@"downloadCounts"]];
            UIImageView *imageViewBtn = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, viewWdith, viewWdith)];
            imageViewBtn.layer.masksToBounds = YES; //没这句话它圆不起来
            imageViewBtn.layer.cornerRadius = viewWdith/2.0; //设置图片圆角的尺度
            [imageViewBtn setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder.png"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
            // 2.5 设置x、y值
            // 开始的x(每一页的开始x都不一样)
            
            CGFloat startX = [[vButtonConfig objectForKey:@"startX"] floatValue];
            CGFloat x = startX + (i%count) * (viewWdith + marginX);
            CGFloat y = startY + (i/count) * (viewHeight + marginY);
            
            CGRect frame = imageViewBtn.frame;
            frame.origin.x = x;
            frame.origin.y = y;
            imageViewBtn.frame = frame;
            
            NSString *label  = NSLocalizedString(@"Download",@"");
            NSMutableArray *imageA = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kDownloadImage]];
            for (int e = 0; e < imageA.count; e++) {
                NSString *downloadId = [imageA objectAtIndex:e];
                if ([downloadId isEqualToString:imageID])
                {
                    label  = NSLocalizedString(@"Play",@"");break;
                }
            }
            SelectButton *downloadBtn = [SelectButton initWithFrame:CGRectMake(CGRectGetMinX(imageViewBtn.frame), CGRectGetMaxY(imageViewBtn.frame)+5, viewWdith, 45)  title:label backgroundImage:[UIImage imageNamed:@"Button_normal"]];
            [downloadBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            downloadBtn.tag = 2*rowIndex + i;
            //在主线程更新UI
            dispatch_sync(dispatch_get_main_queue(), ^
            {
                [self addSubview:imageViewBtn];
                [self addSubview:downloadBtn];
            });
            
        }
    }
    
}
-(void)selectButtonClick:(UIButton*)btn
{
    if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"Play",@"")])
    {
        return;
    }
    //[KVNProgress showKVNWithString:NSLocalizedString(@"Downloading...",@"")];
    if (_downloadBtnClickBlock) {
        _downloadBtnClickBlock(btn.tag);
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
