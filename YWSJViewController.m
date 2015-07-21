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
#import "SVProgressHUD.h"

@interface YWSJViewController ()

@end

@implementation YWSJViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;

    
    
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
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";

        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(0,11,150,22);
        CGPoint i = DateRect.origin;
        CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentCenter;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(WIDTH/3, i.y, 150, 22);
        UILabel *FundLabel = [[UILabel alloc]initWithFrame:FundRect];
        i = FundRect.origin;
        j = FundRect.size;
        FundLabel.font = [UIFont systemFontOfSize:16];
        FundLabel.tag = 2;
        FundLabel.textAlignment= NSTextAlignmentCenter;
        FundLabel.textColor = UUGreen;
        [cell.contentView addSubview:FundLabel];
        
        //DOD
        CGRect DODRect = CGRectMake(WIDTH*2/3, i.y, 150, 22);
        UILabel *DODLabel = [[UILabel alloc]initWithFrame:DODRect];
        DODLabel.font = [UIFont systemFontOfSize:16];
        DODLabel.tag = 3;
        DODLabel.textAlignment= NSTextAlignmentCenter;
        DODLabel.textColor = UURed;
        //为图片添加边框
        CALayer *layer = [DODLabel layer];
        layer.cornerRadius = 4;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 0;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:DODLabel];
    
    
    NSArray *array = [self.List objectAtIndex:indexPath.row];
    
    //Month
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [NSString stringWithFormat:@"%@/%@",[array objectAtIndex:2],[array objectAtIndex:3]];
    //Income
    ((UILabel *)[cell.contentView viewWithTag:2]).text = [array objectAtIndex:4];
    //Cost
    ((UILabel *)[cell.contentView viewWithTag:3]).text = [array objectAtIndex:5];

    return cell;
    
}
*/
//头部
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.95];
    //Date
    UILabel *Date = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 150, 20)];
    CGPoint i = Date.frame.origin;
    CGSize  j = Date.frame.size;
    Date.textColor=[UIColor whiteColor];
    Date.backgroundColor = [UIColor clearColor];
    Date.text=@"船名/航次";
    Date.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Date];
    //Fund
    UILabel *Fund = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, i.y, 150, 20)];
    i = Fund.frame.origin;
    j = Fund.frame.size;
    Fund.textColor=[UIColor whiteColor];
    Fund.backgroundColor = [UIColor clearColor];
    Fund.text=@"提单号";
    Fund.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Fund];
    //DOD
    UILabel *DOD = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH*2/3, i.y, 150, 20)];
    DOD.textColor=[UIColor whiteColor];
    DOD.backgroundColor = [UIColor clearColor];
    DOD.text=@"客户名称";
    DOD.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:DOD];
    
    return myView;
}
*/

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
        default:return [Json objectForKey:@""];
            break;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = [self.List objectAtIndex:indexPath.row];
    
    NSString *ojbID =[info objectAtIndex:0];
    
    DetailTableViewController *vc =[[DetailTableViewController alloc]init];
    vc.beginDate = beginDateLabel.text;
    vc.endDate =endDateLabel.text;
    vc.objID =ojbID;
    vc.mark = self.mark;
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
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(select) withObject:nil afterDelay:0.1f];
}

- (void)select{
    
    
    NSDate *beginDate = [self dateFromString:beginDateLabel.text];
    NSDate *endDate = [self dateFromString:endDateLabel.text];
    NSDate *earlyDate = [beginDate earlierDate:endDate];
    
    if ([earlyDate isEqualToDate:endDate] && ![earlyDate isEqualToDate:beginDate]) {
        
        [self alterMessage:@"开始时间不得晚于结束时间"];
        [SVProgressHUD dismiss];

        return;
        
    }
    
    self.List = [self getArray];
    [tableView reloadData];
    [SVProgressHUD dismiss];

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
