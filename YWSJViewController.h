//
//  HYYWViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSJViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *beginDateButton;
    IBOutlet UIButton *endDateButton;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIToolbar *tooBar;
    IBOutlet UIBarButtonItem *barButtonItem;
    IBOutlet UILabel *beginDateLabel;
    IBOutlet UILabel *endDateLabel;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *backview;
}
@property (retain,nonatomic) NSMutableArray *List;
@property int mark;
@end
