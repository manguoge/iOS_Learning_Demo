//
//  BFKit.h
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

/**
 *  Here is some useful defined variables
 */
#define BFKIT_VERSION @"1.0"

/**
 *  Get the iOS version
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

/**
 *  Get the screen width and height
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  Get some App info
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Foundation Additions
 */
#import "NSArray+BFKit.h"
#import "NSDate+BFKit.h"
#import "NSFileManager+BFKit.h"
#import "NSMutableArray+BFKit.h"
#import "NSNumber+BFKit.h"
#import "NSProcessInfo+BFKit.h"
#import "NSString+BFKit.h"

/**
 *  UIKit Additions
 */
#import "UIButton+BFKit.h"
#import "UIColor+BFKit.h"
#import "UIDevice+BFKit.h"
#import "UIFont+BFKit.h"
#import "UIImage+BFKit.h"
#import "UIImageView+BFKit.h"
#import "UILabel+BFKit.h"
#import "UIScrollView+BFKit.h"
#import "UITableView+BFKit.h"
#import "UITextField+BFKit.h"
#import "UIView+BFKit.h"
#import "UIWebView+BFKit.h"
#import "UIWindow+BFKit.h"

/**
 *  BFKit Classes
 */
#import "BFPassword.h"
#import "BFSystemSound.h"

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
