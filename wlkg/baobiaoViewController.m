//
//  baobiaoViewController.m
//  wlkg
//
//  Created by leo on 14/12/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "baobiaoViewController.h"

@interface baobiaoViewController ()

@end

@implementation baobiaoViewController

#define URL @"http://218.92.115.100:81/wlbi/wlbi_ph/index_bi_ph.aspx"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSString *urlString =URL;
    webView.delegate = self;
    webView.scalesPageToFit =NO;
    [activityIndicatorView setCenter:self.view.center];
    [self loadWebPageWithString:urlString];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//回调
//UIWebView委托方法，开始加载一个url时候调用此方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}
//UIWebView委托方法，url加载完成的时候调用此方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
