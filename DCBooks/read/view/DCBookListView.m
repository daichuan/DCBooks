//
//  DCBookListView.m
//  DCBooks
//
//  Created by cheyr on 2018/3/16.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCBookListView.h"
#import "SDAutoLayout.h"
#import "Header.h"
@interface DCBookListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) UILabel        *headerView;
@property (nonatomic,strong) UIView         *backView;

@end


static NSString *const cellKey = @"cellKey";

@implementation DCBookListView
#pragma mark  - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupUI];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.backView addGestureRecognizer:tap];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.headerView.frame = CGRectMake(0, 0, self.width*0.8, is5_8inches?120: 80);
    self.tableView.frame = CGRectMake(0, is5_8inches?120: 80, self.width*0.8, self.height);
}
#pragma mark  - event

-(void)tap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-self.width*0.9, 0);
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
#pragma mark  - delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(bookListView:didSelectRowAtIndex:)])
    {
        [self.delegate bookListView:self didSelectRowAtIndex:indexPath.row];
    }
    //隐藏view
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-self.width*0.9, 0);
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellKey];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellKey];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

#pragma mark  - private
-(void)setupUI
{
    [self addSubview:self.tableView];
    [self addSubview:self.headerView];
    [self addSubview:self.backView];
}

#pragma mark  - public

#pragma mark  - setter or getter
-(void)setList:(NSArray *)list
{
    _list = list;
    [self.tableView reloadData];
}
-(UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

-(UILabel *)headerView
{
    if(_headerView == nil)
    {
        _headerView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width * 0.8, 80)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.text = @"目录";
        _headerView.textAlignment = NSTextAlignmentCenter;
        _headerView.font = [UIFont systemFontOfSize:20];
        _headerView.textColor = [UIColor grayColor];
    }
    return _headerView;
}
-(UIView *)backView
{
    if(_backView == nil)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(self.width*0.8, 0, self.width*0.2, self.height)];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

@end
