//
//  ContactsViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsManager.h"
#import "Person.h"

@interface ContactsViewController : UISearchController
{
    ContactsManager *CoreDataManager;
}
@property (nonatomic, retain) NSMutableArray *List;

@end
