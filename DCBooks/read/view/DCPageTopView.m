//
//  DCPageTopView.m
//  DCBooks
//
//  Created by cheyr on 2018/3/14.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCPageTopView.h"
#import "SDAutoLayout.h"

@interface DCPageTopView()
@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation DCPageTopView

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
    
    self.backBtn.sd_layout
    .leftSpaceToView(self, 10)
    .bottomSpaceToView(self, 10)
    .widthIs(30)
    .heightIs(30);
}
-(void)setupUI
{
    [self addSubview:self.backBtn];
}

-(void)back
{
    if([self.delegate respondsToSelector:@selector(backInDCPageTopView:)])
    {
        [self.delegate backInDCPageTopView:self];
    }
}
-(UIButton *)backBtn
{
    if(_backBtn == nil)
    {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
@end
