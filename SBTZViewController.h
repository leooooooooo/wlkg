//
//  SBTZViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/16.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLRefreshHeadController.h"

@interface SBTZViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
@property (retain,nonatomic) NSMutableArray *List;
@property int mark;
@property (retain,nonatomic) UITableView *tableView;
@end
