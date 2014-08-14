//
//  DORootViewController.m
//  DemoOne
//
//  Created by Abbie on 2014/8/13.
//  Copyright (c) 2014年 LiVEBRiCKS. All rights reserved.
//

#import "DORootViewController.h"

@interface DORootViewController ()

@end

@implementation DORootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showTextView.editable = NO;
    //設定scrollview的滾動範圍
    self.showScrollView.contentSize = CGSizeMake(1000, 400);
    //分頁效果
    self.showScrollView.pagingEnabled = YES;
    //水平方向滾動
    self.showScrollView.showsHorizontalScrollIndicator = NO;
    //垂直方向滾動
    self.showScrollView.showsVerticalScrollIndicator = NO;
}

#pragma mark - UIScrollViewDelegate

//UIScrollViewIndicatorStyle indicatorStyle 设定滚动的样式

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)showScrollView
{
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)showScrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

- (void)scrollViewDidScroll:(UIScrollView *)showScrollView
{
    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)showScrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging willDecelerate");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)showScrollView{
    NSLog(@"scrollViewWillBeginDecelerating");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)showScrollView{
    NSLog(@"scrollViewDidEndDecelerating");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
