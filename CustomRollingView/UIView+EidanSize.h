//
//  UIView+EidanSize.h
//  SlideOutTest7
//
//  Created by Eidan Lin on 12-11-7.
//  Copyright (c) 2012年 taomm. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (EidanSize)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)topAdd:(CGFloat)add;
- (void)leftAdd:(CGFloat)add;
- (void)widthAdd:(CGFloat)add;
- (void)heightAdd:(CGFloat)add;
@end

@interface CALayer (EidanLayerSize)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGSize size;

- (void)topAdd:(CGFloat)add;
- (void)leftAdd:(CGFloat)add;
- (void)widthAdd:(CGFloat)add;
- (void)heightAdd:(CGFloat)add;
@end

@interface UIScrollView (EidanScrollView)

@property (nonatomic) CGFloat contentHeight;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentOffsetLeft;
@property (nonatomic) CGFloat contentOffsetTop;

- (void)contentHeightAdd:(CGFloat)add;
- (void)contentWidthAdd:(CGFloat)add;
- (void)contentOffsetLeftAdd:(CGFloat)add;
- (void)contentOffsetTopAdd:(CGFloat)add;
@end

