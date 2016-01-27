//
//  CyclePlayView.m
//  CyclePlayViewStudy
//
//  Created by caiqiujun on 16/1/27.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

#import "CyclePlayView.h"
#import "UIImageView+WebCache.h"

@interface CyclePlayView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageView;
@property (nonatomic, assign) NSUInteger count;
@property (strong, nonatomic)NSTimer *timer;
@end

@implementation CyclePlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 获取控件的宽度和高度
        CGSize size = frame.size;
        
        //------------------scrollView---------------------
        // 获取scrollView的宽度和高度
        CGFloat scrollW = size.width;
        CGFloat scrollH = size.height;
        // 初始化UIScrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollW, scrollH)];
        self.scrollView.delegate = self;
        // 不显示滚动条
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        [self setDefaultValue];
        
    }
    return self;
}
/**
 *  设置默认值
 */
-(void)setDefaultValue {
    self.currentTintColor = [UIColor whiteColor];
    self.tintColor = [UIColor lightGrayColor];
    self.timeInterval = 2;
}


/**
 * 设置轮播的图片(images和placeholderImages数组长度必须相等)
 *
 * @param images url的地址数组（NSString类型）
 *
 * @param placeholderImages 占位图数组（NSString类型）
 */
- (void)setImages:(NSArray *)images placeholderImages:(NSArray *)placeholderImages {
    // 获取控件的宽度和高度
    CGSize size = self.frame.size;
    // 获取scrollView的宽度和高度
    CGFloat scrollW = size.width;
    CGFloat scrollH = size.height;
    
    // 添加UIPageControl
    [self preparePageViewWithPages:placeholderImages.count];
    self.count = placeholderImages.count;
    
    if (placeholderImages == nil) {
        NSLog(@"您未设置占位图");
        return;
    }
    else {
        NSUInteger count = placeholderImages.count + 1;
        for (int i = 0; i < count + 1; i ++) {
            // 设置图片
            NSURL *imageUrl = nil;
            NSString *placeholderImage = nil;
            // 没有url，只加载本地图片
            if (images == nil) {
                if (i == 0) {
                    placeholderImage = [placeholderImages objectAtIndex:count - 2];
                }else if (i == count) {
                    placeholderImage = [placeholderImages objectAtIndex:0];
                }
                else {
                    placeholderImage = [placeholderImages objectAtIndex:i - 1];
                }
            }
            else {
                if (i == 0) {
                    imageUrl = [NSURL URLWithString:[images objectAtIndex:count - 2]];
                    placeholderImage = [placeholderImages objectAtIndex:count - 2];
                }else if (i == count) {
                    imageUrl = [NSURL URLWithString:[images objectAtIndex:0]];
                    placeholderImage = [placeholderImages objectAtIndex:0];
                }
                else {
                    imageUrl = [NSURL URLWithString:[images objectAtIndex:i - 1]];
                    placeholderImage = [placeholderImages objectAtIndex:i - 1];
                }
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(scrollW * i, 0, scrollW, scrollH);
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholderImage]];
            [self.scrollView addSubview:imageView];
        }
        // 设置scrollView属性
        self.scrollView.contentOffset = CGPointMake(scrollW, 0);
        self.scrollView.contentSize = CGSizeMake((count + 1) * scrollW, 0);
    }
    
    
}


-(void)preparePageViewWithPages:(NSUInteger)pages {
    // 获取控件的宽度和高度
    CGSize size = self.frame.size;
    // 获取scrollView的宽度和高度
    CGFloat scrollW = size.width;
    CGFloat scrollH = size.height;
    
    CGFloat pageW = 100;
    self.pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((scrollW - pageW) * 0.5, scrollH * 0.9, pageW, 4)];
    
    self.pageView.numberOfPages = pages;
    self.pageView.currentPageIndicatorTintColor = self.currentTintColor;
    self.pageView.pageIndicatorTintColor = self.tintColor;
    self.pageView.currentPage = 0;
    [self addSubview:self.pageView];
    [self addTimer];
}
/**
 *  增加定时器
 */
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage {
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = self.pageView.currentPage;
    if (index == self.count + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * width, 0)animated:YES];
}
//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取控件的宽度和高度
    CGSize size = self.frame.size;
    // 获取scrollView的宽度和高度
    CGFloat scrollW = size.width;
    
    int index = (self.scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    if (index == self.count + 2) {
        index = 1;
    } else if(index == 0) {
        index = (int)self.count;
    }
    self.pageView.currentPage = index - 1;
}
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}
// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == self.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.count * width, 0) animated:NO];
    }
}



@end
