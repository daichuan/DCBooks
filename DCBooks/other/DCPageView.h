//
//  DCPageView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCPageView : UIView
@property (nonatomic,strong) NSDictionary *attributeDict;//富文本样式
@property (nonatomic,strong) NSString *contentString;//文本内容
@property (nonatomic,assign) NSInteger currentPage;
-(void)updateAttributeDic:(NSDictionary *)attributeDic;//更新文本
-(BOOL)nextPage;
-(BOOL)lastPage;
@end
