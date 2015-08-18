//
//  ChangePasswordViewController.m
//  wlkg
//
//  Created by zhangchao on 15/6/17.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Header.h"
#import "AppDelegate.h"

@interface ChangePasswordViewController ()
@property (retain,nonatomic)NSString *theOldPassword;
@property (retain,nonatomic)NSString *theNewPassword;
@property (retain,nonatomic)NSString *theTwiceNewPassword;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Header NavigationConifigInitialize:self];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title=@"修改密码";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];
    
    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.navigationItem setRightBarButtonItem:finishButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(20,11,70,22);
        CGPoint i = DateRect.origin;
        CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        //DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentLeft;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(i.x+j.width+20, i.y, 250, 22);
        UITextField *passwordtext = [[UITextField alloc]initWithFrame:FundRect];
        passwordtext.tag =indexPath.row;
        passwordtext.secureTextEntry = YES;
        passwordtext.returnKeyType = UIReturnKeyDone;
        passwordtext.clearButtonMode = YES;
        passwordtext.delegate = self;
        [cell.contentView addSubview:passwordtext];
        
        NSArray *name = [[NSArray alloc]initWithObjects:@"原密码",@"新密码",@"再次确认", nil];
        //Date
        DateLabel.text = [name objectAtIndex:indexPath.row];
    

    NSArray *PASS = [[NSArray alloc]initWithObjects:@"请输入旧密码",@"请输入新密码",@"请再次输入新密码", nil];
    //Fund
    passwordtext.placeholder = [PASS objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [passwordtext addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.theOldPassword = textField.text;
            break;
        case 1:
            self.theNewPassword = textField.text;
            break;
        case 2:
            self.theTwiceNewPassword = textField.text;
            break;
        default:
            break;
    }
}

- (void)save
{
    UIAlertView *alert;
    if ([self.theOldPassword isEqualToString: self.theTwiceNewPassword]) {
        alert = [[UIAlertView alloc]initWithTitle:@"修改失败" message:@"两次输入的密码不同" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/ChangePassword.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:10.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"CodeUser=%@&OldPassword=%@&NewPassword=%@&AppName=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],self.theOldPassword,self.theNewPassword,AppName];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        UIAlertView *alert;
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Change = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"%@", Change);
            
            if([[Change objectForKey:@"IsChange"]isEqualToString:@"Yes"])
            {
                alert = [[UIAlertView alloc]initWithTitle:@"修改成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
            }
            else
            {
                alert = [[UIAlertView alloc]initWithTitle:@"修改失败" message:[Change objectForKey:@"Message"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            [alert show];
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:@"更新失败，网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
        
        
    }];
    }
    

}

@end
