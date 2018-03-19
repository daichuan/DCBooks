//
//  DCHomeVC.m
//  DCBooks
//
//  Created by cheyr on 2018/3/15.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCHomeVC.h"
#import "Header.h"
#import "DCBookModel.h"
#import "DCPageVC.h"
#import "MJRefresh.h"

@interface DCHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray<DCBookModel *> *books;
@end


static NSString *const cellKey = @"cellKey";
@implementation DCHomeVC
#pragma mark  - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主页";
    [self loadData];
    
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
#pragma mark  - event

#pragma mark  - delegate
#pragma mark  - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellKey];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellKey];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DCBookModel *book = self.books[indexPath.row];
    cell.textLabel.text = book.name;
    return cell;
}
#pragma mark  - private
-(void)loadData
{
    //获取文件夹中的所有文件
    NSArray *fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:DCBooksPath error:nil];
    
    NSMutableArray *bookArr = [[NSMutableArray alloc]init];
    for (NSString *file in fileArr) {
        DCBookModel *book = [[DCBookModel alloc]init];
        book.path = [DCBooksPath stringByAppendingPathComponent:file];
        NSArray *arr = [file componentsSeparatedByString:@"."];
        book.name = arr.firstObject;
        book.type = arr.lastObject;
        [bookArr addObject:book];
    }
    self.books = [NSArray arrayWithArray:bookArr];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DCBookModel *book = self.books[indexPath.row];
    DCPageVC *vc = [[DCPageVC alloc]init];
    vc.filePath = book.path;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark  - public

#pragma mark  - setter or getter
-(UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
