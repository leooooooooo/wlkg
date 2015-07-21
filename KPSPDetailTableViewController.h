//
//  KPSPDetailTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPSPDetailTableViewController : UITableViewController
@property (nonatomic,retain)NSString *ID;
@property (retain, nonatomic) NSMutableArray *items;
@property (retain,nonatomic)NSArray *List;
@property int mark;

@end


