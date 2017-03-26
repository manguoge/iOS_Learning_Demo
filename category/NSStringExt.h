//
//  NSStringExt.h
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//#import "CCPRestSDK.h"

@interface NSString (NSStringExt)

//判断是否可用做邮箱地址(可以判断类似jack...smith@qq..cmd.com的情况为非法)
- (BOOL)isValidateEmail;

//判断是否可用做手机号码
-(BOOL)isValidateMobile;

//返回字符串符合的格式(AccountName,PlateNumber,Email,Phone)
- (NSString *)validateFormat;

//判断字符串是否都是由string中的字符串组成(例如:判断一个字符串是否都是数字[str2则为"0123456789"]；是否都是字母[str2则为"abc...xyzABC...XYZ"])
- (BOOL)isConsistOfStrng:(NSString *)string;
- (BOOL)isConsistOfCharacterSet:(NSCharacterSet *)characterSet;


//删除在string中不存在的字符
- (NSString *)filteredByString:(NSString *)string;

//删除在string中存在的字符
- (NSString *)infilteredByString:(NSString *)string;

//判断字符串是否为整型
- (BOOL)isPureInt;

//判断字符串是否为浮点型
- (BOOL)isPureFloat;

//MD5加密文本
- (NSString *)encryptWithMD5;

//base64编码
- (NSString*)base64;

//返回密码的形式；1：由字母和数字组成、2：有其它字符、3：只由数字组成、4：只由字母组成
- (int)passwordType;

//产生随机验证码
+ (NSString *)verificationCode;

//根据请求页面、具体操作以及错误码，获取错误提示
+ (NSString *)errorPromptWithPage:(NSString *)page action:(NSString *)action code:(NSInteger)code;

//发送验证码
//+ (void)sendVerificationCode:(NSString *)verificationCodeString phone:(NSString *)phoneNum completion:(void(^)(BOOL success)) completion;

//转成16进制
- (NSData *)stringToHexData;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
+ (NSString*) replaceUnicode:(NSString*)aUnicodeString;
+(NSString *) utf8ToUnicode:(NSString *)string;
+ (NSString *)generateUUID;
@end



