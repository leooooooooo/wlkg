//
//  baoguanViewController.h
//  wlkg
//
//  Created by leo on 14/11/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface baoguanViewController : UIViewController<UIWebViewDelegate>
{
        KeychainItemWrapper *info;
}
- (IBAction)select;
@property (retain, nonatomic) IBOutlet UITextField *ship;
@property (retain, nonatomic) IBOutlet UIWebView *webview;
- (void)loadWebPageWithString:(NSString*)urlString;
- (IBAction)keyboarddisapper:(id)sender;


@end
