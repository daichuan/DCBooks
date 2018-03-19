//
//  DCPageBottomView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum: NSUInteger{
    DCSetupFontTypeAdd,
    DCSetupFontTypeSubtract ,
}DCSetupFontType;

@protocol DCPageBottomViewDelegate<NSObject>

-(void)readModeClick:(UIButton *)btn;
-(void)listClick:(UIButton *)btn;
-(void)setUpFontClick:(DCSetupFontType)type;

@end


@interface DCPageBottomView : UIView
@property (nonatomic,weak) id<DCPageBottomViewDelegate> delegate;
@end
