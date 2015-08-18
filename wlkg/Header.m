//
//  Header1.m
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Header.h"

@implementation Header

+(void)NavigationConifigInitialize:(UIViewController *)sender
{

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [sender.navigationItem setBackBarButtonItem:backButton];
    [sender.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [sender.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    sender.navigationController.navigationBar.titleTextAttributes=dict;
}

+(NSArray *)FunctionListInitialize
{
    return [[NSArray alloc]initWithObjects:
            @"掌上物流功能列表",
            @"今日资金存量",//1
            @"收入成本月度情况",//2
            @"公司流动资产负债情况",//3
            @"利润月度情况",//4
            @"本年集装箱代理量趋势分析",//5
            @"本年散杂货代理量趋势分析",//6
            @"本年船舶代理量趋势分析",//7
            @"今日保税进出量",//8
            @"今日贸易情况",//9
            @"今日仓储进出量",//10
            @"今日发运业务情况",//11
            @"今日B保公司业务情况",//12
            @"各公司年度盈利情况",//13
            @"报关",//14
            @"报检",//15
            @"要闻咨询",//16
            @"领导讲话",//17
            @"基层动态",//18
            @"党建新闻",//19
            @"货运业务",//20
            @"船务业务",//21
            @"货运财务",//22
            @"船务财务",//23
            @"设备运行记录",//24
            @"设备台账记录",//25
            @"经营情况",//26
            @"开票审批",//27
            @"员工通讯录",//28
            @"企业通讯录",//29
            nil];

}
@end
