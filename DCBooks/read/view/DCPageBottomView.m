//
//  DCPageBottomView.m
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCPageBottomView.h"
#import "SDAutoLayout.h"
#import "Header.h"
@interface DCPageBottomView()
@property (nonatomic,strong) UIButton *listBtn;
@property (nonatomic,strong) UIButton *nightModeBtn;
@property (nonatomic,strong) UIButton *fontBtn;

@end


@implementation DCPageBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor darkGrayColor];
        [self setupUI];
        

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat btnW = 25;
    CGFloat btnH = btnW;
    CGFloat btnY = 20;

    self.listBtn.frame = CGRectMake(30, btnY, btnW, btnH);
    self.nightModeBtn.frame = CGRectMake(self.width*0.5 - 12, btnY, btnW, btnH);
    self.fontBtn.frame = CGRectMake(self.width - 30 - btnW, btnY, btnW, btnH);
}
-(void)setupUI
{
    [self addSubview:self.listBtn];
    [self addSubview:self.nightModeBtn];
    [self addSubview:self.fontBtn];
    
    NSString *readModel = [[NSUserDefaults standardUserDefaults] objectForKey:DCReadMode];
    if([readModel isEqualToString:DCReadNightMode])
    {
        self.nightModeBtn.selected = YES;
    }
}
//目录
-(void)list:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(listClick:)])
    {
        [self.delegate listClick:btn];
    }
}
//夜间模式
-(void)night:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if([self.delegate respondsToSelector:@selector(readModeClick:)])
    {
        [self.delegate readModeClick:btn];
    }
}
-(void)setupFont
{
    NSLog(@"setupFont");
}
-(UIButton *)listBtn
{
    if(_listBtn == nil)
    {
        _listBtn = [[UIButton alloc]init];
        [_listBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _listBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_listBtn addTarget:self action:@selector(list:) forControlEvents:UIControlEventTouchUpInside];
        [_listBtn setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
    }
    return _listBtn;
}
-(UIButton *)nightModeBtn
{
    if(_nightModeBtn == nil)
    {
        _nightModeBtn = [[UIButton alloc]init];
        _nightModeBtn.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);

        [_nightModeBtn addTarget:self action:@selector(night:) forControlEvents:UIControlEventTouchUpInside];
        [_nightModeBtn setImage:[UIImage imageNamed:@"read_default"] forState:UIControlStateNormal];
        [_nightModeBtn setImage:[UIImage imageNamed:@"read_night"] forState:UIControlStateSelected];

    }
    return _nightModeBtn;
}
-(UIButton *)fontBtn
{
    if(_fontBtn == nil)
    {
        _fontBtn = [[UIButton alloc]init];
        [_fontBtn setTitle:@"Aa" forState:UIControlStateNormal];
        [_fontBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fontBtn addTarget:self action:@selector(setupFont) forControlEvents:UIControlEventTouchUpInside];
        //        [_listBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _fontBtn;
}

@end
