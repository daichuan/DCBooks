//
//  DCBatteryView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//


//最小宽度为55
#import <UIKit/UIKit.h>

@interface DCBatteryView : UIView
@property (nonatomic,strong) UIColor *contentColor;//填充颜色 默认与lineColor颜色相同
@property (nonatomic,strong) UIColor *warningColor;//电量低于10%的填充颜色，默认与填充颜色相同
@property (nonatomic,strong) UIColor *lineColor;
-(instancetype)initWithLineColor:(UIColor *)lineColor;
- (void)runProgress:(NSInteger)progressValue;
@end
