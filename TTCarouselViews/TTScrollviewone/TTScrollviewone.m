//
//  
//  
//
//  
//
//

#import "TTScrollviewone.h"

@interface TTScrollviewone()<UIScrollViewDelegate>

/*** 保存图片控件数组   */
@property(nonatomic,strong)NSMutableArray* imageviewarray;
/*** 时间   */
@property(nonatomic,strong)NSTimer* timer;
@end
@implementation TTScrollviewone

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        [self UpdateUI];
    }
    return self;
}

-(NSMutableArray *)imageviewarray
{
    if(!_imageviewarray)
    {
        _imageviewarray=[NSMutableArray array];
    }
    return _imageviewarray;
}



-(void)setImagearray:(NSArray *)imagearray
{
    _imagearray=imagearray;
     [_myScrollView setContentSize:CGSizeMake(imagearray.count * _myScrollView.bounds.size.width, 0)];
    
    [self UpdateUI];
    
}


-(void)UpdateUI
{
    //先删除之前的
    [_myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_myPageControl removeFromSuperview];
    _myPageControl=nil;
    

    //获得图片
    for (int i = 0; i < self.imagearray.count; i++)
    {
        NSString* imageName = self.imagearray[i];//修改这里
        UIImage* image = [UIImage imageNamed:imageName];
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:self.myScrollView.bounds];
        imageView.image = image;
        imageView.userInteractionEnabled=YES;
        imageView.tag=i;
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        [imageView addGestureRecognizer:tap];
        [self.imageviewarray addObject:imageView];        
        [self.myScrollView addSubview:imageView];
    }
    
    //计算imageView 的位置
    [self.myScrollView.subviews enumerateObjectsUsingBlock:^(UIImageView* imageView, NSUInteger idx, BOOL *stop) {
        // 调整x => origin => frame
        CGRect frmae = imageView.frame;
        frmae.origin.x = idx * imageView.bounds.size.width;
        imageView.frame = frmae;
    }];
    
    //初始分页数为零
    self.myPageControl.currentPage = 0;
    
    //启动时钟
    [self startTimer];
}


- (UIScrollView *)myScrollView
{
    if (_myScrollView ==nil) {
        
        _myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _myScrollView.backgroundColor = [UIColor redColor];
        [self addSubview:_myScrollView];
        //取消弹簧效果
        _myScrollView.bounces = NO;        
        //取消水平滚动条
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
         //要分页
        _myScrollView.pagingEnabled = YES;        
        _myScrollView.delegate = self;
        
    }
    return _myScrollView;
}



/**
 *  创建指示器
 *
 *  @return  UIPageControl
 */
- (UIPageControl *)myPageControl
{
    if (_myPageControl == nil)
    {
        _myPageControl = [[UIPageControl alloc] init];
        //总页数
        _myPageControl.numberOfPages = _imagearray.count;
        //设置尺寸
        CGSize size = [_myPageControl sizeForNumberOfPages:_imagearray.count];
        _myPageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _myPageControl.center = CGPointMake(self.center.x, self.bounds.size.height-20);        
        //设置颜色
        _myPageControl.pageIndicatorTintColor = [UIColor redColor];
        _myPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        
        [self addSubview:_myPageControl];
        //添加监听事件
        [_myPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _myPageControl;
}


#pragma mark-分页控件监听方法
- (void)pageChanged:(UIPageControl*)pageControl
{
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = pageControl.currentPage * self.myScrollView.bounds.size.width;
    CATransition *animation = [CATransition animation];//初始化动画
    animation.duration = 0.5f;//间隔的时间
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;//设置上面4种动画效果
    animation.subtype = kCATransitionFromRight;//设置动画的方向，有四种，分别为kCATransitionFromRight、kCATransitionFromLeft、kCATransitionFromTop、kCATransitionFromBottom
    [self.myScrollView.layer addAnimation:animation forKey:@"animationID"];
    [_myScrollView setContentOffset:CGPointMake(x, 0)];
}


#pragma mark-时间
- (void)startTimer
{
    if(!self.timer)
    {
        self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        //添加到运行循环
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}


/**
 *  timer  执行方法 滚动加修改
 */
- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (int)(self.myPageControl.currentPage + 1) % _imagearray.count;
    self.myPageControl.currentPage = page;
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.myPageControl];
    
}




/**
 *  销毁时间
 */
-(void)invaliTimer
{
    [self.timer invalidate];
    self.timer=nil;
}


#pragma mark -UIScrollViewDelegate方法
/**
 *  设置指示器
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.myPageControl.currentPage = page;
}



/**
 修改时钟所在的运行循环的模式后，抓不住图片
 解决方法：抓住图片时，停止时钟，松手后，开启时钟
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invaliTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}




#pragma mark-tap手势---
/**
 *  监听点击
 *
 *  @param recognizer
 */
-(void)TapAction:(UITapGestureRecognizer*)recognizer
{
    if(self.delegate)
    {
        if([self.delegate respondsToSelector: @selector(TTScrollviewoneView: currentclicktag:)])
        {
            [self.delegate TTScrollviewoneView:self currentclicktag:recognizer.view.tag];
        }
    }
 }


/**
 *  销毁时间
 */
-(void)dealloc
{
    [self invaliTimer];
}



@end
