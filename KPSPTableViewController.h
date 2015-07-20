//
//  KPSPTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPSPTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) NSMutableArray *List;
@property int mark;


@end
