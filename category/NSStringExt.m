//
//  NSStringExt.m
//

#import "NSStringExt.h"

@implementation NSString (NSStringExt)

- (BOOL)isValidateEmail
{
    if((0 != [self rangeOfString:@"@"].length) &&
       (0 != [self rangeOfString:@"."].length))
    {
        NSCharacterSet* tempInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tempInvalidMutableCharSet = [tempInvalidCharSet mutableCopy];
        [tempInvalidMutableCharSet removeCharactersInString:@"_-"];
        //使用compare option 来设定比较规则,如 //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数,而不比较字符串的字面值
        NSRange range1 = [self rangeOfString:@"@"options:NSCaseInsensitiveSearch];
        //取得用户名部分
        NSString* userNameString = [self substringToIndex:range1.location];
        NSArray* userNameArray = [userNameString componentsSeparatedByString:@"."];
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tempInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        NSString *domainString = [self substringFromIndex:range1.location+1]; NSArray *domainArray = [domainString componentsSeparatedByString:@"."];
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tempInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        return YES;
    }
    else // no ''@'' or ''.''present
        return NO;
}

-(BOOL)isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (NSString *)validateFormat
{
    NSString *formatStr;
    if ([self isValidateEmail]) {
        formatStr = @"email";
    }
    else if ([self isValidateMobile]){
        formatStr = @"phone";
    }
    else{
        formatStr = @"accountName";
    }
    
    return formatStr;
}


- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isConsistOfStrng:(NSString *)string
{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:string]; //invertedSet:反取字符
    return [self isConsistOfCharacterSet:cs];
}

- (BOOL)isConsistOfCharacterSet:(NSCharacterSet *)characterSet
{
    NSCharacterSet *cs = [characterSet invertedSet];    //invertedSet:反取字符
    NSString *tempStr = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:tempStr];
}

- (NSString *)filteredByString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:string] invertedSet]; //invertedSet:反取字符
#if __has_feature(objc_arc)
    __autoreleasing NSString *tempStr = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return  tempStr;
#else
    return [[[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""] autorelease];
#endif
}

- (NSString *)infilteredByString:(NSString *)string
{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:string];
#if __has_feature(objc_arc)
    __autoreleasing NSString *tempStr = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return  tempStr;
#else
    return [[[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""] autorelease];
#endif
}


- (NSString *)encryptWithMD5
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[16];
    CC_MD5(value, (unsigned int)strlen(value), outputBuffer);   //加密
    NSMutableString *mString = [NSMutableString string];
    for(int i = 0; i<16; i++) {
        [mString appendFormat:@"%02X",outputBuffer[i]];
    }
    return mString;
}

