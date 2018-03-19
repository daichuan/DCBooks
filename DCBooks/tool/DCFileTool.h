//
//  DCFileTool.h
//  DCBooks
//
//  Created by cheyr on 2018/3/15.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DCFileTool : NSObject
+ (NSString *)getDocumentPath;
+ (NSString *)getCachePath;
+ (NSString *)getTmpPath;
/**创建根目录*/
+ (BOOL )creatRootDirectory;
/**根据文件路径，解析文件,utf8,GKB,GBK18030*/
+ (NSString *)transcodingWithPath:(NSString *)path;
/**从字符串中查找要找字符的位置（所有字符）*/
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
/**获取书籍目录列表*/
+ (NSMutableArray *)getBookListWithText:(NSString *)text;
/**将文件按章节分割*/
+ (NSMutableArray *)getChapterArrWithString:(NSString *)text;

@end
