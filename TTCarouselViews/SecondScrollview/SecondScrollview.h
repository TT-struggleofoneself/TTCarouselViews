//
//  SecondScrollview.h
//  02.循环滚动图片
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondScrollview;

/*** 代理   */
@protocol SecondScrollviewDelegare <NSObject>
@optional

/*** 监听点击   */
-(void)SecondScrollview:(SecondScrollview*)view currentclicktag:(NSInteger)tag;

@end



@interface SecondScrollview : UIView<UIScrollViewDelegate>

/*** 滚动视图   */
@property (strong, nonatomic) UIScrollView *scrollview;

/*** 分页控件   */
@property (strong, nonatomic) UIPageControl *pageControl;
/*** 设置图片数组  */
@property(nonatomic,strong)NSArray*imagearray;

/*** 代理 */
@property(nonatomic,weak)id<SecondScrollviewDelegare>delegate;

@end
