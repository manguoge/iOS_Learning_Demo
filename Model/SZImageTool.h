//
//  SZImageTool.h
//  
//
//  Created by comfouriertech on 17/3/26.
//
//

#import <Foundation/Foundation.h>
#import "SZImageModel.h"
#import "Singleton.h"
@interface SZImageTool : NSObject
@property (nonatomic,strong) NSMutableArray *imageArray;
singleton_interface(SZImageTool)
//用图片Model的信息初始化
- (id)initWithImageModelMessageArray:(NSArray *)array;
- (void)saveImageModel:(SZImageModel *)model;
- (NSMutableArray *)allImageModel;
- (SZImageModel *)imageModelWithId:(NSInteger)index;
- (void)removeAllImageModel;
- (void)removeImageModelAtIndex:(NSInteger)index;
- (void)saveWithArray:(NSMutableArray *)array;
@end
