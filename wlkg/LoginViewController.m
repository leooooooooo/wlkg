//
//  ViewController.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Header.h"
#import "MenuViewController.h"
#import "IndexViewController.h"
#import "MainTabBarViewController.h"
#import "MainNavigationController.h"

#define UpdateAlertViewTag 1



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.UpdateDelegate = [[[Update alloc]init]autorelease];
    [self.UpdateDelegate GetUpdateInfo:self.view];
    //当前版本
    UILabel *Version = [[[UILabel alloc]initWithFrame:CGRectMake(20, HEIGHT-65, 200, 30)]autorelease];
    Version.text = [NSString stringWithFormat:@"当前版本：%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    Version.font = [UIFont boldSystemFontOfSize:14];
    Version.textColor = [UIColor grayColor];
    [self.view addSubview:Version];

    
    KeyChain = [NSUserDefaults standardUserDefaults];

    self.keepkeyswitch.on = [KeyChain boolForKey:@"KeepKey"];
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];
    self.ID.text = [KeyChain objectForKey:@"UserName"];
    self.PW.text = [KeyChain objectForKey:@"Password"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if ([KeyChain boolForKey:@"AutoLogin"]) {
        [self signinbt];
    }
    
    self.autologinswitch.on = [KeyChain boolForKey:@"AutoLogin"];

}


-(IBAction)signinbt{
    
    
    
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"HTTP://boea.cn/MobilePlatform/Login.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];

    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"Logogram=%@&Password=%@&DeviceToken=%@&DeviceType=iOS&AppName=%@", self.ID.text, self.PW.text,[(AppDelegate *)[[UIApplication sharedApplication]delegate]DeviceToken],AppName];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"%@", Info);

            if([[Info objectForKey:@"IsLogin"]isEqualToString:@"Yes"])
            {
                //保存登录信息
                AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                delegate.DeviceBinding = [Info objectForKey:@"DeviceBinding"];
                delegate.Code_User=[Info objectForKey:@"Code_User"] ;
                delegate.Code_Department=[Info objectForKey:@"Code_Department"] ;
                delegate.Code_Company=[Info objectForKey:@"Code_Company"] ;
                delegate.UserName=[Info objectForKey:@"UserName"] ;
                delegate.Department = [Info objectForKey:@"Department"];
                
                //IndexViewController *index =[[IndexViewController alloc]initWithNibName:nil bundle:nil];
                MainTabBarViewController *index = [[MainTabBarViewController alloc]init];
                MainNavigationController *mainViewController=[[[MainNavigationController alloc]initWithRootViewController:index]autorelease];
                //mainViewController.view.backgroundColor=[UIColor grayColor];
                
                MenuViewController *leftViewController=[[MenuViewController alloc]initWithNibName:nil bundle:nil];
                //leftViewController.view.backgroundColor=[UIColor brownColor];
                
                _sideViewController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
                _sideViewController.rootViewController=mainViewController;
                _sideViewController.leftViewController=leftViewController;
                
                index.NavigationDelegate=_sideViewController;
                leftViewController.LeftDelegate = index;
                _sideViewController.leftViewShowWidth=WIDTH*4/5;
                //index.setneedSwipeShowMenu=YES;//默认开启的可滑动展示

                //动画效果可以被自己自定义，具体请看api
                /*
                [_sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
                    //使用简单的平移动画
                    rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
                }];
                */
                
                [self presentViewController:_sideViewController animated:YES completion:nil];
                //[self performSegueWithIdentifier:@"index" sender:self];
                
                //保存按钮状态
                
                [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
                [KeyChain setBool:self.keepkeyswitch.isOn forKey:@"KeepKey"];
                [KeyChain synchronize];

                if (self.keepkeyswitch.isOn) {
                    [KeyChain setObject:self.ID.text forKey:@"UserName"];
                    [KeyChain setObject:self.PW.text forKey:@"Password"];
                    [KeyChain synchronize];
                }
            }
            else
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[Info objectForKey:@"Message"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
    }];
    
    }

- (IBAction)keepkey:(id)sender {
    if (![sender isOn]){
        [KeyChain removeObjectForKey:@"Password"];
    }
}

- (IBAction)autologin:(id)sender {
    [KeyChain setBool:self.autologinswitch.isOn forKey:@"AutoLogin"];
}

- (IBAction)keyboarddisapper:(id)sender {
    [self.ID resignFirstResponder];
    [self.PW resignFirstResponder];
}

- (IBAction)topassword:(id)sender {
    [self.PW becomeFirstResponder];
}

- (IBAction)dis:(id)sender {
    [sender resignFirstResponder];
}




- (void)dealloc {
    [super dealloc];
}
@end

