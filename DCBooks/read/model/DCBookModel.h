//
//  DCBookModel.h
//  DCBooks
//
//  Created by cheyr on 2018/3/15.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCBookModel : NSObject
@property (nonatomic,copy) NSString *name;//文件名
@property (nonatomic,copy) NSString *path;//文件路径
@property (nonatomic,copy) NSString *type;//文件类型
@end
