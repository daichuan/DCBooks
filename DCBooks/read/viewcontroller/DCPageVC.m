//
//  DCPageVC.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCPageVC.h"
#import "DCContentVC.h"
#import "Header.h"
#import "DCPageTopView.h"
#import "DCPageBottomView.h"
#import "DCBookListView.h"
@interface DCPageVC () <UIPageViewControllerDelegate, UIPageViewControllerDataSource,DCPageBottomViewDelegate,DCPageTopViewDelegate,DCBookListViewDelgate,UIGestureRecognizerDelegate>
{
    CGSize _contentSize;
}
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic,copy) NSString *fontName;
@property (nonatomic,strong) DCPageTopView *topView;
@property (nonatomic,strong) DCPageBottomView *bottomView;
@property (nonatomic,strong) DCBookListView *listView;//目录视图

@property (nonatomic,strong) NSDictionary *attributeDict;
@property (nonatomic,assign) BOOL toolViewShow;
@property (nonatomic,assign) NSInteger currentIndex; //
@property (nonatomic,assign) NSInteger currentChapter;//当前章节
@property (nonatomic,strong) DCContentVC *currentVC;
@property (nonatomic,strong) NSArray *list; //目录
@property (nonatomic,strong) NSArray *chapterArr;//拆分成章节的数组
@property (nonatomic, strong) NSArray<NSMutableAttributedString *> *pageContentArray;

@end

@implementation DCPageVC

#pragma mark  - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化
    [self initialization];
    //加载数据
    [self loadData];
    
    //添加UI
    DCContentVC *contantVC = [self viewControllerAtIndex:_currentIndex];
    [self.pageViewController setViewControllers:@[contantVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    self.pageViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.listView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (BOOL)prefersStatusBarHidden
{
    if(self.toolViewShow)
    {
        return NO;
    }else
    {
        return YES;
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)initialization
{
//    NSString *page = [[NSUserDefaults standardUserDefaults] objectForKey:DCCurrentPage];
//    _currentIndex = page.integerValue;
    _currentIndex = 0;
    _currentChapter = 0;
    _contentSize = kContentSize;
    self.toolViewShow = NO;
}

#pragma mark  - event
-(void)tap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if(point.x < kScreenW * 0.3 || point.x > kScreenW * 0.7 || point.y <kScreenH * 0.3 || point.y > kScreenH * 0.7)
        return;
    if(self.toolViewShow)
    {
        //显示了则退回去
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.transform = CGAffineTransformIdentity;
            self.bottomView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            self.topView.hidden = YES;
            self.bottomView.hidden = YES;
        }];
    }else
    {
        //没显示则显示出来
        self.topView.hidden = NO;
        self.bottomView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.transform = CGAffineTransformMakeTranslation(0, toolH);
            self.bottomView.transform = CGAffineTransformMakeTranslation(0,-(toolH));
        }];
    }
    self.toolViewShow = !self.toolViewShow;
    //更新状态栏是不是显示
    [self setNeedsStatusBarAppearanceUpdate];
}
#pragma mark  - delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（就是击了tableViewCell），则不截获Touch事件（就是继续执行Cell的点击方法）
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
-(void)bookListView:(DCBookListView *)bookListView didSelectRowAtIndex:(NSInteger)index
{
    //跳转到对应章节
    _currentIndex = 0;
    _currentChapter = index;
    
    [self loadChapterContentWithIndex:_currentChapter];
    self.currentVC.content = self.pageContentArray[_currentIndex];
    
}
-(void)backInDCPageTopView:(DCPageTopView *)topView
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)listClick:(UIButton *)btn
{
    //隐藏了就显示出来
    self.listView.hidden = NO;

    //显示了则退回去
    [UIView animateWithDuration:0.3 animations:^{
        self.listView.transform = CGAffineTransformMakeTranslation(kScreenW * 0.8, 0);
        //显示了则退回去
        self.topView.transform = CGAffineTransformIdentity;
        self.bottomView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        self.topView.hidden = YES;
        self.bottomView.hidden = YES;
    }];
    self.toolViewShow = NO;
    //更新状态栏是不是显示
    [self setNeedsStatusBarAppearanceUpdate];
 
}
-(void)readModeClick:(UIButton *)btn
{
    NSArray *arr = self.pageViewController.viewControllers;
    if(arr.count != 1)
        return;
    DCContentVC *vc = self.pageViewController.viewControllers.firstObject;
    
    if(btn.selected)
    {
        [[NSUserDefaults standardUserDefaults] setObject:DCReadNightMode forKey:DCReadMode];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:DCReadDefaultMode forKey:DCReadMode];
    }
    [vc updateUI];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if(_currentIndex == 0 && _currentChapter == 0)
    {
        //第一章第一页
        return nil;
    }else if(_currentIndex == 0 && _currentChapter > 0)
    {
        //非第一章第一页，加载上一章的内容,
        _currentChapter--;
        [self loadChapterContentWithIndex:_currentChapter];
        _currentIndex = self.pageContentArray.count - 1;
    }else
    {
        //不是第一页，则页码减一
        _currentIndex--;
    }

    return [self viewControllerAtIndex:_currentIndex];
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if(_currentIndex >= self.pageContentArray.count && _currentChapter >= self.chapterArr.count)
    {
        //最后一章最后一页
        return nil;
    }else if(_currentIndex >= self.pageContentArray.count - 1 && _currentChapter <self.chapterArr.count)
    {
        //非最后一章的最后一页，加载下一章内容
        _currentChapter++;
        [self loadChapterContentWithIndex:_currentChapter];
        _currentIndex = 0;
    }else
    {
        //不是最后一页
        _currentIndex++;
    }
    
    return [self viewControllerAtIndex:_currentIndex];
}
#pragma mark  - notification

