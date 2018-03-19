//
//  DCBatteryView.m
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCBatteryView.h"

@interface DCBatteryView()
{
    UIView *batteryView;
    UILabel *batteryLabel;
    CAShapeLayer *batteryLayer;
    CAShapeLayer *layer2;
    CGFloat w;
    CGFloat lineW;
}
@end

@implementation DCBatteryView
-(instancetype)initWithLineColor:(UIColor *)lineColor
{
    if(self = [super init])
    {
        _lineColor =  lineColor;
        [self Initialize];
        [self draw];
    }
    return self;
}
-(void)Initialize
{
    if(_lineColor == nil)
    {
        _lineColor = [UIColor blackColor];
    }
    _contentColor = _lineColor;
    _warningColor = _lineColor;

}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self Initialize];
        [self draw];
    }
    return self;
}
- (void)draw{
    //电池的宽度
    w = 25;
    //电池的x的坐标
    CGFloat x = 0;
    //电池的y的坐标
    CGFloat y = 0;
    //电池的线宽
    lineW = 1;
    //电池的高度
    CGFloat h = 10;
    
    //画电池
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:2];
    batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = lineW;
    batteryLayer.strokeColor = _lineColor.CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.layer addSublayer:batteryLayer];

    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w+1, y+h/3)];
    [path2 addLineToPoint:CGPointMake(x+w+1, y+h*2/3)];
    layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 2;
    layer2.strokeColor = _lineColor.CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.layer addSublayer:layer2];
    
    //绘制进度
    batteryView = [[UIView alloc]initWithFrame:CGRectMake(x+1,y+lineW, 0, h-lineW*2)];
    batteryView.layer.cornerRadius = 1;
    batteryView.backgroundColor = self.contentColor;
//    batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
    [self addSubview:batteryView];
    
    
    batteryLabel = [[UILabel alloc]initWithFrame:CGRectMake(x+w+5, y, 30, h)];
    batteryLabel.textColor = _lineColor;
    batteryLabel.textAlignment = NSTextAlignmentLeft;
    batteryLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:batteryLabel];
    
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    batteryLayer.strokeColor = _lineColor.CGColor;
    layer2.strokeColor = _lineColor.CGColor;
    batteryLabel.textColor = _lineColor;
}
-(void)setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor;
}
-(void)setWarningColor:(UIColor *)warningColor
{
    _warningColor = warningColor;
}

- (void)runProgress:(NSInteger)progressValue{
    
        CGRect frame = batteryView.frame;
        frame.size.width = (progressValue*(w-lineW*2))/100;
        batteryView.frame  = frame;
        batteryLabel.text = [[NSString stringWithFormat:@"%ld",(long)progressValue] stringByAppendingString:@"%"];
        
        if (progressValue<10) {
            batteryView.backgroundColor = self.warningColor;
//            batteryView.backgroundColor = [UIColor redColor];
        }else{
            batteryView.backgroundColor = self.contentColor;
//            batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
        }
}

@end
