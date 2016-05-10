//
//  TTNormalScrollview.h
//  vvvv
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTNormalScrollview;


/*** 代理   */
@protocol TTNormalScrollviewDelegare <NSObject>
@optional
/*** 监听点击   */
-(void)TTNormalScrollview:(TTNormalScrollview*)view currentclicktag:(NSInteger)tag;

@end



@interface TTNormalScrollview : UIView

/*** 滚动试图   */
@property(nonatomic,strong)UIScrollView* ScrollView;
/*** 指示器   */
@property(nonatomic,strong)UIPageControl* PageControl;
/*** 代理   */
@property(nonatomic,weak)id<TTNormalScrollviewDelegare> delegate;

/*** 设置数据源-数组   */
@property(nonatomic,strong)NSArray* imagearray;//放image图片的名称的数组


@end
