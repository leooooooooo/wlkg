//
//  baoguanViewController.m
//  wlkg
//
//  Created by leo on 14/11/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "baoguanViewController.h"
#import "Header.h"

#define URL @"http://218.92.115.55/wlkgbsgsapp/wlkgbsgs/declare.html?info="

@interface baoguanViewController ()

@end


@implementation baoguanViewController


//ios6

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape; //UIInterfaceOrientationMaskAll
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)select {
    [self.ship resignFirstResponder];
    NSMutableString *urlString = [[NSMutableString alloc]init];
    info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
    
    NSString *userID = [info objectForKey:(id)kSecAttrAccount];
    NSString *codeDP = [info objectForKey:(id)kSecValueData];
    NSMutableString *mix;
    mix=[[NSMutableString alloc]init];
    [mix appendString:userID];
    [mix appendString:@"+"];
    [mix appendString:codeDP];
    NSString *ship = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self.ship.text, NULL, NULL,  kCFStringEncodingUTF8 );
    [mix appendString:@"+"];
    [mix appendString:ship];

    [urlString appendFormat:URL];
    [urlString appendString:mix];
    self.webview.delegate = self;
    self.webview.scalesPageToFit =NO;
    
    //[self.webview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self loadWebPageWithString:urlString];
    
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

- (IBAction)keyboarddisapper:(id)sender {
    [self.ship resignFirstResponder];
}


- (void)dealloc {
    [_ship release];
    [_webview release];
    [super dealloc];
}
@end
