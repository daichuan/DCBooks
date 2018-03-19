//
//  ViewController.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

/*
 ###NSTextContainer
 //初始化方法 设置区块的尺寸
 - (instancetype)initWithSize:(CGSize)size;
 //与其绑定的layoutManager 需要注意，不是设置这个属性 使用[NSLayoutManager addTextContainer:]方式来进行绑定
 @property(nullable, assign, NS_NONATOMIC_IOSONLY) NSLayoutManager *layoutManager;
 //替换绑定的布局管理类对象
 - (void)replaceLayoutManager:(NSLayoutManager *)newLayoutManager;
 //获取区块尺寸
 @property(NS_NONATOMIC_IOSONLY) CGSize size;
 //设置从区块中剔除某一区域
 @property(copy, NS_NONATOMIC_IOSONLY) NSArray<UIBezierPath *> *exclusionPaths;
 //设置截断模式 需要注意 这个属性的设置只是会影响此区块的最后一行的截断模式
 @property(NS_NONATOMIC_IOSONLY) NSLineBreakMode lineBreakMode;
 //设置每行文本左右空出的间距
 @property(NS_NONATOMIC_IOSONLY) CGFloat lineFragmentPadding;
 //设置TextView上可输入的文本最大行数
 @property(NS_NONATOMIC_IOSONLY) NSUInteger maximumNumberOfLines;
 
 //这个方法用于提供给子类进行重写 这里返回的Rect是可以布局文本的区域
 - (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(nullable CGRect *)remainingRect;
 //这个BOOL值的属性决定Container的宽度是否自适应TextView的宽度
 @property(NS_NONATOMIC_IOSONLY) BOOL widthTracksTextView;
 //这个BOOL值的属性决定Container的高度是否自适应TextView的高度
 @property(NS_NONATOMIC_IOSONLY) BOOL heightTracksTextView;
 
 =====================================================================
 
 NSLayoutManager
 //container数组
 @property(readonly, NS_NONATOMIC_IOSONLY) NSArray<NSTextContainer *> *textContainers;
 //添加一个container
 - (void)addTextContainer:(NSTextContainer *)container;
 //在指定位置插入一个container
 - (void)insertTextContainer:(NSTextContainer *)container atIndex:(NSUInteger)index;
 //删除一个指定的container
 - (void)removeTextContainerAtIndex:(NSUInteger)index;
 //注意 这个方法不需要显式的调用 当布局Container发生变化时 系统会自动调用
 - (void)textContainerChangedGeometry:(NSTextContainer *)container;
 
 //是否显示隐形的符号
 默认为NO，如果设置为YES，则会将空格等隐形字符显示出来
@property(NS_NONATOMIC_IOSONLY) BOOL showsInvisibleCharacters;
//是否显示某些布局控制字符
@property(NS_NONATOMIC_IOSONLY) BOOL showsControlCharacters;
//这个属性可以用于设置断字
 这个属性的取值为0到1之间 默认为0 即单词换行时从来不会中断 越接近1 则使用连字符进行单词换行中断的概率越大
@property(NS_NONATOMIC_IOSONLY) CGFloat hyphenationFactor;
//是否使用字体定义的行距
 默认使用字体所定义的行距信息 通过设置这个属性为NO可以关闭此功能
@property(NS_NONATOMIC_IOSONLY) BOOL usesFontLeading;
//这个属性设置是否允许对相邻位置的内容进行布局 默认为YES，设置为NO后将可以提供大文本布局的效率
@property(NS_NONATOMIC_IOSONLY) BOOL allowsNonContiguousLayout;

//下面这几个方法用于移除某一范围内的布局
- (void)invalidateGlyphsForCharacterRange:(NSRange)charRange changeInLength:(NSInteger)delta actualCharacterRange:(nullable NSRangePointer)actualCharRange;
- (void)invalidateLayoutForCharacterRange:(NSRange)charRange actualCharacterRange:(nullable NSRangePointer)actualCharRange NS_AVAILABLE(10_5, 7_0);
- (void)invalidateDisplayForCharacterRange:(NSRange)charRange;
- (void)invalidateDisplayForGlyphRange:(NSRange)glyphRange;

 */

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "DCPageView.h"

@interface ViewController ()
{
    CGSize _contentSize;
    NSDictionary *_attributeDict;
    DCPageView *_pagingTextView;
    CGFloat _fontSize;
}
@property (nonatomic,copy) NSString *fontName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文本分隔";
    _contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame) - 30);
    _fontSize = 20;
    _fontName = @"PingFang SC";
    
    _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:self.fontName size:_fontSize]};
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    _pagingTextView = [[DCPageView alloc] initWithFrame:CGRectMake(10, 20, _contentSize.width, _contentSize.height)];
    _pagingTextView.attributeDict = _attributeDict;
    
    _pagingTextView.contentString = string;
    [self.view addSubview:_pagingTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setup
{
    
        //定义容器
        NSTextContainer *container = [[NSTextContainer alloc]initWithSize:CGSizeMake(kScreenW, 200)];
        //定义布局管理类
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
        //将container添加进布局管理类
        [layoutManager addTextContainer:container];
        //定义一个storage
        // 读取文本
        NSString *text = [NSString stringWithContentsOfFile:[NSBundle.mainBundle URLForResource:@"Text" withExtension:@"txt"].path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
        NSTextStorage *storage = [[NSTextStorage alloc]initWithString:text];
        [storage addLayoutManager:layoutManager];
    
       //将要显示的container与视图TextView绑定
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) textContainer:container];
    
        [self.view addSubview:textView];
}



@end
