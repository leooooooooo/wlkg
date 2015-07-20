//
//  ZHFXViewController.m
//  wlkg
//
//  Created by zhangchao on 15/6/9.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "FunctionListTableViewController.h"
#import "Header.h"
#import "JRZJCLViewController.h"
#import "SRCBViewController.h"
#import "GSZCLDFZQKViewController.h"
#import "LRYDQKViewController.h"
#import "BNJZXDLLQSFXViewController.h"
#import "BNSZHDLLQSFXViewController.h"
#import "BNCBDLLQSFXViewController.h"
#import "JRBBGSYWQKViewController.h"
#import "JRBSJCLViewController.h"
#import "JRFYYWQKViewController.h"
#import "JRCCJCLViewController.h"
#import "JRMYQKViewController.h"
#import "GGSNDLRQKViewController.h"
#import "BGCXViewController.h"
#import "BJCXViewController.h"
#import "NewsListTableViewController.h"
#import "YWSJViewController.h"
#import "SBTZViewController.h"
#import "SBYXViewController.h"
#import "ExcelListTableViewController.h"
#import "KPSPTableViewController.h"
#import "AppDelegate.h"

@interface FunctionListTableViewController ()
@property(nonatomic,strong)AppDelegate *delegate;
@end

@implementation FunctionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = [[UIApplication sharedApplication]delegate];

    
    //初始化二级菜单
    
    NSArray *name = [[NSArray alloc]initWithObjects:
                     @"今日资金存量",//1
                     @"收入成本月度情况",//2
                     @"公司流动资产负债情况",//3
                     @"利润月度情况",//4
                     @"本年集装箱代理量趋势分析",//5
                     @"本年散杂货代理量趋势分析",//6
                     @"本年船舶代理量趋势分析",//7
                     @"今日保税进出量",//8
                     @"今日贸易情况",//9
                     @"今日仓储进出量",//10
                     @"今日发运业务情况",//11
                     @"今日B保公司业务情况",//12
                     @"各公司年度盈利情况",//13
                     @"报关",//14
                     @"报检",//15
                     @"要闻咨询",//16
                     @"领导讲话",//17
                     @"基层动态",//18
                     @"党建新闻",//19
                     @"货运业务",//20
                     @"船务业务",//21
                     @"货运财务",//22
                     @"船务财务",//23
                     @"设备运行记录",//24
                     @"设备台账记录",//25
                     @"经营情况",//26
                     @"开票审批",//27
                     nil];
    NSMutableArray *mark = [[NSMutableArray alloc]init];
    for (int i = 0;i<name.count; i++) {
        [mark addObject:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",i+1],@"mark",nil]];
    }
    
    self.delegate.FunctionMark =[[NSDictionary alloc]initWithObjects:mark forKeys:name];

    // Do any additional setup after loading the view.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    UITableViewCell *cell =[self customCellByXib:tableView withIndexPath:indexPath];
    
    //通过nib自定义cell
    
    
    
    //default:assert(cell !=nil);
    //break;
    
    
    
    return cell;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = 2;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
        
        //发送者
        CGPoint i =imageRect.origin;
        CGSize j = imageRect.size;
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, WIDTH/1.5, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [self.List objectAtIndex:indexPath.row];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:self.title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *FunctionName =[self.List objectAtIndex:indexPath.row];
    NSLog(FunctionName,nil);
    int mark =[[[self.delegate.FunctionMark objectForKey:FunctionName]objectForKey:@"mark"]intValue];
    
    UIViewController *vc = [[UIViewController alloc]init];

    vc.view.backgroundColor = [UIColor whiteColor];
    switch (mark) {
        case 1:{
            vc = [[JRZJCLViewController alloc]init];
        };
            break;
        case 2:{
            vc = [[SRCBViewController alloc]init];
        };
            break;
        case 3:{
            vc = [[GSZCLDFZQKViewController alloc]init];
        };
            break;
        case 4:{
            vc = [[LRYDQKViewController alloc]init];
        };
            break;
        case 5:{
            vc = [[BNJZXDLLQSFXViewController alloc]init];
        };
            break;
        case 6:{
            vc = [[BNSZHDLLQSFXViewController alloc]init];
        };
            break;
        case 7:{
            vc = [[BNCBDLLQSFXViewController alloc]init];
        };
            break;
        case 8:{
            vc = [[JRBSJCLViewController alloc]init];
        };
            break;
        case 9:{
            vc = [[JRMYQKViewController alloc]init];
        };
            break;
        case 10:{
            vc = [[JRCCJCLViewController alloc]init];
        };
            break;
        case 11:{
            vc = [[JRFYYWQKViewController alloc]init];
        };
            break;
        case 12:{
            vc = [[JRBBGSYWQKViewController alloc]init];
            break;
        };
        case 13:{
            vc = [[GGSNDLRQKViewController alloc]init];
        };
            break;
        case 14:{
            vc = [[BGCXViewController alloc]init];
        };
            break;
        case 15:{
            vc = [[BJCXViewController alloc]init];
        };
            break;
        case 16:{
            NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
            news.mark = mark;
            vc=news;
        };
            break;
        case 17:{
            NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
            news.mark = mark;
            vc=news;        };
            break;
        case 18:{
            NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
            news.mark = mark;
            vc=news;
        };
            break;
        case 19:{
            NewsListTableViewController *news = [[NewsListTableViewController alloc]init];
            news.mark = mark;
            vc=news;
        };
            break;
        case 20:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 21:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 22:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 23:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 24:{
            vc = [[SBYXViewController alloc]init];
        };
            break;
        case 25:{
            vc = [[SBTZViewController alloc]init];
        };
            break;
        case 26:{
            ExcelListTableViewController *excel = [[ExcelListTableViewController alloc]init];
            excel.mark = mark;
            vc=excel;
        };
        case 27:{
            vc = [[KPSPTableViewController alloc]init];
        };
            break;
        default:
            break;
            
    }
    vc.title = FunctionName;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
