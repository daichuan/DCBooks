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
@property (nonatomic,strong) UIButton *fontAddBtn;
@property (nonatomic,strong) UIButton *fontSubtractBtn;

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
    CGFloat btnSpace = (self.width - 25*4 - 15*2) / 3;

    self.listBtn.frame = CGRectMake(15, btnY, btnW, btnH);
    self.nightModeBtn.frame = CGRectMake(self.listBtn.right + btnSpace, btnY, btnW, btnH);
    self.fontAddBtn.frame = CGRectMake(self.nightModeBtn.right + btnSpace, btnY, btnW, btnH);
    self.fontSubtractBtn.frame = CGRectMake(self.fontAddBtn.right + btnSpace, btnY, btnW, btnH);
}
-(void)setupUI
{
    [self addSubview:self.listBtn];
    [self addSubview:self.nightModeBtn];
    [self addSubview:self.fontAddBtn];
    [self addSubview:self.fontSubtractBtn];
    
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
-(void)setupFont:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(setUpFontClick:)])
    {
        if(btn.tag == 10001)
        {
            [self.delegate setUpFontClick:DCSetupFontTypeAdd];
        }else
        {
            [self.delegate setUpFontClick:DCSetupFontTypeSubtract];
        }
    }
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
-(UIButton *)fontAddBtn
{
    if(_fontAddBtn == nil)
    {
        _fontAddBtn = [[UIButton alloc]init];
        [_fontAddBtn setTitle:@"A+" forState:UIControlStateNormal];
        _fontAddBtn.tag = 10001;
        [_fontAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fontAddBtn addTarget:self action:@selector(setupFont:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontAddBtn;
}
-(UIButton *)fontSubtractBtn
{
    if(_fontSubtractBtn == nil)
    {
        _fontSubtractBtn = [[UIButton alloc]init];
        [_fontSubtractBtn setTitle:@"A-" forState:UIControlStateNormal];
        _fontSubtractBtn.tag = 10002;
        [_fontSubtractBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fontSubtractBtn addTarget:self action:@selector(setupFont:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fontSubtractBtn;
}
@end
