//
//  ZHFXViewController.h
//  wlkg
//
//  Created by zhangchao on 15/6/9.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionListTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain,nonatomic) NSArray *List;
@property(retain,nonatomic) NSString *userID;

@end
