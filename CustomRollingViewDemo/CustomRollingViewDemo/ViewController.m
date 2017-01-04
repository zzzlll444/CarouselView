//
//  ViewController.m
//  CustomRollingViewDemo
//
//  Created by bo on 16/11/24.
//  Copyright © 2016年 www.lxy.com. All rights reserved.
//

#import "ViewController.h"
#import "CustomRollingView.h"

@interface ViewController ()<CustomRollingViewDataSource, CustomRollingViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *hView;

@property (weak, nonatomic) IBOutlet UIView *vView;

@property (strong, nonatomic) CustomRollingView *cmsScrollView;

@property (strong, nonatomic) CustomRollingView *vcmsScrollView;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSArray *tempArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"0", @"1", @"2", @"3", @"4"];
    self.tempArray = @[@"0", @"1"];
    
    
    self.cmsScrollView = [[CustomRollingView alloc] initWithFrame:self.hView.bounds andIsVerticalScroll:NO];
    [self.hView addSubview:self.cmsScrollView];
    self.cmsScrollView.dataSource = self;
    self.cmsScrollView.delegate = self;
    [self.cmsScrollView reloadData];
    
    self.vcmsScrollView = [[CustomRollingView alloc] initWithFrame:self.vView.bounds andIsVerticalScroll:YES];
    [self.vView addSubview:self.vcmsScrollView];
    self.vcmsScrollView.dataSource = self;
    self.vcmsScrollView.delegate = self;
    [self.vcmsScrollView reloadData];
    
}


#pragma mark - delegate methods

- (NSInteger)numberOfPagesWithCustomRollingView:(CustomRollingView *)customRollingView {
    if (customRollingView == self.vcmsScrollView) {
        return self.tempArray.count;
    }
    return self.dataArray.count;
}

- (UIView *)customRollingView:(CustomRollingView *)customRollingView pageAtIndex:(NSInteger)index {
    UIView *pageView = [[[NSBundle mainBundle] loadNibNamed:@"CustomRollingView" owner:self options:nil] lastObject];
    pageView.width = self.hView.width;
    pageView.height = self.hView.height;
    UIImageView* pageImageView = (UIImageView* )[pageView viewWithTag:200];
    
    NSString *indexImage;
    if (customRollingView == self.vcmsScrollView) {
        indexImage = [self.tempArray objectAtIndex:index];
    } else {
        indexImage = [self.dataArray objectAtIndex:index];
    }
    
    pageImageView.image = [UIImage imageNamed:indexImage];
    
    return pageView;

}

- (void)customRollingView:(CustomRollingView *)customRollingView didSelectedPageAtIndex:(NSInteger)index {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
