//
//  DCPageView.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "DCPageView.h"
#import "DCFlipAnimation.h"
@interface DCPageView()
@property (nonatomic,strong) NSArray *textArray;
@property (nonatomic,strong) UITextView *textView;
@end

@implementation DCPageView
#pragma mark  - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addSubview:self.textView];
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

#pragma mark  - event
-(void)handleTap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    if(point.x > CGRectGetWidth(self.frame) * 0.6)
    {
        //下一页
        [self nextPage];
    }else if(point.x < CGRectGetWidth(self.frame) * 0.3)
    {
        [self lastPage];
    }else
    {
        
    }
}
#pragma mark  - delegate

#pragma mark  - notification

#pragma mark  - private
- (void)startPanging {
    
    _textArray = [self pagingWithContentString:_contentString contentSize:self.frame.size textAttribute:_attributeDict];
}

- (BOOL)nextPage{
    _currentPage ++;
    if (_currentPage < _textArray.count && _currentPage >= 0) {
        _textView.attributedText = _textArray[_currentPage];
        //翻页动画
        [DCFlipAnimation transitionWithType:PageCurl withSubType:AnimationSubTypeFromTop ForView:self];
        return YES;
    }
    _currentPage = _textArray.count - 1;
    return NO;
}
- (BOOL)lastPage {
    _currentPage --;
    if (_currentPage >= 0 && _currentPage < _textArray.count) {
        //翻页动画
        [DCFlipAnimation transitionWithType:PageUnCurl withSubType:AnimationSubTypeFromLeft ForView:self];
        _textView.attributedText = _textArray[_currentPage];
        return YES;
    }
    _currentPage = 0;
    return NO;
}
#pragma mark  - 分页
-(NSArray *)pagingWithContentString:(NSString *)contentString contentSize:(CGSize)contentSize textAttribute:(NSDictionary *)textAttribute
{
    NSMutableArray *pageArray = [NSMutableArray array];
    NSMutableAttributedString *orginAttributeString = [[NSMutableAttributedString alloc]initWithString:contentString attributes:textAttribute];
    NSTextStorage *textStorage = [[NSTextStorage alloc]initWithAttributedString:orginAttributeString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [textStorage addLayoutManager:layoutManager];
    
    while (YES) {
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
#pragma mark  - public
-(void)updateAttributeDic:(NSDictionary *)attributeDic
{
    _attributeDict = attributeDic;
    NSInteger startCharacterIndex = [self characterIndexWithPageNumber:_currentPage];
    [self startPanging];
    _currentPage = [self pageNumberWithCharacterIndex:startCharacterIndex];
    _textView.attributedText = _textArray[_currentPage];
    
}
// 这两个方法用于样式改变后定位当前页用的
- (NSInteger)characterIndexWithPageNumber:(NSInteger)pageNumber {
    NSInteger startCharacterIndex = 0;
    for (NSInteger index = 0; index < pageNumber; index ++) {
        NSAttributedString *attStr = _textArray[index];
        startCharacterIndex = startCharacterIndex + attStr.string.length;
    }
    return startCharacterIndex;
}
- (NSInteger)pageNumberWithCharacterIndex:(NSInteger)characterIndex {
    NSInteger totalCharacternNunmer = 0;
    if (characterIndex == 0) {
        return 0;
    }
    for (NSInteger index = 0; index < _textArray.count; index ++) {
        NSAttributedString *attStr = _textArray[index];
        totalCharacternNunmer = totalCharacternNunmer + attStr.string.length;
        
        if (totalCharacternNunmer - characterIndex > 0 ) {
            return index ;
        }
    }
    return 0;
    
}
#pragma mark  - setter or getter
-(void)setContentString:(NSString *)contentString
{
    _contentString = [contentString copy];
    [self startPanging];

    _textView.attributedText = _textArray[0];
}
-(void)setCurrentPage:(NSInteger)currentPage
{
    if(_currentPage == currentPage)
    {
        return;
    }
    _currentPage = currentPage;
    if(_currentPage >= 0 && _currentPage < self.textArray.count)
    {
        _textView.text = _textArray[_currentPage];
    }
}
-(UITextView *)textView
{
    if(_textView == nil)
    {
        _textView = [[UITextView alloc]initWithFrame:self.bounds];
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.selectable = NO;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.backgroundColor = [UIColor lightGrayColor];
    }
    return _textView;
}

@end
