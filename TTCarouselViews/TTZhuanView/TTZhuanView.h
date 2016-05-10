//
//  TTZhuanView.h
//  转场动画-01.CATransition
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SetSwipeTypeorSwipeDirection)
{
    SetSwipeTypeorSwipeDirectionLeft=0,//表示swipe 方向为左边
    SetSwipeTypeorSwipeDirectionRight//表示swipe 方向为右边
    
};

typedef NS_ENUM(NSInteger, SetSwipeTypeorSwipeType)
{
    SetSwipeTypeorSwipeTypeATransitionPush=0, //kCATransitionPush//转场的时候左右相连
    SetSwipeTypeorSwipeTypeATransitionMoveIn,//kCATransitionMoveIn//转场的时候往下面移动
    SetSwipeTypeorSwipeTypeATransitionFade,//kCATransitionFade//转场的时候渐变转场
    SetSwipeTypeorSwipeTypeTransitionReveal//kCATransitionReveal//这个是往上面移动
};




@class  TTZhuanView;

/*** 代理  */
@protocol TTZhuanViewDelegate <NSObject>

@optional
/*** 监听点击  */
-(void)TTZhuanView:(TTZhuanView*)view tap:(NSInteger)tag;
@end


@interface TTZhuanView : UIView
/*** 用于设置图片的数组  类型为UIImage  */
@property (strong, nonatomic) NSArray* imagearray;

/*** 代理  */
@property(nonatomic,weak)id<TTZhuanViewDelegate>   delegate;

/*** 设置运动方向  */
@property(nonatomic)SetSwipeTypeorSwipeDirection Direction;

/*** 设置运动type  */
@property(nonatomic)SetSwipeTypeorSwipeType SwipeType;



/**
 *  增加时间
 */
-(void)addtimer;


/**
 *  移除时间
 */
-(void)removetimer;





@end


