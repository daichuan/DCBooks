//
//  DCFlipAnimation.h
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

typedef enum : NSUInteger {
    AnimationSubTypeFromRight,
    AnimationSubTypeFromLeft,
    AnimationSubTypeFromTop,
    AnimationSubTypeFromBottom,
}AnimationSubType;
@interface DCFlipAnimation : NSObject
+ (void)transitionWithType:(AnimationType) type withSubType:(AnimationSubType)subtype ForView:(UIView *)view;


@end
