//
//  DCPageTopView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  DCPageTopView;
@protocol DCPageTopViewDelegate<NSObject>

-(void)backInDCPageTopView:(DCPageTopView *)topView;

@end

@interface DCPageTopView : UIView
@property (nonatomic,weak) id<DCPageTopViewDelegate> delegate;
@end
