//
//  HYYWViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "SBTZViewController.h"
#import "Header.h"
#import "UUColor.h"
#import "DetailTableViewController.h"
#import "DropDownListView.h"
#import "AppDelegate.h"
#import <Leo/Leo.h>
@import Leo.HUD;


@interface SBTZViewController (){
    NSMutableArray *chooseArray ;
    NSString *companyID;
    int loadCount;
    int Max_Count;
}
@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;


@end

@implementation SBTZViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [Header NavigationConifigInitialize:self];
    

    
    
    
    self.mark = 25;
    self.List = [[NSMutableArray alloc]init];

    
    
    //查询按钮
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showWithStatus)];
    
    select.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:select];

    
    //下拉菜单
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"物流控股有限公司",@"船务公司",@"仓储公司",@"货运公司",@"贸易公司",@"保税公司",@"郁港保税服务公司",@"陆桥公共保税仓库",@"物流配送中心",@"B保公司"],
                                                   @[@"郏童熙",@"胥童嘉",@"郑嘉琦"]
                                                   ]];
    companyID = [NSString stringWithFormat:@""];
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,60, WIDTH*2, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];
    
    //分割线
    UILabel *fenge1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, WIDTH*2, 2)];
    fenge1.backgroundColor = [UIColor redColor];
    fenge1.text = @"";
    [self.view addSubview:fenge1];
        //
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(-20, 102, WIDTH+20, HEIGHT-102) style:UITableViewStylePlain];
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.backgroundColor = UUCleanGrey;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate= self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    
    //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
    
    //Date
    CGRect DateRect = CGRectMake(0,11,150,22);
    CGPoint i = DateRect.origin;
    //CGSize j = DateRect.size;
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
    //j = FundRect.size;
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
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    //Income
    ((UILabel *)[cell.contentView viewWithTag:2]).text = [array objectAtIndex:4];
    //Cost
    ((UILabel *)[cell.contentView viewWithTag:3]).text = [array objectAtIndex:3];
    
    return cell;
    
}

//头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.95];
    //Date
    UILabel *Date = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 150, 20)];
    CGPoint i = Date.frame.origin;
    //CGSize  j = Date.frame.size;
    Date.textColor=[UIColor whiteColor];
    Date.backgroundColor = [UIColor clearColor];
    Date.text=@"设备号";
    Date.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Date];
    //Fund
    UILabel *Fund = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, i.y, 150, 20)];
    i = Fund.frame.origin;
    //j = Fund.frame.size;
    Fund.textColor=[UIColor whiteColor];
    Fund.backgroundColor = [UIColor clearColor];
    Fund.text=@"设备类型";
    Fund.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Fund];
    //DOD
    UILabel *DOD = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH*2/3, i.y, 150, 20)];
    DOD.textColor=[UIColor whiteColor];
    DOD.backgroundColor = [UIColor clearColor];
    DOD.text=@"设备名称";
    DOD.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:DOD];
    
    return myView;
}


//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSMutableArray *)getArray:(long)page
{
    
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Equipment/GetEquipmentRecord.aspx?CodeDepartment=%@&SelectCodeDepartment=%@&Pages=%d",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_Department],companyID,loadCount];
    NSError *error;
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setTimeoutInterval:60.0f];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    if ([[[Json objectForKey:@"IsGet"]objectAtIndex:0] isEqualToString:@"NO"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[Json objectForKey:@"Message"]objectAtIndex:0] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return nil;
    }

    return [Json objectForKey:@"EquipmentRecord"];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = [self.List objectAtIndex:indexPath.row];
    
    NSString *ojbID =[info objectAtIndex:0];
    
    DetailTableViewController *vc =[[DetailTableViewController alloc]init];

    vc.objID =ojbID;
    vc.mark = self.mark;
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}


-(void)showWithStatus
{
    [HUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(select) withObject:nil afterDelay:0.1f];
}

- (void)select{

    //self.List = [self getArray:loadCount];
    [self.refreshControll startPullDownRefreshing];

    //[self.tableView reloadData];
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

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    
    switch (index) {
        case 0:
            companyID = @"";   //物流控股
            break;
        case 1:
            companyID = @"6373";   //东源
            break;
        case 2:
            companyID = @"6377";   //东泰
            break;
        case 3:
            companyID = @"6372";   //东润
            break;
        case 4:
            companyID = @"6374";   //灌河国际
            break;
        case 5:
            companyID = @"6375";   //新陆桥
            break;
        case 6:
            companyID = @"6395";   //新苏港
            break;
        case 7:
            companyID = @"6397";   //新海湾
            break;
        case 8:
            companyID = @"6376";   //新圩港
            break;
        case 9:
            companyID = @"6378";   //新圩港
            break;
        case 10:
            companyID = @"FF00ED5555FA60BAE043A864016A60BA";   //新圩港
            break;
        default:
            break;
    }
}


#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

- (CLLRefreshHeadController *)refreshControll
{
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:self.tableView viewDelegate:self];
    }
    return _refreshControll;
}

#pragma mark-
#pragma mark- CLLRefreshHeadContorllerDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}
- (BOOL)keepiOS7NewApiCharacter {
    
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (void)beginPullDownRefreshing {
    Max_Count = 15;
    loadCount = 1;
    
    self.List = [self getArray:loadCount];
    
    if(self.List.count<15)
    {
        Max_Count = loadCount;
    }
    
    NSLog(@"%d",loadCount);
    [self performSelector:@selector(endRefresh) withObject:nil];
}
- (void)beginPullUpLoading
{
    NSLog(@"%d",loadCount);
    
    [self.List addObjectsFromArray:[self getArray:loadCount]];
    
    [self performSelector:@selector(endLoadMore) withObject:nil];
    
}
//是显示更多
- (BOOL)hasRefreshFooterView {
    if (self.List.count > 0 && loadCount < Max_Count) {
        return YES;
    }
    return NO;
}

- (void)endRefresh {
    loadCount =2;
    
    [self.tableView reloadData];
    
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    loadCount ++;
    
    [self.tableView reloadData];
    
    [self.refreshControll endPullUpLoading];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


@end
