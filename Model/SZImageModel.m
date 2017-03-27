//
//  SZImageModel.m
//  LalightL
//
//  Created by comfouriertech on 17/3/26.
//  Copyright © 2017年 ronghua_li. All rights reserved.
//

#import "SZImageModel.h"

@implementation SZImageModel
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.imageID=[aDecoder decodeObjectForKey:kImageID];
        self.imageName=[aDecoder decodeObjectForKey:kImageName];
        self.imagePath=[aDecoder decodeObjectForKey:kImagePath];
        self.imageType=[aDecoder decodeObjectForKey:kImageType];
        self.imageGIF=[aDecoder decodeObjectForKey:kImageGIF];
    }
    return  self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.imageID forKey:kImageID];
    [aCoder encodeObject:self.imageName forKey:kImageName];
    [aCoder encodeObject:self.imageType forKey:kImageType];
    [aCoder encodeObject:self.imagePath forKey:kImagePath];
    [aCoder encodeObject:self.imageGIF forKey:kImageGIF];
}
@end
