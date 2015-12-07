//
//  HYYWViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "YWSJViewController.h"
#import "Header.h"
#import "UUColor.h"
#import "DetailTableViewController.h"
#import <Leo/Leo.h>
#import "AppDelegate.h"
@import Leo.Post;
@import Leo.Table;
@import Leo.HUD;

@interface YWSJViewController ()

@end

@implementation YWSJViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [Header NavigationConifigInitialize:self];


    
    
    beginDateLabel.text = [self dateToStringDate:[NSDate date]];
    endDateLabel.text = [self dateToStringDate:[NSDate date]];
    
    
    //查询按钮
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showWithStatus)];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];
    
    
    //分割线
    UILabel *fenge = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, WIDTH*2, 2)];
    fenge.backgroundColor = [UIColor redColor];
    fenge.text = @"";
    [self.view addSubview:fenge];
    //backview
    [backview setFrame:CGRectMake(0, 60, WIDTH, 50)];
    //
    [tableView setFrame:CGRectMake(0, 48, WIDTH, HEIGHT-48)];
    if (self.mark == 32|self.mark==33) {
    [tableView setFrame:CGRectMake(0, 48, WIDTH, HEIGHT-48)];
        [self.view bringSubviewToFront:tableView];
        [self showWithStatus];
    }
    //tableView.sectionHeaderHeight = 44;
    //tableView.backgroundColor = UUCleanGrey;
    tableView.tableFooterView = [[UIView alloc]init];
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
    
    NSString *label1 =[[NSString alloc]init];
    NSString *label2 =[[NSString alloc]init];
    
    switch (self.mark) {
        case 20:
            label1 = [NSString stringWithFormat:@"贸别：%@\n船名：%@\n航次：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@\n货名：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6]];
            break;
        case 21:
            label1 = [NSString stringWithFormat:@"贸别：%@\n船名：%@\n航次：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5]];
            break;
        case 22:
            label1 = [NSString stringWithFormat:@"贸别：%@\n船名：%@\n航次：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@\n货名：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6]];
            break;
        case 23:
            label1 = [NSString stringWithFormat:@"贸别：%@\n船名：%@\n航次：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5]];
            break;
        case 32:
            label1 = [NSString stringWithFormat:@"委托号：%@\n船名：%@\n航次：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:0],[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2]];
            //label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5]];
            break;
        case 33:
            label1 = [NSString stringWithFormat:@"船名航次：%@\n应付金额：%@\n应收金额：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:0],[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2]];
            //label2 = [NSString stringWithFormat:@"提单号：%@\n客户名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5]];
            break;
        case 34:
            label1 = [NSString stringWithFormat:@"保税部：%@\n船名：%@\n货物名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"货主名称：%@\n提单数：%@\n箱：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6]];
            break;
        case 35:
            label1 = [NSString stringWithFormat:@"货代：%@\n货物：%@\n包装：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"件重：%@\n航次：%@\n提单：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6]];
            break;
        case 36:
            label1 = [NSString stringWithFormat:@"保税部：%@\n船名：%@\n货物名称：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
            label2 = [NSString stringWithFormat:@"货主名称：%@\n提单数：%@\n箱：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:4],[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6]];
            break;
        case 37:
            label1 = [NSString stringWithFormat:@"货代：%@\n货名：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:0],[[self.List objectAtIndex:indexPath.row]objectAtIndex:1]];
            label2 = [NSString stringWithFormat:@"日期：%@\n实收金额：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3]];
                      
            break;
        default:
            break;
    }
    
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

-(NSMutableArray *)getArray
{

    NSString *URL = [[NSString alloc]init];
    switch (self.mark) {
        case 20://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Business/GetFreightBuiness.aspx?startTime=%@&endTime=%@",beginDateLabel.text,endDateLabel.text];
            break;
        case 21://船务业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Business/GetShippingBuiness.aspx?startTime=%@&endTime=%@",beginDateLabel.text,endDateLabel.text];
            break;
        case 22://货运财务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetFeightFinance.aspx?startTime=%@&endTime=%@",beginDateLabel.text,endDateLabel.text];
            break;
        case 23://船务财务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetShippingFinance.aspx?startTime=%@&endTime=%@",beginDateLabel.text,endDateLabel.text];
            break;
        case 32://船务财务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Business/getDIstributionBuiness.aspx"];
            break;
        case 33://船务财务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/finance/getDistributionFinance.aspx"];
            break;
        case 34://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Business/GetBS_BusinessManagementCenter.aspx?CodeUser=%@&startTime=%@&endTime=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],beginDateLabel.text,endDateLabel.text];
            break;
        case 35://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetBS_FinanceManagementCenter.aspx?CodeUser=%@&startTime=%@&endTime=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],beginDateLabel.text,endDateLabel.text];
            break;
        case 36://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Business/GetCC_BusinessManagementCenter.aspx?CodeUser=%@&startTime=%@&endTime=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],beginDateLabel.text,endDateLabel.text];
            break;
        case 37://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetCC_FinanceManagementCenter.aspx?CodeUser=%@&startTime=%@&endTime=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],beginDateLabel.text,endDateLabel.text];
            break;
        default:
            break;
    }
    
    NSError *error;
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setTimeoutInterval:60.0f];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    switch (self.mark) {
        case 20:return [Json objectForKey:@"FreightBuiness"];
            break;
        case 21:return [Json objectForKey:@"ShippingBuiness"];
            break;
        case 22:return [Json objectForKey:@"FeightFinance"];
            break;
        case 23:return [Json objectForKey:@"ShippingFinance"];
            break;
        case 32:return [Json objectForKey:@"DistributionBuiness"];
            break;
        case 33:return [Json objectForKey:@"DistributionFinance"];
            break;
        case 34:return [Json objectForKey:@"BusinessManagementCenter"];
            break;
        case 35:return [Json objectForKey:@"BusinessManagementCenter"];
            break;
        case 36:return [Json objectForKey:@"BusinessManagementCenter"];
            break;
        case 37:return [Json objectForKey:@"FinanceManagementCenter"];
            break;
        default:return [Json objectForKey:@""];
            break;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = [self.List objectAtIndex:indexPath.row];
    
    NSString *ojbID =[info objectAtIndex:0];
        
    
    NSString *urlString = @"";
    switch (self.mark) {
        case 20:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Business/GetFreightBuinessDetail.aspx";
            break;
        case 21:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Business/GetShippingBuinessDeatil.aspx";
            break;
        case 22:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetFeightFinanceDetail.aspx";
            break;
        case 23:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetShippingFinanceDetail.aspx";
            break;
        case 24:
            urlString = @"http://218.92.115.55/wlkg/Service/Equipment/GetEquipmentRunningDetail.aspx";
            break;
        case 25:
            urlString = @"http://218.92.115.55/wlkg/Service/Equipment/GetEquipmentRecordDetail.aspx";
            break;
        case 34:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Business/GetBS_BusinessManagementCenterDetail.aspx";
            break;
        case 35:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetBS_FinanceManagementCenterDetail.aspx";
            break;
        case 36:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Business/GetCC_BusinessManagementCenterDetail.aspx";
            break;
        case 37:
            urlString = @"http://218.92.115.55/wlkg/Service/Supervise/Finance/GetCC_FinanceManagementCenterDetail.aspx";
            break;
        default:
            break;
    }
    //1确定地址NSURL
    NSString *bodyStr = [NSString stringWithFormat:@"startTime=%@&endTime=%@&ID=%@&CodeUser=%@",beginDateLabel.text,endDateLabel.text,ojbID,[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User]];

    NSDictionary *data = [[NSDictionary alloc]init];
    if (self.mark ==32) {
        
        NSString *key = @"委托号+船名+航次+配车计划+运输中+制单+结算+委托结束";
        NSArray *keys = [key componentsSeparatedByString:@"+"];
        NSMutableDictionary *dd = [[NSMutableDictionary alloc]initWithObjects:info forKeys:keys];
        [dd setObject:key forKey:@"Order"];
        data = dd;
    }
    else if (self.mark ==33)
    {
        
        NSString *key = @"船名航次+应付金额+应收金额";
        NSArray *keys = [key componentsSeparatedByString:@"+"];
        NSMutableDictionary *dd = [[NSMutableDictionary alloc]initWithObjects:info forKeys:keys];
        [dd setObject:key forKey:@"Order"];
        data = dd;
    }
    else
    {
        data = [Post getSynchronousRequestDataJSONSerializationWithURL:urlString withHTTPBody:bodyStr];

    }
    if (self.mark == 37) {
        return;
    }
    
    UIViewController *vc = [Table DetailTable:data];
    vc.title = self.title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)beginTimeControl:(id)sender{
    
    if (!beginDateButton.selected) {
        beginDateButton.selected = YES;
        datePicker.hidden = NO;
        datePicker.date = [self dateFromString:beginDateLabel.text];
        
        tooBar.hidden = NO;
    }else{
        [self deletedatePicker:nil];
    }
    
}

- (IBAction)endTimeControl:(id)sender{
    
    if (!endDateButton.selected) {
        endDateButton.selected = YES;
        datePicker.hidden = NO;
        datePicker.date = [self dateFromString:endDateLabel.text];
        tooBar.hidden = NO;
    }else{
        [self deletedatePicker:nil];
    }
    
}

- (IBAction)deletedatePicker:(id)sender{
    
    if (endDateButton.selected) {
        endDateLabel.text = [self dateToStringDate:datePicker.date];
        endDateButton.selected = NO;
    }
    if (beginDateButton.selected) {
        beginDateLabel.text = [self dateToStringDate:datePicker.date];
        beginDateButton.selected = NO;
    }
    
    datePicker.hidden = YES;
    tooBar.hidden = YES;
}

-(void)showWithStatus
{
    [HUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(select) withObject:nil afterDelay:0.1f];
}

- (void)select{
    
    
    NSDate *beginDate = [self dateFromString:beginDateLabel.text];
    NSDate *endDate = [self dateFromString:endDateLabel.text];
    NSDate *earlyDate = [beginDate earlierDate:endDate];
    
    if ([earlyDate isEqualToDate:endDate] && ![earlyDate isEqualToDate:beginDate]) {
        
        [self alterMessage:@"开始时间不得晚于结束时间"];
        [HUD dismiss];

        return;
        
    }
    
    self.List = [self getArray];
    [tableView reloadData];
    [HUD dismiss];

}

- (void)alterMessage:(NSString *)messageString{
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [al show];
}

#pragma mark- ----------ComputationTime

- (NSString *)dateToStringDate:(NSDate *)Date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [dateFormatter stringFromDate:Date];
    destDateString = [destDateString substringToIndex:10];
    
    return destDateString;
}

- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[formatter dateFromString:dateString];
    
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date1 timeIntervalSinceReferenceDate] + 8*3600)];
    return newDate;
}

@end
