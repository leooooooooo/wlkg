//
//  MenuTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/5/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LeftDelegate <NSObject>
@optional
- (void)Logout;
@end


@interface MenuTableViewController : UITableViewController
@property(assign,nonatomic)id<LeftDelegate>LeftDelegate;

@end
