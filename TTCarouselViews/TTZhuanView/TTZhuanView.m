//
//  TTZhuanView.m
//  转场动画-01.CATransition
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "TTZhuanView.h"

static const CGFloat docktimer=2.0;//时间

@interface TTZhuanView()<UIGestureRecognizerDelegate>
{
    NSTimer* _timer;
    NSInteger _tag;
    UIImageView *imageView;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
}
@property(nonatomic,strong)NSArray<UIImage*>*  imagelist;

@end

@implementation TTZhuanView


/**
 *  设置图片数据
 *
 *  @param imagearray
 */
-(void)setImagearray:(NSArray*)imagearray
{
    _imagearray=imagearray;
    [self  UpdateUI];
    
}

/**
 *  布局
 */
-(void)UpdateUI
{
    
    // 3. 初始化数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:_imagearray.count];
    for (NSInteger i = 0; i < _imagearray.count; i++){
        UIImage *image = [UIImage imageNamed:_imagearray[i]];
        [arrayM addObject:image];
    }
    self.imagelist=arrayM;//设置数据源- uiimage*
    if(arrayM==0) return;
    
    // 1. 实例化一个imageView添加到视图
    UIImage *image = [UIImage imageNamed:_imagearray[0]];
    imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [imageView setImage:image];
    imageView.tag=0;
    _tag=0;
    [self addSubview:imageView];
    
    // 2. 添加轻扫手势
    swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    swipeLeft.delegate=self;
    [imageView addGestureRecognizer:swipeLeft];
    
    swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    swipeRight.delegate=self;
    [imageView addGestureRecognizer:swipeRight];
    // UIImageView 默认不支持用户交互
    [imageView setUserInteractionEnabled:YES];
    
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    [imageView addGestureRecognizer:tap];
    
    [self addtimer];
}


#pragma mark 轻扫手势监听方法
/**
 *  轻扫手势监听方法
 *
 *  @param recognizer
 */
- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
    [self removetimer];
    [self MoveGestureRecognizer:recognizer];
     [self addtimer];
}


/**
 *  移动手势执行
 *
 *  @param recognizer
 */
-(void)MoveGestureRecognizer:(UISwipeGestureRecognizer*)recognizer
{
    // 1. 实例化转场动画 注意不要和CATransaction（动画事务）搞混
    CATransition *transition = [[CATransition alloc]init];
    // 1） 设置类型 type
    [transition setType:@"moveIn"];
    if (UISwipeGestureRecognizerDirectionLeft == recognizer.direction){
        NSLog(@"向左，图像索引递增");
        [transition setSubtype:kCATransitionFromRight];
        imageView.tag = (_tag + 1) % self.imagelist.count;
        NSLog(@"%ld %ld", imageView.tag, self.imagelist.count);
    }else{
        NSLog(@"向右，图像索引递减");
        [transition setSubtype:kCATransitionFromLeft];
        // 针对负数去模，需要注意修正索引
        imageView.tag = (_tag - 1 + self.imagelist.count) % self.imagearray.count;
        NSLog(@"%ld %ld", imageView.tag, self.imagelist.count);
    }
    //     UIViewAnimationCurveEaseInOut,
    //    UIViewAnimationCurveEaseIn,
    //    UIViewAnimationCurveEaseOut,
    //    UIViewAnimationCurveLinear
    
    
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    //过渡效果
    //    kCATransitionFade//转场的时候渐变转场
    //    kCATransitionMoveIn//转场的时候往下面移动
    //    kCATransitionPush//转场的时候左右相连，
    //    kCATransitionReveal//这个是往上面移动
    
    //判断设置type
    if(self.SwipeType==SetSwipeTypeorSwipeTypeATransitionPush){
         transition.type = kCATransitionPush;
    }else if(self.SwipeType==SetSwipeTypeorSwipeTypeATransitionMoveIn){
         transition.type = kCATransitionMoveIn;
    }else if(self.SwipeType==SetSwipeTypeorSwipeTypeATransitionFade){
         transition.type = kCATransitionFade;
    }else if(self.SwipeType==SetSwipeTypeorSwipeTypeTransitionReveal){
         transition.type = kCATransitionReveal;
    }else{
        transition.type = kCATransitionReveal;
    }
    // 3) 设置时长
    [transition setDuration:0.5f];
    [imageView setImage:self.imagelist[imageView.tag]];
    //设置tag值非常重要
    _tag=imageView.tag;
    // 3. 动画添加到图层
    [recognizer.view.layer addAnimation:transition forKey:nil];
}



#pragma mark-增加timer
/**
 *  增加timer
 */
-(void)addtimer
{
    if(!_timer){
        _timer=[NSTimer scheduledTimerWithTimeInterval:docktimer target:self selector:@selector(Timer:) userInfo:nil repeats:YES];
        
    }
}

#pragma mark-移除timer
/**
 *  移除timer
 */
-(void)removetimer
{
    if(_timer) {
        [_timer invalidate];
        _timer=nil;
    }
}




/**
 *  开启timer  切换图
 *
 *  @param timer 时间
 */
-(void)Timer:(NSTimer*)timer
{
    //判断方向
    if(self.Direction==SetSwipeTypeorSwipeDirectionLeft){
        [self swipe:swipeLeft];
    }else if(self.Direction==SetSwipeTypeorSwipeDirectionRight){
        [self swipe:swipeRight];
    }else{
        [self swipe:swipeLeft];
    }
}


#pragma mark-tap
/**
 *  监听点击
 *
 *  @param recognizer
 */
-(void)Tap:(UITapGestureRecognizer*)recognizer
{
    if([self.delegate respondsToSelector:@selector(TTZhuanView:tap:)]){
        [self.delegate TTZhuanView:self tap:recognizer.view.tag+1];
    }
    NSLog(@"点击的哪一个:%ld",recognizer.view.tag+1);
}



@end
