//
//  CustomRollingView.h
//  CustomRollingViewDemo
//
//  Created by bo on 16/11/24.
//  Copyright © 2016年 www.lxy.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+EidanSize.h"

@protocol CustomRollingViewDataSource,CustomRollingViewDelegate;
@interface CustomRollingView : UIView

/**
 *  CustomRollingViewDataSource代理对象
 */
@property (nonatomic, weak) id<CustomRollingViewDataSource> dataSource;

/**
 *  CustomRollingViewDelegate代理对象
 */
@property (nonatomic, weak) id<CustomRollingViewDelegate> delegate;

/**
 *  创建对象
 *
 *  @param frame      frame
 *  @param isVertical 是否垂直滚动
 *
 *  @return 创建对象
 */
- (id)initWithFrame:(CGRect)frame andIsVerticalScroll:(BOOL)isVertical;

/**
 *  刷新数据
 */
- (void)reloadData;

@end

@protocol CustomRollingViewDataSource <NSObject>

/**
 *  有几页
 *
 *  @return 页数
 */
- (NSInteger)numberOfPagesWithCustomRollingView:(CustomRollingView *)customRollingView;

/**
 *  每一页的展示View
 *
 *  @param customRollingView CustomRollingView自己
 *  @param index             下标
 *
 *  @return 每一页的展示View
 */
- (UIView *)customRollingView:(CustomRollingView *)customRollingView pageAtIndex:(NSInteger)index;

@end

@protocol CustomRollingViewDelegate <NSObject>

@optional

/**
 *  点击某一页
 *
 *  @param customRollingView CustomRollingView自己
 *  @param index             某页下标
 */
- (void)customRollingView:(CustomRollingView *)customRollingView didSelectedPageAtIndex:(NSInteger)index;

@end

