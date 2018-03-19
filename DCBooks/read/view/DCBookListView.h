//
//  DCBookListView.h
//  DCBooks
//
//  Created by cheyr on 2018/3/16.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCBookListView;

@protocol DCBookListViewDelgate<NSObject>

-(void)bookListView:(DCBookListView *)bookListView didSelectRowAtIndex:(NSInteger)index;
@end


@interface DCBookListView : UIView

@property (nonatomic,strong) NSArray *list;
@property (nonatomic,weak) id<DCBookListViewDelgate> delegate;
@end
