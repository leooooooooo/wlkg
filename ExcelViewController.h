//
//  ExcelViewController.h
//  wlkg
//
//  Created by zhangchao on 15/9/6.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcelViewController : UIViewController<UIDocumentInteractionControllerDelegate>
{
    IBOutlet UIButton *beginDateButton;
    IBOutlet UIButton *endDateButton;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIToolbar *tooBar;
    IBOutlet UIBarButtonItem *barButtonItem;
    IBOutlet UILabel *beginDateLabel;
    IBOutlet UILabel *endDateLabel;
    IBOutlet UIWebView *webView;
    IBOutlet UIView *backview;
}
//@property (retain,nonatomic) NSURL *URL;
@property int mark;
@end
