//
//  MainTabBarViewController.h
//  wlkg
//
//  Created by zhangchao on 15/6/24.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "KeychainItemWrapper.h"

@protocol NavigationDelegate <NSObject>
@optional
- (void)showLeftViewController:(BOOL)animated;
- (void)hideSideViewController:(BOOL)animated;
- (void)setneedSwipeShowMenu:(BOOL)animated;
@end

@interface MainTabBarViewController : UITabBarController<LeftDelegate,UITabBarDelegate>{
    KeychainItemWrapper *status;
}
@property(assign,nonatomic)id<NavigationDelegate>NavigationDelegate;


@end
