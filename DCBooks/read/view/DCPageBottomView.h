//
//  DCPageBottomView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCPageBottomViewDelegate<NSObject>

-(void)readModeClick:(UIButton *)btn;
-(void)listClick:(UIButton *)btn;

@end


@interface DCPageBottomView : UIView
@property (nonatomic,weak) id<DCPageBottomViewDelegate> delegate;
@end