#pragma mark  - private
-(void)loadData
{
    NSString *string;
    if(self.filePath)
    {
        string = [DCFileTool transcodingWithPath:self.filePath];
    }
    
    self.list = [DCFileTool getBookListWithText:string];
    self.chapterArr = [DCFileTool getChapterArrWithString:string];
    self.listView.list = self.list;
    //加载第一章文字
    [self loadChapterContentWithIndex:_currentChapter];
    
}
-(void)loadChapterContentWithIndex:(NSInteger )index
{
    NSArray *arr =  [self pagingWithContentString:self.chapterArr[index] contentSize:_contentSize textAttribute:self.attributeDict];
    self.pageContentArray = arr;
}
-(NSArray *)pagingWithContentString:(NSString *)contentString contentSize:(CGSize)contentSize textAttribute:(NSDictionary *)textAttribute
{
    
    NSMutableArray *pageArray = [NSMutableArray array];
    NSMutableAttributedString *orginAttributeString = [[NSMutableAttributedString alloc]initWithString:contentString attributes:textAttribute];
    NSTextStorage *textStorage = [[NSTextStorage alloc]initWithAttributedString:orginAttributeString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [textStorage addLayoutManager:layoutManager];
    int i=0;
    while (YES) {
        i++;
        NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:contentSize];
        [layoutManager addTextContainer:textContainer];
        NSRange rang = [layoutManager glyphRangeForTextContainer:textContainer];
        
        if(rang.length <= 0)
        {
            break;
        }
        NSString *str = [contentString substringWithRange:rang];
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str attributes:textAttribute];
        [pageArray addObject:attstr];
    }
    
    return pageArray;
    
}
- (DCContentVC *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    DCContentVC *contentVC = [[DCContentVC alloc] init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    [contentVC setIndex:index totalPages:self.pageContentArray.count];

    self.currentVC = contentVC;
    return contentVC;
}

#pragma mark  - public

#pragma mark  - setter or getter
-(void)setToolViewShow:(BOOL)toolViewShow
{
    _toolViewShow = toolViewShow;
    self.pageViewController.view.userInteractionEnabled = !toolViewShow;
}
-(UIPageViewController *)pageViewController
{
    if(_pageViewController == nil)
    {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}
-(NSDictionary *)attributeDict
{
    if(_attributeDict == nil)
    {
        _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:20],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    }
    return _attributeDict;
}
-(DCPageTopView *)topView
{
    if(_topView == nil)
    {
        _topView = [[DCPageTopView alloc]initWithFrame:CGRectMake(0, -(toolH), kScreenW,toolH)];
        _topView.hidden = YES;
        _topView.delegate = self;
    }
    return _topView;
}
-(DCPageBottomView *)bottomView
{
    if(_bottomView == nil)
    {
        _bottomView = [[DCPageBottomView alloc]initWithFrame:CGRectMake(0, kScreenH , kScreenW, toolH)];
        _bottomView.hidden = YES;
        _bottomView.delegate = self;
    }
    return _bottomView;
    
}
-(DCBookListView *)listView
{
    if(_listView == nil)
    {
        _listView = [[DCBookListView alloc]initWithFrame:CGRectMake(-kScreenW * 0.8, 0, kScreenW,kScreenH)];
        _listView.hidden = YES;
        _listView.delegate = self;
    }
    return _listView;
}
@end
