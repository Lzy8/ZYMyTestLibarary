//
//  ZYCarouselView.m
//  ZYTest
//
//  Created by 刘梓逸 on 16/7/14.
//  Copyright © 2016年 刘梓逸. All rights reserved.
//

#import "ZYCarouselView.h"
#import "UIView+ZYFrame.h"

#define _ZY_WIDTH_ self.zy_w

typedef NS_ENUM(NSUInteger, ZYScrollDirection) {
    ZYScrollDirectionLeft = 0,
    ZYScrollDirectionRight,
};

@interface ZYCarouselView ()<UIScrollViewDelegate>{

    UIScrollView        *_scrollView;
    UIPageControl       *_pageControl;
    NSTimer             *_timer;
    
    UIImageView         *_currentImageView;
    UIImageView         *_nextImageView;
    UIImageView         *_preImageView;
    
    CGFloat             _originOffSetX;
    CGFloat             _staticOffSetX;
    NSInteger           _currentPage;
    ZYScrollDirection   _scrollDirection;
}
@property (nonatomic, copy) ZYCallBackHandler tapImageHandler;
@end

@implementation ZYCarouselView

-(NSTimer *)timer{

    if (!_timer) {
        
        _timer = [NSTimer timerWithTimeInterval:5.f target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        _timer.tolerance = 3.f;
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];//放在主线程runloop，添加为default模式下的timer。
        [_timer fire];
    }
    
    return _timer;
}

-(void)zy_configFromNibWithImages:(NSArray<UIImage *> *)images isFireTimer:(BOOL)isFire imageClickAction:(ZYCallBackHandler)action{

    self.tapImageHandler = action;
    self.images = images;
    [self configWithisFireTimer:isFire];
}

+(instancetype)zy_CarouselViewWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images isFireTimer:(BOOL)isFire imageClickAction:(ZYCallBackHandler)action {

    ZYCarouselView *view = [[ZYCarouselView alloc] initWithFrame:frame];
    view.tapImageHandler = action;
    view.images = images;
    [view configWithisFireTimer:isFire];
    return view;
}

-(void)configWithisFireTimer:(BOOL)isFire{

    //_scrollView 初始化
    _scrollView = [[UIScrollView alloc] init];

    _scrollView.contentSize = CGSizeMake(self.zy_w * 3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentOffset = CGPointMake(self.zy_w * 1, 0);
    [self addSubview:_scrollView];
    
    //imageView初始化
    _currentImageView = [[UIImageView alloc] init];
    _currentImageView.userInteractionEnabled = YES;
    _currentImageView.image = [self.images firstObject];
    [_scrollView addSubview:_currentImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapImage:)];
    [_currentImageView addGestureRecognizer:tap];
    
    _nextImageView = [[UIImageView alloc] init];
    _nextImageView.userInteractionEnabled = YES;
    _nextImageView.image = [_images objectAtIndex:1];
    [_scrollView addSubview:_nextImageView];
    
    _preImageView = [[UIImageView alloc] init];
    _preImageView.userInteractionEnabled = YES;
    _preImageView.image = [_images lastObject];
    [_scrollView addSubview:_preImageView];
    
    //pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _images.count;
    
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
    
    _originOffSetX = self.zy_w;
    _currentPage = 0;
    _staticOffSetX = -1;
    
    
    if (isFire) [self timer];

}

#pragma mark - ImageClickAction

-(void)tapImage:(UITapGestureRecognizer *)tapG{

    self.tapImageHandler(_currentPage);
}
#pragma mark - timerCallBack
-(void)timerFire{
    
    [_scrollView setContentOffset:CGPointMake(self.zy_w * 2, 0) animated:YES];
    _pageControl.currentPage = _pageControl.currentPage == _images.count - 1 ? 0 : _pageControl.currentPage + 1;
    [self algorithmicMethod:_scrollView];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _scrollDirection = scrollView.contentOffset.x - _originOffSetX  > 0 ? ZYScrollDirectionLeft : ZYScrollDirectionRight;
    _originOffSetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self algorithmicMethod:scrollView];
}

-(void)algorithmicMethod:(UIScrollView *)scrollView{

    BOOL isPaged = _originOffSetX / _ZY_WIDTH_  ==  _staticOffSetX / _ZY_WIDTH_;
    
    if (isPaged) return;
    
    if (_scrollDirection == ZYScrollDirectionLeft){
        
        _currentImageView.image = _nextImageView.image;
        _currentPage = (_currentPage == _images.count - 1) ? 0 : _currentPage + 1;
    }
    
    if (_scrollDirection == ZYScrollDirectionRight) {
        
        _currentImageView.image = _preImageView.image;
        _currentPage = (_currentPage == 0) ? _images.count - 1 : _currentPage - 1;
    }
    
    if (_currentPage == 0) {
        _preImageView.image = [_images lastObject];
        _nextImageView.image = _images[_currentPage + 1];
    }else if( _currentPage == _images.count - 1 ){
        _preImageView.image = _images[_currentPage - 1];
        _nextImageView.image = [_images firstObject];
    }else{
        _preImageView.image = _images[_currentPage - 1];
        _nextImageView.image = _images[_currentPage + 1];
    }
    _pageControl.currentPage = _currentPage;
    [_scrollView setContentOffset:CGPointMake(self.zy_w, 0) animated:NO];
    
    _staticOffSetX = scrollView.contentOffset.x;
    
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    _currentImageView.frame = CGRectMake(self.zy_w, 0, self.zy_w, self.zy_h);
    _nextImageView.frame = CGRectMake(CGRectGetMaxX(_currentImageView.frame), 0, self.zy_w, self.zy_h);
    _preImageView.frame = CGRectMake(0, 0, self.zy_w, self.zy_h);
    _pageControl.zy_w = self.zy_w;
    _pageControl.zy_h = 25.f;
    _pageControl.zy_x = 0.f;
    _pageControl.zy_y = self.zy_h - _pageControl.zy_h;
    
}

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

@end
