//
//  CustomRollingView.m
//  CustomRollingViewDemo
//
//  Created by bo on 16/11/24.
//  Copyright © 2016年 www.lxy.com. All rights reserved.
//

#import "CustomRollingView.h"

#define CustomRollingView_AutoPlayDurHorizontal    3    // 水平滚动时间间隔
#define CustomRollingView_AutoPlayDurVertical      5    // 垂直滚动时间间隔

@interface CustomRollingView()<UIScrollViewDelegate>

/**
 *  ScrollView
 */
@property (nonatomic, strong) UIScrollView *myScrollView;

/**
 *  总页数
 */
@property (nonatomic, assign) int totalPages;

/**
 *  当前页
 */
@property (nonatomic, assign) int curPage;

/**
 *  当前的View数组
 *  UIView
 */
@property (nonatomic, strong) NSMutableArray *topViews;

/**
 *  自动播定时器
 */
@property (nonatomic, strong) NSTimer *autoTimer;

/**
 *  是不是正在自动播
 */
@property (nonatomic, assign) BOOL isScrollRunFlag;

/**
 *  是否垂直滚动
 */
@property (nonatomic, assign) BOOL isVerticalScroll;

@property (nonatomic, strong) UIPageControl *pageCont;

@property (nonatomic, strong) UIView *bottomMoveView;


@end

@implementation CustomRollingView

- (id)initWithFrame:(CGRect)frame andIsVerticalScroll:(BOOL)isVertical {
    self = [super initWithFrame:frame];
    if (self) {
        self.myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        self.myScrollView.pagingEnabled = YES;
        self.myScrollView.delegate = self;
        [self addSubview:self.myScrollView];
        self.curPage = 0;
        self.isVerticalScroll = isVertical;
        if (isVertical) {
            self.myScrollView.contentHeight = self.height * 3;
            self.myScrollView.contentOffsetTop = self.height;
            self.myScrollView.scrollEnabled = NO;
        } else {
            self.myScrollView.contentWidth = self.width * 3;
            self.myScrollView.contentOffsetLeft = self.width;
            self.myScrollView.scrollEnabled = YES;
        }
    }
    return self;
}

- (void)reloadData {
    self.totalPages = (int)[self.dataSource numberOfPagesWithCustomRollingView:self];
    if (self.totalPages == 0) {
        return;
    }
    self.curPage = 0;
    [self loadData];
}

- (void)loadData {
    
    //移除所有视图
    [self.myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self getNeedViewsWithCurpage:self.curPage];
    
    for (int i = 0; i < 3; i ++) {
        UIView *tempView = [self.topViews objectAtIndex:i];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [tempView addGestureRecognizer:singleTap];
        
        if (self.isVerticalScroll) {
            tempView.frame = CGRectOffset(tempView.frame, 0, self.height * i);
        } else {
            tempView.frame = CGRectOffset(tempView.frame, self.width * i, 0);
        }
        [self.myScrollView addSubview:tempView];
    }
    if (self.isVerticalScroll) {
        self.myScrollView.contentOffsetTop = self.height;
    } else {
        self.myScrollView.contentOffsetLeft = self.width;
    }
    
    //TODOBO
    self.pageCont.currentPage = self.curPage;
    
    [self startTimer];
    
}

- (void)startTimer {
    [self.autoTimer invalidate];
    NSInteger tempDur;
    if (self.isVerticalScroll) {
        tempDur = CustomRollingView_AutoPlayDurVertical;
    } else {
        tempDur = CustomRollingView_AutoPlayDurHorizontal;
    }
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:tempDur target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(customRollingView:didSelectedPageAtIndex:)]) {
        [self.delegate customRollingView:self didSelectedPageAtIndex:self.curPage];
    }
}

- (void)autoPlay {
    self.isScrollRunFlag = YES;
    [UIView animateWithDuration:0.5 animations:^{
        if (self.isVerticalScroll) {
            [self.myScrollView setContentOffset:CGPointMake(0, self.height * 2)];
        } else {
            [self.myScrollView setContentOffset:CGPointMake(self.width * 2, 0)];
        }
    } completion:^(BOOL finished) {
        self.curPage = [self validPageValue:self.curPage + 1];
        [self loadData];
        self.isScrollRunFlag = NO;
    }];
}

//根据当前的页码得到需要显示的3张图
- (void)getNeedViewsWithCurpage:(int)curPage {
    int pre = [self validPageValue:self.curPage - 1];
    int last = [self validPageValue:self.curPage + 1];
    if (!self.topViews) {
        self.topViews = [[NSMutableArray alloc] init];
    }
    [self.topViews removeAllObjects];
    [self.topViews addObject:[self.dataSource customRollingView:self pageAtIndex:pre]];
    [self.topViews addObject:[self.dataSource customRollingView:self pageAtIndex:curPage]];
    [self.topViews addObject:[self.dataSource customRollingView:self pageAtIndex:last]];
}

- (int)validPageValue:(int)value {
    if (value == -1) {
        value = self.totalPages - 1;
    }
    if (value == self.totalPages) {
        value = 0;
    }
    return value;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isVerticalScroll || self.isScrollRunFlag) {
        return;
    }
    if (scrollView.dragging) {
        [self.autoTimer invalidate];
    }
    
    float x = scrollView.contentOffsetLeft;
    if (x >= self.width * 2) {
        self.curPage = [self validPageValue:self.curPage + 1];
        [self loadData];
    }
    if (x <= 0) {
        self.curPage = [self validPageValue:self.curPage - 1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startTimer];
}

@end
