//
//  ViewController.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"


#define WebService @"http://218.92.115.55/wlkgbsgsapp/servicebaoshuicompany.asmx"
#define SendName login
#define Result @"GetLoginResult"
#define SoapName @"GetLogin"
#define Token @"MV4FGbDeCY/c0E5Xh9k8Mg=="

#define key1 @"<logogram>%@</logogram>",self.ID.text
#define key2 @"<password>%@</password>",self.PW.text
#define key3 @""
#define key4 @""
#define key5 @""
#define key6 @""
#define key7 @""
#define key8 @""



@interface LoginViewController ()

@end

@implementation LoginViewController

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait; //UIInterfaceOrientationMaskAll
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //webservice
    ServiceMobileApplication =WebService;
    soapmsg1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<soap12:Envelope "
    "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
    "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
    "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
    "<soap12:Body>";
    soapmsg2 = @"</soap12:Body>"
    "</soap12:Envelope>";
    soapmsg = [[NSMutableString alloc]init];
    
    //keychain
    self.keepkeyswitch.on = NO;
    self.autologinswitch.on = NO;
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number"accessGroup:Bundle];
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];

    //从keychain里取出帐号密码状态
    NSString *keepkey = [status objectForKey:(id)kSecAttrAccount];
    NSString *autologin = [status objectForKey:(id)kSecValueData];
    
    
    if([keepkey isEqual:@"1"]){
        self.keepkeyswitch.on = YES;
    }
    if([keepkey isEqual:@"0"]){
        self.keepkeyswitch.on = NO;
    }
    if([autologin isEqual:@"1"]){
        self.autologinswitch.on = YES;
    }
    if([autologin isEqual:@"0"]){
        self.autologinswitch.on = NO;
    }
    

    
    //从keychain里取出帐号密码
    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    NSString *account = [wrapper objectForKey:(id)kSecAttrAccount];
    
    self.ID.text = account;
    self.PW.text = password;
    //清空设置
    //自动登录
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    if ([[status objectForKey:(id)kSecValueData] isEqual:@"1"]) {
        [self signinbt];
    }
    
    NSString *autologin = [status objectForKey:(id)kSecValueData];
    if([autologin isEqual:@"1"]){
        self.autologinswitch.on = YES;
    }
    if([autologin isEqual:@"0"]){
        self.autologinswitch.on = NO;
    }
}


-(IBAction)signinbt{
    
    soap *SendName=[[soap alloc]init];
    SendName.sendDelegate=self;
    // 设置我们之后解析XML时用的关键字，与响应报文中Body标签之间的getMobileCodeInfoResult标签对应
    [SendName matchingElement:Result];
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分
    soapmsg= nil;
    soapmsg = [[NSMutableString alloc]init];
    [soapmsg appendFormat:soapmsg1];
    NSString *soapname = SoapName;
    NSString *token =Token;
    [soapmsg appendFormat:@"<%@ xmlns=\"http://tempuri.org/\">",soapname];
    [soapmsg appendFormat:@"<token>%@</token>",token];
    [soapmsg appendFormat:key1];
    [soapmsg appendFormat:key2];
    [soapmsg appendFormat:key3];
    [soapmsg appendFormat:key4];
    [soapmsg appendFormat:key5];
    [soapmsg appendFormat:key6];
    [soapmsg appendFormat:key7];
    [soapmsg appendFormat:key8];
    [soapmsg appendFormat:@"</%@>",soapname];
    [soapmsg appendFormat:soapmsg2];
    [SendName soapMsg:soapmsg];
    [SendName url:ServiceMobileApplication];
    [SendName send];
    
    
    }

- (IBAction)keepkey:(id)sender {
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"是");
    }else {
        [wrapper resetKeychainItem];
    }
}

- (IBAction)autologin:(id)sender {
    if(self.autologinswitch.on){
        [status setObject:@"1" forKey:(id)kSecValueData];
    }else
    {
        [status setObject:@"0" forKey:(id)kSecValueData];
    }

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

-(void)returnxml:(NSString *)xml{
    parser *pp = [[parser alloc]init];
    pp.send=self;
    [pp nsxmlparser:xml];
    pp = nil;
}

-(void)returnparser:(NSMutableArray *)parser{
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"True"])
    {

        int aaa = [[[parser objectAtIndex:1]objectAtIndex:1] intValue];
        UIAlertView *alert;
        alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"权限不足" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        
        switch (aaa) {
            case 6397:
                [self performSegueWithIdentifier:@"baoshui" sender:self];
                break;
            case 6396:
                [self performSegueWithIdentifier:@"baoshui" sender:self];
                break;
            default:
                [alert show];
                break;
        }
        
        //保存按钮状态
        if(self.keepkeyswitch.isOn)
        {
            [status setObject:@"1" forKey:(id)kSecAttrAccount];
        }else
        {
            [status setObject:@"0" forKey:(id)kSecAttrAccount];
        }
        if(self.autologinswitch.isOn){
            [status setObject:@"1" forKey:(id)kSecValueData];
        }else
        {
            [status setObject:@"0" forKey:(id)kSecValueData];
        }
        if (self.keepkeyswitch.isOn) {
            //保存帐号
            [wrapper setObject:self.ID.text forKey:(id)kSecAttrAccount];
            //保存密码
            [wrapper setObject:self.PW.text forKey:(id)kSecValueData];
        }
        //保存登录信息
        info =[[KeychainItemWrapper alloc] initWithIdentifier:@"info"accessGroup:Bundle];
        [info setObject:[[parser objectAtIndex:1]objectAtIndex:0] forKey:(id)kSecAttrAccount];
        [info setObject:[[parser objectAtIndex:1]objectAtIndex:1] forKey:(id)kSecValueData];
        

    }
    if ([[[parser objectAtIndex:0]objectAtIndex:0]isEqualToString:@"False"]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[[parser objectAtIndex:0]objectAtIndex:1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
    //NSLog([[parser objectAtIndex:0]objectAtIndex:0]);
    
    
}

- (void)dealloc {
    [_keepkeyswitch release];
    [_autologinswitch release];
    [super dealloc];
}
@end

