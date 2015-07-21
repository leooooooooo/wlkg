//
//  KPSPTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "KPSPTableViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "KPSPDetailTableViewController.h"

@interface KPSPTableViewController ()

@end

@implementation KPSPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.List = [self getArray];
    [self.tableView reloadData];
    //
    KPSPDetailTableViewController *vc =[[KPSPDetailTableViewController alloc]init];
    //vc.ID = ojbID;
    vc.title = self.title;
    //[self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)getArray
{
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Approval/BillingApproval/GetDelegationList.aspx?UserCode=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User]];
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    if ([[[Json objectForKey:@"IsGet"]objectAtIndex:0] isEqualToString:@"No"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[Json objectForKey:@"Message"]objectAtIndex:0] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return nil;
    }
    return [Json objectForKey:@"DelegationList"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        // Return the number of rows in the section.
    return self.List.count;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    
    //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
    
    NSString *label1 = [NSString stringWithFormat:@"船名：%@\n航次：%@\n提单：%@\n货名：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3],[[self.List objectAtIndex:indexPath.row]objectAtIndex:4]];
    NSString *label2 = [NSString stringWithFormat:@"提单数：%@\n货主：%@\n放货信息：%@\n备注：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6],[[self.List objectAtIndex:indexPath.row]objectAtIndex:7],[[self.List objectAtIndex:indexPath.row]objectAtIndex:8]];
    
    //Date
    CGRect DateRect = CGRectMake(20,5,WIDTH/2,90);
    UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
    DateLabel.numberOfLines = 4;
    DateLabel.font = [UIFont systemFontOfSize:12];
    DateLabel.text = label1;
    [cell.contentView addSubview:DateLabel];
    
    //Date
    DateRect = CGRectMake(WIDTH/2,5,WIDTH/2,90);
    UILabel *DateLabel1 = [[UILabel alloc]initWithFrame:DateRect];
    DateLabel1.numberOfLines = 4;
    DateLabel1.font = [UIFont systemFontOfSize:12];
    DateLabel1.text = label2;
    [cell.contentView addSubview:DateLabel1];
    
    
    cell.accessoryType = YES;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = [self.List objectAtIndex:indexPath.row];
    
    NSString *ojbID =[info objectAtIndex:0];
    
    KPSPDetailTableViewController *vc =[[KPSPDetailTableViewController alloc]init];
    vc.ID = ojbID;
    //vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
