//
//  MenuTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/5/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Update.h"
@protocol LeftDelegate <NSObject>
@optional
- (void)Logout;
- (void)ChangePassword;
- (void)ChangeInfo;
@end


@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(assign,nonatomic)id<LeftDelegate>LeftDelegate;
@property(retain,nonatomic)id<UpdateDelegate>UpdateDelegate;
@end
