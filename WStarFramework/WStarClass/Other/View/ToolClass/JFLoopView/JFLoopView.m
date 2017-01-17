//
//  JFLoopView.m
//  MaYi
//
//  Created by 张志峰 on 2016/10/29.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFLoopView.h"

#import "JFLoopViewLayout.h"
#import "JFLoopViewCell.h"
#import "JFWeakTimerTargetObject.h"

@interface JFLoopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, weak) NSTimer *timer;

@end

static NSString *ID = @"loopViewCell";

@implementation JFLoopView

- (instancetype)initWithImageArray:(NSArray *)imageArray {
    if (self = [super init]) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[JFLoopViewLayout alloc] init]];
        [collectionView registerClass:[JFLoopViewCell class] forCellWithReuseIdentifier:ID];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self addSubview:collectionView];
        
        self.collectionView = collectionView;
        self.imageArray = imageArray;
        
        //添加分页器
        [self addSubview:self.pageControl];
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置滚动的初始状态在
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
            //添加定时器
            [self addTimer];
        });
        
    }
    return self;
}

/// 懒加载pageControl
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 220, 0, 30)];
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    }
    return _pageControl;
}

#pragma mark --- UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JFLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.imageArray[indexPath.item % self.imageArray.count];
    return cell;
}

#pragma mark ---- UICollectionViewDelegate

/// 滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

/// 当滚动减速时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / scrollView.bounds.size.width;
    
    //手动滚动到左边临界状态
    if (page == 0) {
        page = self.imageArray.count;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
        //滚动到右临界状态
    }else if (page == [self.collectionView numberOfItemsInSection:0] - 1) {
        page = self.imageArray.count - 1;
        self.collectionView.contentOffset = CGPointMake(page * scrollView.frame.size.width, 0);
    }
    
    //设置UIPageControl当前页
    NSInteger currentPage = page % self.imageArray.count;
    self.pageControl.currentPage =currentPage;
    //添加定时器
    [self addTimer];
}

//开始拖动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //移除定时器
    [self removeTimer];
}

/// 添加定时器
- (void)addTimer {
    if (self.timer) return;
    self.timer = [JFWeakTimerTargetObject scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/// 移除定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/// 切换到下一张图片
- (void)nextImage {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    NSInteger page = offsetX / self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake((page + 1) * self.collectionView.bounds.size.width, 0) animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)dealloc {
    [self removeTimer];
}

@end
