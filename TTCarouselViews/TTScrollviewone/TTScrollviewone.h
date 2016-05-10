//
//  
//  
//
//  
//  
//

#import <UIKit/UIKit.h>

@class TTScrollviewone;

/*** 代理   */
@protocol TTScrollviewoneDelegare <NSObject>

@optional
/*** 监听图片点击   */
-(void)TTScrollviewoneView:(TTScrollviewone*)view currentclicktag:(NSInteger)tag;

@end

@interface TTScrollviewone : UIView

/*** 当前滚动试图   */
@property(nonatomic,strong)UIScrollView* myScrollView;
/*** 指示器滚动试图  */
@property(nonatomic,strong)UIPageControl* myPageControl;

/*** 代理  */
@property(nonatomic,weak)id<TTScrollviewoneDelegare> delegate;


@property(nonatomic,strong)NSArray* imagearray;//放image图片的名称的数组




/**
 *  开始时间
 */
- (void)startTimer;


/**
 *  销毁时间
 */
-(void)invaliTimer;


@end



