//
//  DCContantVC.h
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAutoLayout.h"

@interface DCContentVC : UIViewController
@property (nonatomic,copy) NSMutableAttributedString *content;//内容
@property (nonatomic,copy) NSString *text;
-(void)updateUI;//更新ui

-(void)setIndex:(NSInteger)index totalPages:(NSInteger)totalPages;
@end