//base64编码
- (NSString*)base64{
	NSData *theData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
	const uint8_t* input = (const uint8_t*)[theData bytes];
	NSInteger length = [theData length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
	NSInteger i,i2;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
		for (i2=0; i2<3; i2++) {
            value <<= 8;
            if (i+i2 < length) {
                value |= (0xFF & input[i+i2]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (int)passwordType
{
    if ([self isConsistOfStrng:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] == NO) {
        return 2;
    }
    else{   //全部由数字和字母组成
        if ([self isConsistOfStrng:@"0123456789"] == YES) {
            return 3;
        }
        else if ([self isConsistOfStrng:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] == YES) {
            return 4;
        }
    }
    
    return 1;
}

+ (NSString *)verificationCode
{
    const int count = 4;
    char data[count];
    for (int x = 0; x < count; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *codeStr = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
    return codeStr;
}

+ (NSString *)errorPromptWithPage:(NSString *)page action:(NSString *)action code:(NSInteger)code
{
    NSString *promptStr = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ErrorCode" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dic != nil) {
        dic = [dic objectForKey:page];
        if (dic != nil) {
            dic = [dic objectForKey:action];
            if (dic != nil) {
                NSString *key = [NSString stringWithFormat:@"%ld",(long)code];
                promptStr = [dic objectForKey:key];
            }
        }
    }
    
    return promptStr.length > 0 ? promptStr : @"未知错误";
}
 /*
+ (void)sendVerificationCode:(NSString *)verificationCodeString phone:(NSString *)phoneNum completion:(void(^)(BOOL success)) completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CCPRestSDK* ccpRestSdk = [[CCPRestSDK alloc] initWithServerIP:@"app.cloopen.com" andserverPort:8883];
        [ccpRestSdk setApp_ID:@"aaf98f89481bd5a701481f55915800cb"];
        [ccpRestSdk enableLog:YES];
        [ccpRestSdk setAccountWithAccountSid: @"8a48b55147f223e10147f7b408fb0943" andAccountToken:@"796d15e29c134324bb885cdf8adeed0c"];
        NSArray*  arr = [NSArray arrayWithObjects:verificationCodeString,nil];
        NSMutableDictionary *dict = [ccpRestSdk sendTemplateSMSWithTo:phoneNum andTemplateId:@"4545" andDatas:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger statusCode = [[dict objectForKey:@"statusCode"] integerValue];
            if (statusCode == 0) {   //发送失败
                completion(YES);
            }
            else{   //发送成功
                completion(NO);
            }
        });
    });
    
    
   
     //通过http post方式请求发送验证码
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
     NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
     NSString *sigStr= [[NSString stringWithFormat:@"%@%@%@",@"8a48b55147a01adb0147a0a551530046", @"8c3cf355047041c7a7840b0ac8fe3258", dateStr] encryptWithMD5];
     NSString *authorizationStr = [[NSString stringWithFormat:@"8a48b55147a01adb0147a0a551530046:%@",dateStr] base64];
     dateStr = [dateFormatter stringFromDate:[NSDate date]];
     NSString *urlStr = [NSString stringWithFormat:@"https://sandboxapp.cloopen.com:8883/2013-12-26/Accounts/8a48b55147a01adb0147a0a551530046/SMS/Messages?sig=%@",sigStr];
     NSURL *url = [NSURL URLWithString:urlStr];
     NSString *content = [NSString stringWithFormat:@"{\"to\":\"%@\",\"appId\":\"aaf98f8947a0321a0147a0a7afb8005a\",\"templateId\":\"1\",\"datas\":[\"12AB\",\"60\"]}", _accountTextField.text];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
     [request setHTTPMethod:@"POST"];
     [request setValue:[NSString stringWithFormat:@"%ld", (long)content.length] forHTTPHeaderField:@"content-length"];
     [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
     [request setValue:authorizationStr forHTTPHeaderField:@"Authorization"];
     NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
     [request setHTTPBody:data];
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
     NSString *resultStr;
     if (connectionError == nil) {
     NSError *error;
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
     if (error == nil) {
     resultStr = [dic objectForKey:@"result"];
     }
     else{
     resultStr = [error localizedDescription];
     }
     }
     else{
     resultStr = [connectionError localizedDescription];
     }
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [timer invalidate];
     countDown = 0;
     sender.enabled = YES;
     [sender setTitle:@"发送" forState:UIControlStateNormal];
     
     //test-*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回结果" message:resultStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     [alert show];
     //test-**
     });
     }];
  
    
}
*/
- (NSData *)stringToHexData
{
    int len = (int)[self length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

/*
+ (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    // Encode all the reserved characters, per RFC 3986
    
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    NSString *outputStr = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            
                                            (CFStringRef)input,
                                            
                                            NULL,
                                            
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            
                                            kCFStringEncodingUTF8);
    
    return outputStr;
    
}

*/

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input

{
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

//2.UTF-8和Unicode转化
//Unicode转UTF-8

+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}



+(NSString *) utf8ToUnicode:(NSString *)string

{
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        
        unichar _char = [string characterAtIndex:i];
        
        //判断是否为英文和数字
        
        if (_char <= '9' && _char >= '0')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
        
        else if(_char >= 'a' && _char <= 'z')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
            
            
        }
        
        else if(_char >= 'A' && _char <= 'Z')
            
        {
            
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
            
            
        }
        
        else
            
        {
            
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            
        }
        
    }
    
    return s;
    
}

+ (NSString *)generateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *UUID = (__bridge_transfer NSString *)string;
    return [UUID substringToIndex:32];
}

@end

