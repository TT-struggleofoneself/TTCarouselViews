//
//  ViewController.m
//  vvvv
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import "ViewController.h"

#import "TTScrollviewone.h"
#import "SecondScrollview.h"
#import "TTNormalScrollview.h"


@interface ViewController ()<TTScrollviewoneDelegare,SecondScrollviewDelegare,TTNormalScrollviewDelegare>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Lunbo1];
    
    [self Lunbo2];
    
    [self Lunbo3];
}



-(void)Lunbo1
{
    TTScrollviewone *Scrollview=[[TTScrollviewone alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width,100)];    Scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    Scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04"];
    Scrollview.delegate=self;
    [self.view addSubview:Scrollview];
    
}


-(void)Lunbo2
{
    SecondScrollview* scrollview=[[SecondScrollview alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
    scrollview.delegate=self;    scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];    scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04"];
    [self.view addSubview:scrollview];
}


-(void)Lunbo3
{
    TTNormalScrollview* scrollview=[[TTNormalScrollview alloc]initWithFrame:CGRectMake(0,300, self.view.bounds.size.width, 100)];
    scrollview.delegate=self;
    scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
     scrollview.delegate=self; scrollview.imagearray=@[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:scrollview];
}




-(void)TTScrollviewoneView:(TTScrollviewone *)view currentclicktag:(NSInteger)tag
{
    NSLog(@"点击了第一种轮播图片的第%ld张图片",tag+1);
}


-(void)SecondScrollview:(SecondScrollview *)view currentclicktag:(NSInteger)tag
{
     NSLog(@"点击了第二种轮播图片的第%ld张图片",tag);
}
    


@end
