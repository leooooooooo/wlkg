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
//#import "ContactsViewController.m"
#import "ExcelViewController.h"
#import <Leo/Leo.h>


@interface FunctionListTableViewController ()
@end

@implementation FunctionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.delegate = [[UIApplication sharedApplication]delegate];

    
    //初始化二级菜单
    
    //self.delegate.FunctionList =
    // Do any additional setup after loading the view.
    [Header NavigationConifigInitialize:self];

    
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",self.title]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *FunctionName =[self.List objectAtIndex:indexPath.row];
    NSLog(FunctionName,nil);
    
    int mark = (int)[[(AppDelegate *)[[UIApplication sharedApplication]delegate]FunctionList] indexOfObject:FunctionName];
    
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
            break;
        case 27:{
            vc = [[KPSPTableViewController alloc]init];
        };
            break;
        case 28:{
            ContactsViewController *cc = [[ContactsViewController alloc]init];
            cc.appName = AppName;
            cc.navigationTitleColor =NavigationTitleColor;
            cc.navigationBackArrowColor =NavigationBackArrowColor;
            cc.navigationBarColor = NavigationBarColor;
            vc = cc;

        };
            break;
        case 29:{
            ContactsViewController *cc = [[ContactsViewController alloc]init];
            cc.appName = AppName;
            cc.navigationTitleColor =NavigationTitleColor;
            cc.navigationBackArrowColor =NavigationBackArrowColor;
            cc.navigationBarColor = NavigationBarColor;
            vc = cc;

        };
            break;
        case 30:{
            ExcelViewController *excel = [[ExcelViewController alloc]init];
            excel.mark = mark;
            vc=excel;
        };
            break;
        case 31:{
            ExcelViewController *excel = [[ExcelViewController alloc]init];
            excel.mark = mark;
            vc=excel;
        };
            break;
        case 32:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
        case 33:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 34:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
        case 35:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;
        case 36:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
        case 37:{
            YWSJViewController *ywsj = [[YWSJViewController alloc]init];
            ywsj.mark = mark;
            vc=ywsj;
        };
            break;

        default:
            break;
            
    }
    vc.title = FunctionName;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
