//
//  SZDownloadTableCell.h
//  LalightL
//
//  Created by comfouriertech on 17/3/27.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZDownloadTableCell : UITableViewCell
@property (nonatomic,copy) void(^downloadBtnClickBlock)(NSInteger index);
-(void)cellViewWithArray:(NSArray*)array index:(NSInteger) index;
@end
