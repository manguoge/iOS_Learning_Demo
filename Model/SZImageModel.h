//
//  SZImageModel.h
//  LalightL
//
//  Created by comfouriertech on 17/3/26.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZImageModel : NSObject<NSCoding>
// 1.id
@property (nonatomic,copy) NSString *imageID;
// 2.filename
@property (nonatomic,copy) NSString *imageName;
// 3.filename
@property (nonatomic,copy) NSString *imagePath;
//@property (nonatomic,copy) NSString *image_data;
@property (nonatomic,copy) NSString *imageType; // 0为图片  1为路径
@property (nonatomic,copy) NSString *imageGIF;  // 0为图片  1为gif
@end
