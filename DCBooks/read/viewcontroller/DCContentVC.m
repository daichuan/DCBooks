//
//  DCContantVC.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCContentVC.h"
#import "Header.h"
#import "SDAutoLayout.h"
#import <objc/runtime.h>
#import "DCBatteryView.h"
@interface DCContentVC ()
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *bottomRightL;
@property (nonatomic,strong) UILabel *bottomLeftL;
@property (nonatomic,assign) NSInteger index;//页数
@property (nonatomic,assign) NSInteger totalPages;//总页数
@property (nonatomic,strong) DCBatteryView *battery;
@property (nonatomic,strong) UIColor *otherTextColor;
@end

@implementation DCContentVC

#pragma mark  - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self Initialize];

    [self.view addSubview:self.textView];
    [self.view addSubview:self.bottomRightL];
    [self.view addSubview: self.bottomLeftL];
    [self.view addSubview:self.battery];
    
    [self.battery runProgress:[self getCurrentBatteryLevel]];
    
   

}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.textView.frame = CGRectMake(20, is5_8inches?60:40, 0, 0);
    self.textView.size = kContentSize;
    self.battery.frame = CGRectMake(kScreenW - 75,is5_8inches?15:10, 60, 20);
    self.bottomRightL.frame = CGRectMake(kScreenW*0.5,is5_8inches?kScreenH - 50: kScreenH - 30, kScreenW*0.5 - 15, 20);
    self.bottomLeftL.frame = CGRectMake(15, is5_8inches?kScreenH - 50: kScreenH - 30, kScreenW *0.5 - 15, 20);
    
}

#pragma mark  - event

#pragma mark  - delegate

#pragma mark  - notification

#pragma mark  - private
-(void)Initialize
{
    _otherTextColor = [UIColor grayColor];
}
-(void)updateUI
{
    NSString *readMode = [[NSUserDefaults standardUserDefaults] objectForKey:DCReadMode];
    if([readMode isEqualToString:DCReadDefaultMode])
    {
        self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:244/255.0 blue:233/255.0 alpha:1];
        [self.content addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, self.content.length)];
        self.textView.attributedText = self.content;
        self.bottomLeftL.textColor = [UIColor grayColor];
        self.bottomRightL.textColor = [UIColor grayColor];
        self.battery.lineColor = [UIColor grayColor];

    }else
    {
        self.view.backgroundColor = [UIColor colorWithRed:109/255.0 green:109/255.0 blue:111/255.0 alpha:1];
        [self.content addAttribute:NSForegroundColorAttributeName value:[UIColor lightTextColor] range:NSMakeRange(0, self.content.length)];
        self.textView.attributedText = self.content;
        self.bottomLeftL.textColor = [UIColor lightTextColor];
        self.bottomRightL.textColor = [UIColor lightTextColor];
        self.battery.lineColor = [UIColor lightTextColor];
    }
}
- (CGFloat)getCurrentBatteryLevel
{
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}
#pragma mark  - public
-(void)setIndex:(NSInteger)index totalPages:(NSInteger)totalPages
{
    _index = index;
    _totalPages = totalPages;
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",index];
    NSString *totalPagesStr = [NSString stringWithFormat:@"%ld",totalPages];
    float progress = indexStr.floatValue / totalPagesStr.floatValue;
    self.bottomLeftL.text = [NSString stringWithFormat:@"本章进度%.1lf%%",progress*100];
    self.bottomRightL.text = [NSString stringWithFormat:@"%ld/%ld",index,totalPages];
}

#pragma mark  - setter or getter
-(void)setContent:(NSMutableAttributedString *)content
{
    _content = content;
    self.textView.attributedText = content;
    //更新UI
    [self updateUI];
}
-(void)setText:(NSString *)text
{
    _text = text;
    self.textView.text = text;
}

-(UITextView *)textView
{
    if(_textView == nil)
    {
        _textView = [[UITextView alloc]init];
        _textView.font = DCDefaultTextFont;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.selectable = NO;
        //一定要设置为0，不然计算出的文字不能全部显示出来
        _textView.textContainerInset = UIEdgeInsetsZero;

    }
    return _textView;
}
-(DCBatteryView *)battery
{
    if(_battery == nil)
    {
        _battery = [[DCBatteryView alloc]initWithLineColor:[UIColor grayColor]];
    }
    return _battery;
}
-(UILabel *)bottomLeftL
{
    if(_bottomLeftL == nil)
    {
        _bottomLeftL = [[UILabel alloc]init];
        _bottomLeftL.textAlignment = NSTextAlignmentLeft;
        _bottomLeftL.textColor = [UIColor grayColor];
        _bottomLeftL.font = [UIFont systemFontOfSize:12];
    }
    return _bottomLeftL;
}
-(UILabel *)bottomRightL
{
    if(_bottomRightL == nil)
    {
        _bottomRightL = [[UILabel alloc]init];
        _bottomRightL.textAlignment = NSTextAlignmentRight;
        _bottomRightL.textColor = [UIColor grayColor];
        _bottomRightL.font = [UIFont systemFontOfSize:12];
    }
    return _bottomRightL;
}

@end
