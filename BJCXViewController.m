//
//  BJCXViewController.m
//  wlkg
//
//  Created by zhangchao on 15/6/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "BJCXViewController.h"
#import "Header.h"
#import "AppDelegate.h"

@interface BJCXViewController ()
@property(retain,nonatomic)NSArray *array;
@end

@implementation BJCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    self.view.backgroundColor =[UIColor whiteColor];
    //输入名称
    UILabel *shenhelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,60, self.view.frame.size.width, 40)];
    shenhelabel.text = [NSString stringWithFormat:@"                        %@",@"船名"];
    shenhelabel.font = [UIFont systemFontOfSize:15];
    shenhelabel.backgroundColor = [UIColor grayColor];
    shenhelabel.userInteractionEnabled = YES;
    [self.view addSubview:shenhelabel];
    
    
    //输入框
    UITextField *lb = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,67,120,30)];
    lb.backgroundColor=[UIColor whiteColor];
    lb.layer.cornerRadius = 5.0 ;
    lb.borderStyle = UITextBorderStyleRoundedRect;
    lb.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [lb addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
    [lb setAutocorrectionType:UITextAutocorrectionTypeNo];
    lb.tag = 2;
    [self.view addSubview:lb];
    //查询按钮
    //UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(select:)];
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(select:)];
    
    
    //UIImage *redbutton =[UIImage imageNamed:@"redbutton.png"];
    
    //[select setBackgroundImage:redbutton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];
    //分割线
    UILabel *fenge = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 2)];
    fenge.backgroundColor = [UIColor redColor];
    fenge.text = @"";
    [self.view addSubview:fenge];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing
{
    [((UITextField *)[self.view viewWithTag:2]) resignFirstResponder];
}

-(void)select:(id)sender
{
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Inspect.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:20.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"CodeDepartment=%@&ShipName=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_Department],[((UITextField *)[self.view viewWithTag:2]).text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
            self.array = [Info objectForKey:@"Inspect"];
            
            //Tabel
            UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 102, WIDTH,HEIGHT-102) style:UITableViewStylePlain];
            tableview.dataSource=self;
            tableview.delegate=self;
            tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableview.tableFooterView = [[UIView alloc] init];
            tableview.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:tableview];
            
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络超时请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络超时请重试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.array.count;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    
    
    //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
    
    //Date
    CGRect DateRect = CGRectMake(20,5,WIDTH/2,90);
    UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
    DateLabel.numberOfLines = 4;
    DateLabel.font = [UIFont systemFontOfSize:12];
    DateLabel.text = [NSString stringWithFormat:@"报检类别：%@\n货主名称：%@\n船名：%@\n船次：%@",[[self.array objectAtIndex:indexPath.row]objectAtIndex:0],[[self.array objectAtIndex:indexPath.row]objectAtIndex:1],[[self.array objectAtIndex:indexPath.row]objectAtIndex:2],[[self.array objectAtIndex:indexPath.row]objectAtIndex:3]];
    [cell.contentView addSubview:DateLabel];
    
    //Date
    DateRect = CGRectMake(WIDTH/2,5,WIDTH/2,90);
    UILabel *DateLabel1 = [[UILabel alloc]initWithFrame:DateRect];
    DateLabel1.numberOfLines = 4;
    DateLabel1.font = [UIFont systemFontOfSize:12];
    DateLabel1.text = [NSString stringWithFormat:@"提单号：%@\n提单数：%@\n货物名称：%@",[[self.array objectAtIndex:indexPath.row]objectAtIndex:4],[[self.array objectAtIndex:indexPath.row]objectAtIndex:5],[[self.array objectAtIndex:indexPath.row]objectAtIndex:6]];
    [cell.contentView addSubview:DateLabel1];
    
    
    cell.accessoryType = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    UIWebView *up =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://218.92.115.55/wlkg/Page/InspectReported.html?info=%@+%@+%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],[[self.array objectAtIndex:indexPath.row]objectAtIndex:7],[[self.array objectAtIndex:indexPath.row]objectAtIndex:4]]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [up loadRequest:request];
    [vc.view addSubview:up];
    vc.title = @"报检";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
