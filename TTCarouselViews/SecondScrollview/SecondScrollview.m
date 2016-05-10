//
// 
// 
//
// 
// 
//
//
//
#import "SecondScrollview.h"

@interface  SecondScrollview()
{
    /*** 图片数量   */
   NSInteger  kImageCount;
}
@end

@implementation SecondScrollview

/**
 *  设置图片数组
 *
 *  @param imagearray
 */
-(void)setImagearray:(NSArray *)imagearray
{
    _imagearray=imagearray;
    kImageCount=imagearray.count;
    [self UpdateUI];
}



-(UIScrollView *)scrollview
{
    if(!_scrollview){
        _scrollview=[[UIScrollView alloc]initWithFrame:self.bounds];
         [self addSubview:_scrollview];
        // 5. 设置滚动视图的属性
        // 1) 允许分页
        [self.scrollview setPagingEnabled:YES];
        // 2) 禁用弹簧效果
        [self.scrollview setBounces:NO];
        // 3) 禁用水平滚动条
        [self.scrollview setShowsHorizontalScrollIndicator:NO];
        // 4) 设置代理
        [self.scrollview setDelegate:self];
    }
    return _scrollview;
}


/**
 *  布局
 */
-(void)UpdateUI
{
    //移除之前试图 从新布局
    [_scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_pageControl removeFromSuperview];
    _pageControl=nil;
    
    //创建显示图片
    [self createImageviews];
    
    //让指示器显示出来
    self.pageControl.numberOfPages=kImageCount;
}


/**
 *  创建图片控件
 */
-(void)createImageviews
{
    // 1) 因为要多添加收尾两张图片，因此需要建立一个kImageCount+2的数组
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:kImageCount + 2];
    for (NSInteger i = 0; i < kImageCount; i++) {
        NSString *imageName = self.imagearray[i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [self addTap:imageView tag:i+1];
        [array addObject:imageView];
    }
    
    //设置最后图片
    UIImage *lastImage = [UIImage imageNamed:[self.imagearray lastObject]];
    UIImageView *lastImageView = [[UIImageView alloc]initWithImage:lastImage];
    [self addTap:lastImageView tag:kImageCount];
    [array insertObject:lastImageView atIndex:0];
    
    
    // 3.2.3 将第一张图片追加到数组的尾部
    UIImage *firstImage = [UIImage imageNamed:[self.imagearray firstObject]];
    UIImageView *firstImageView = [[UIImageView alloc]initWithImage:firstImage];
    [self addTap:firstImageView tag:1];
    [array addObject:firstImageView];
    NSLog(@"%@", array);
    
    // 4 将数组中的图像视图，添加到scrollView中
    CGFloat width = self.scrollview.bounds.size.width;
    CGFloat height = self.scrollview.bounds.size.height;
    
    for (NSInteger i = 0; i < kImageCount + 2; i++){
        UIImageView *imageView = array[i];
        [imageView setFrame:CGRectMake(i * width, 0, width, height)];
        [self.scrollview addSubview:imageView];
    }
    // 5) 设置内容大小
    [self.scrollview setContentSize:CGSizeMake((kImageCount + 2) * width, height)];
    // 6）设置contentOffset显示第一张图片
    [self.scrollview setContentOffset:CGPointMake(width, 0)];
}



/**
 *  创建指示器控件
 *
 *  @return
 */
-(UIPageControl *)pageControl
{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc]init];
        CGSize size = [_pageControl sizeForNumberOfPages:kImageCount];
        [_pageControl setFrame:CGRectMake(0, 0, size.width, size.height)];
        [_pageControl setCenter:CGPointMake(self.center.x, self.bounds.size.height-20)];
        // 2) 设置页数
        [_pageControl setNumberOfPages:kImageCount];
        // pageControl中的页数，比scrollView中的页数少1
        [_pageControl setCurrentPage:0];
        // 3) 设置显示标示
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
        // 5) 增加分页控件的监听事件
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        //增加指示器
        [self addSubview:_pageControl];
    }
    return _pageControl;
}



/**
 *  增加tap手势
 *
 *  @param view
 *  @param tag
 */
-(void)addTap:(UIImageView*)view tag:(NSInteger)tag
{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
    view.tag=tag;
    view.userInteractionEnabled=YES;
    [view addGestureRecognizer:tap];
}




#pragma mark - 分页控件的监听事件
/**
 *  滑动监听
 *
 *  @param page
 */
- (void)pageChanged:(UIPageControl *)page
{
    CGFloat offsetX = (page.currentPage + 1) * self.scrollview.bounds.size.width;
    // 在此设置滚动视图偏移位置时，需要使用动画效果
    [self.scrollview setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


#pragma mark - 实现代理方法，让滚动视图实现循环效果
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1. 判断当前所在页面的页数
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (0 == pageNo || kImageCount + 1 == pageNo) {
        if (0 == pageNo) {
            pageNo = kImageCount;
        } else {
            pageNo = 1;
        }
        [scrollView setContentOffset:CGPointMake(pageNo * scrollView.bounds.size.width, 0)];
    }
    [self.pageControl setCurrentPage:pageNo - 1];
}


#pragma mark-tap手势
/**
 *  监听图片点击事件
 *
 *  @param recognizer
 */
-(void)TapAction:(UITapGestureRecognizer*)recognizer
{
    if([self.delegate respondsToSelector:@selector(SecondScrollview: currentclicktag:)]){
        [self.delegate SecondScrollview:self currentclicktag:recognizer.view.tag];
    }
}





@end
