//
//  DCFlipAnimation.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//
/*
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
 */

#import "DCFlipAnimation.h"

@implementation DCFlipAnimation
#pragma mark CATransition动画实现
/**
 *  动画效果实现
 */
+(void)transitionWithType:(AnimationType)type withSubType:(AnimationSubType)subtype ForView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    switch (type) {
        case Fade:
            animation.type = kCATransitionFade;
            break;
        case Push:
            animation.type = kCATransitionPush;
            break;
        case Reveal:
            animation.type = kCATransitionReveal;
            break;
        case MoveIn:
            animation.type = kCATransitionMoveIn;
            break;
        case Cube:
            animation.type = @"cube";
            break;
        case SuckEffect:
            animation.type = @"suckEffect";
            break;
        case OglFlip:
            animation.type = @"oglFlip";
            break;
        case RippleEffect:
            animation.type = @"rippleEffect";
            break;
        case PageCurl:
            animation.type = @"pageCurl";
            break;
        case PageUnCurl:
            animation.type = @"pageUnCurl";
            break;
        case CameraIrisHollowOpen:
            animation.type = @"cameraIrisHollowOpen";
            break;
        case CameraIrisHollowClose:
            animation.type = @"cameraIrisHollowClose";
            break;
        case FlipFromLeft:
            animation.type = @"flipFromLeft";
            break;
        case FlipFromRight:
            animation.type = @"flipFromRight";
            break;
            
        default:
            break;
    }
    
    if (subtype) {
        switch (subtype) {
            case AnimationSubTypeFromLeft:
                animation.subtype = kCATransitionFromLeft;
                break;
            case AnimationSubTypeFromRight:
                animation.subtype = kCATransitionFromRight;
                break;
            case AnimationSubTypeFromTop:
                animation.subtype = kCATransitionFromTop;
                break;
            case AnimationSubTypeFromBottom:
                animation.subtype = kCATransitionFromBottom;
                break;
            default:
                break;
        }
    }
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) rootview {
    //创建CATransition对象

}
@end
