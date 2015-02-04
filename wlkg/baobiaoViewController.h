//
//  baobiaoViewController.h
//  wlkg
//
//  Created by leo on 14/12/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baobiaoViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
}
- (void)loadWebPageWithString:(NSString*)urlString;


@end
