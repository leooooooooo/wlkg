//
//  Header1.h
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define Bundle @"29TSL4289R.com.lyg.wlkg"  //应用ID
#define NavigationBarColor [UIColor colorWithRed:0.0/255.0 green:82.0/255.0 blue:164.0/255.0 alpha:1.0f]  //导航栏颜色
#define TabBarColor [UIColor colorWithRed:0.0/255.0 green:82.0/255.0 blue:164.0/255.0 alpha:1.0f]  //导航栏颜色
#define NavigationTitleColor [UIColor whiteColor]  //导航标题颜色
#define NavigationBackArrowColor [UIColor whiteColor] //导航栏返回键头颜色
#define AppName @"WLKG"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define PAGE1 @"首页"
#define PAGE2 @"签到"
#define PAGE3 @"我的应用"
#define PAGE4 @"最新消息"

@interface Header : NSObject
+(void)NavigationConifigInitialize:(UIViewController *)sender;  //初始化导航
+(NSArray *)FunctionListInitialize;
@end
