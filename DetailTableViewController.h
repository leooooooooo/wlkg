//
//  HYYWTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSString *beginDate;
@property(nonatomic,retain)NSString *endDate;
@property(nonatomic,retain)NSString *objID;
@property int mark;
@end

