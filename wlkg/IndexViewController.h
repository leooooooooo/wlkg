//
//  IndexViewController.h
//  wlkg
//
//  Created by zhangchao on 15/5/6.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "MenuViewController.h"

@protocol NavigationDelegate <NSObject>
@optional
- (void)showLeftViewController:(BOOL)animated;
- (void)hideSideViewController:(BOOL)animated;
- (void)setneedSwipeShowMenu:(BOOL)animated;
@end

@interface IndexViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIWebViewDelegate,LeftDelegate>
{
    KeychainItemWrapper *status;
}
@property(assign,nonatomic)id<NavigationDelegate>NavigationDelegate;
@end
