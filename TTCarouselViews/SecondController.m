//
//  SecondController.m
//  vvvv
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import "SecondController.h"
#import "TTZhuanView.h"
@interface SecondController ()

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UpdateUI];
}


-(void)UpdateUI
{
    TTZhuanView* viwe=[[TTZhuanView alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 100)];
    viwe.Direction=SetSwipeTypeorSwipeDirectionRight;
    viwe.SwipeType=SetSwipeTypeorSwipeTypeATransitionFade;
      viwe.imagearray= @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"];
    [self.view addSubview:viwe];
    
    
    TTZhuanView* viwe1=[[TTZhuanView alloc]initWithFrame:CGRectMake(0,200, self.view.bounds.size.width, 100)];
    viwe1.Direction=SetSwipeTypeorSwipeDirectionRight;
    viwe1.SwipeType=SetSwipeTypeorSwipeTypeATransitionMoveIn;
    viwe1.imagearray= @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"];
    [self.view addSubview:viwe1];
    
    
    TTZhuanView* viwe2=[[TTZhuanView alloc]initWithFrame:CGRectMake(0,370, self.view.bounds.size.width, 100)];
    viwe2.Direction=SetSwipeTypeorSwipeDirectionRight;
    viwe2.SwipeType=SetSwipeTypeorSwipeTypeTransitionReveal;
      viwe2.imagearray= @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"];
    [self.view addSubview:viwe2];
    
    TTZhuanView* viwe3=[[TTZhuanView alloc]initWithFrame:CGRectMake(0,500, self.view.bounds.size.width, 100)];
    viwe3.Direction=SetSwipeTypeorSwipeDirectionRight;
    viwe3.SwipeType=SetSwipeTypeorSwipeTypeATransitionPush;
      viwe3.imagearray= @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"];
    [self.view addSubview:viwe3];
    
}

@end
