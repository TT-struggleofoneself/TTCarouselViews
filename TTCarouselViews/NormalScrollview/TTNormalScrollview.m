//
//  TTNormalScrollview.m
//  vvvv
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import "TTNormalScrollview.h"
@interface TTNormalScrollview()<UIScrollViewDelegate>
{
    
}

@end

@implementation TTNormalScrollview

/**
 *  设置显示数据
 *
 *  @param imagearray 数组
 */
-(void)setImagearray:(NSArray *)imagearray
{
    _imagearray=imagearray;
    [self UpdateUI];
}

/**
 *  布局
 */
-(void)UpdateUI
{
    //移除之前试图 从新布局
    [_PageControl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_PageControl removeFromSuperview];
    _PageControl=nil;
    
    // 增加图片
    [self addimageview];
    self.PageControl.numberOfPages=_imagearray.count;
}


-(UIScrollView *)ScrollView
{
    if(!_ScrollView){
        _ScrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        self.ScrollView.delegate=self;
        self.ScrollView.bounces=NO;
        self.ScrollView.pagingEnabled=YES;
        [self addSubview:self.ScrollView];
    }
    return _ScrollView;
}


/**
 *  设置图片
 */
-(void)addimageview
{
    for (int i=0; i<self.imagearray.count; i++)
    {
        NSString* imagename=(NSString*)self.imagearray[i];
        UIImageView* imageview=[[UIImageView alloc]initWithFrame:CGRectMake(self.ScrollView.bounds.size.width*i, 0, self.ScrollView.bounds.size.width, self.ScrollView.bounds.size.height)];
        imageview.userInteractionEnabled=YES;
        imageview.image=[UIImage imageNamed:imagename];
        imageview.tag=i+1;
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        [imageview addGestureRecognizer:tap];
        [self.ScrollView addSubview:imageview];
    }
    
    [self.ScrollView setContentSize:CGSizeMake(self.ScrollView.bounds.size.width*self.imagearray.count, self.ScrollView.bounds.size.height)];
}


/**
 *  创建指示器
 *
 *  @return
 */
-(UIPageControl *)PageControl
{
    if(!_PageControl){
        _PageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 140, 20)];
        self.PageControl.currentPage=0;
        self.PageControl.center=CGPointMake(self.center.x, self.bounds.size.height-20);
        [self addSubview:self.PageControl];        
    }
    return _PageControl;
}



#pragma mark -UIScrollViewDelegate方法
// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.PageControl.currentPage = page;
}



#pragma mark-tap手势
-(void)TapAction:(UITapGestureRecognizer*)recognizer
{
   if([self.delegate respondsToSelector: @selector(TTNormalScrollview: currentclicktag:)]){
             [self.delegate TTNormalScrollview:self currentclicktag:recognizer.view.tag];
        }
    
}


@end