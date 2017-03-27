//
//  SZImageTool.m
//  
//
//  Created by comfouriertech on 17/3/26.
//
//

#import "SZImageTool.h"
#define  kImageFileName @"image1file.data"
#define kImageSavePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kImageFileName]

@implementation SZImageTool
singleton_implementation(SZImageTool);
- (id)init
{
    if (self = [super init])
    {
        // 1.从文件中读取数据
        self.imageArray= [NSKeyedUnarchiver unarchiveObjectWithFile:kImageSavePath];
        //2.说明没有数据
        if (!self.imageArray)
        {
            self.imageArray = [[NSMutableArray alloc]init];
        }
    }
    return self;
}
- (id)initWithImageModelMessageArray:(NSArray *)array
{
    if (self=[super init])
    {
        self.imageArray=[[NSMutableArray alloc] init];
        for (NSInteger i=0; i<array.count; i++)
        {
            NSDictionary *imageMessageDict=[array objectAtIndex:i];
            SZImageModel *imageModel=[[SZImageModel alloc] init];
            imageModel.imageID=[imageMessageDict objectForKey:kImageID];
            imageModel.imageName=[imageMessageDict objectForKey:kImageName];
            imageModel.imageType=[imageMessageDict objectForKey:kImageType];
            imageModel.imagePath=[imageMessageDict objectForKey:kImagePath];
            imageModel.imageGIF=[imageMessageDict objectForKey:kImageGIF];
            [self.imageArray addObject:imageModel];
        }
        [NSKeyedArchiver archiveRootObject:self.imageArray toFile:kImageSavePath];
    }
    return self;
}
- (void)saveImageModel:(SZImageModel *)model
{
    //如果编号不合理，直接返回
    if (!model.imageID) return;
    //添加新数据，重新归档
    [self.imageArray  addObject:model];
    [NSKeyedArchiver archiveRootObject:self.imageArray toFile:kImageSavePath];
}

- (SZImageModel *)imageModelWithId:(NSInteger)index
{
    return [self.imageArray objectAtIndex:index];
}

- (NSMutableArray *)allImageModel
{
    return self.imageArray;
}
- (void)removeAllImageModel
{
    self.imageArray=nil;
    [NSKeyedArchiver archiveRootObject:self.imageArray toFile:kImageSavePath];
}
- (void)removeImageModelAtIndex:(NSInteger)index
{
    [self.imageArray removeObjectAtIndex:index];
    [NSKeyedArchiver archiveRootObject:self.imageArray toFile:kImageSavePath];
}

- (void)saveWithArray:(NSMutableArray *)array
{
    self.imageArray=array;
    [NSKeyedArchiver archiveRootObject:self.imageArray toFile:kImageSavePath];
}
@end
