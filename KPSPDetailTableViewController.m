//
//  KPSPDetailTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "KPSPDetailTableViewController.h"
#import "FileItemTableCell.h"
#import "Header.h"
#import "AppDelegate.h"


@interface Item : NSObject
@property (assign, nonatomic) BOOL isChecked;
@end

@implementation Item
@end


@interface KPSPDetailTableViewController ()
@property (assign, nonatomic) BOOL isAuditing;
@property (assign, nonatomic) BOOL isRejecting;
@end

@implementation KPSPDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 120;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.isAuditing = NO;
    self.isRejecting = NO;
    
    
    [self setDoubleButton];


    [self getArray];
    /*
    NSArray *qwe =[[NSArray alloc]initWithObjects:@"1",@"2", nil];
    NSArray *asd =[[NSArray alloc]initWithObjects:@"3",@"4", nil];
    
    self.List = [[NSArray alloc]initWithObjects:qwe, nil];
    */
    

    // Do any additional setup after loading the view.
}


//重置按钮
-(void)setDoubleButton
{
    UIBarButtonItem *sp = [[UIBarButtonItem alloc] initWithTitle:@"审批" style:UIBarButtonItemStyleDone target:self action:@selector(Audit)];
    UIBarButtonItem *th = [[UIBarButtonItem alloc] initWithTitle:@"退回" style:UIBarButtonItemStyleDone target:self action:@selector(Reject)];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:sp,th, nil];
}
//修改按钮
-(void)setLoadButton
{
    UIBarButtonItem *load = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sendData)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:load,cancel, nil];
}
//取消
-(void)cancel
{
    self.isAuditing = NO;
    self.isRejecting = NO;
    [self clearSelection];
    [self setEditing:YES animated:YES];
    [self setDoubleButton];
    self.title = nil;
}
//清除对号
-(void)clearSelection
{
    for (int i = 0; i<self.List.count; i++) {
        Item* item = [_items objectAtIndex:i];
        item.isChecked = NO;
    }
}
//审批
-(void)Audit
{
    [self setLoadButton];
    self.isAuditing = YES;
    self.title = @"审批";
    [self clearSelection];
    [self setEditing:YES animated:YES];
}
//退回
-(void)Reject
{
    [self setLoadButton];
    self.isRejecting = YES;
    self.title = @"退回";
    [self clearSelection];
    [self setEditing:YES animated:YES];
}


//刷新数据
-(void)getArray
{
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Approval/BillingApproval/GetBillingList.aspx?DelegationId=%@",self.ID];
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    self.List =  [Json objectForKey:@"BillingList"];
    
    if (self.List.count==0) {
        NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Approval/BillingApproval/DelegationApproval.aspx?ID=%@",self.ID];
        
        NSError *error;
        //加载一个NSURL对象
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
        //将请求的url数据放到NSData对象中
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        if ([[Json objectForKey:@"Approval"]isEqualToString:@"Yes"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"该委托所有操作已结束，请返回上级菜单" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Json objectForKey:@"Message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
     
    self.items = [NSMutableArray arrayWithCapacity:0];

    for (int i=0; i<self.List.count; i++) {
        Item *item = [[Item alloc] init];
        item.isChecked = NO;
        [_items addObject:item];
    }
    
    [self.tableView reloadData];
}

//提交
-(void)sendData
{
    self.title = nil;
    [self setDoubleButton];
    NSMutableString *TFNO = [[NSMutableString alloc]init];

    for (int i = 0; i<self.List.count; i++) {
        Item* item = [_items objectAtIndex:i];
        if (item.isChecked) {
            if (TFNO.length==0) {
                [TFNO appendString:[[self.List objectAtIndex:i] objectAtIndex:11]];
            }
            else
            {
                [TFNO appendString:[NSString stringWithFormat:@"+%@",[[self.List objectAtIndex:i] objectAtIndex:11]]];
            }
            NSLog(@"%@",TFNO);
        }
    }
    
    NSString *URL = [[NSString alloc]init];
    if(self.isAuditing)
    {
        URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Approval/BillingApproval/BillingApproval.aspx?IsAuditName=%@&TFNO=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],TFNO];
    }
    if (self.isRejecting)
    {
        URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/Approval/BillingApproval/BillingApprovalReturn.aspx?IsAuditName=%@&TFNO=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Code_User],TFNO];
    }
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    if ([[Json objectForKey:@"Approval"]isEqualToString:@"Yes"]) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提交成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:[Json objectForKey:@"Message"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self getArray];

    [self setEditing:YES animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//修改选中状态
- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    [super setEditing:!self.editing animated:YES];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.List.count;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    FileItemTableCell *cell = (FileItemTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FileItemTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        NSString *label1 = [NSString stringWithFormat:@"记账日期：%@\n客户全称：%@\n货物：%@\n费目：%@\n概述：%@\n",[[self.List objectAtIndex:indexPath.row]objectAtIndex:0],[[self.List objectAtIndex:indexPath.row]objectAtIndex:1],[[self.List objectAtIndex:indexPath.row]objectAtIndex:2],[[self.List objectAtIndex:indexPath.row]objectAtIndex:3],[[self.List objectAtIndex:indexPath.row]objectAtIndex:4]];
        NSString *label2 = [NSString stringWithFormat:@"数量：%@\n单价：%@\n金额：%@\n开票标志：%@\n开票人：%@\n账单编号：%@",[[self.List objectAtIndex:indexPath.row]objectAtIndex:5],[[self.List objectAtIndex:indexPath.row]objectAtIndex:6],[[self.List objectAtIndex:indexPath.row]objectAtIndex:7],[[[self.List objectAtIndex:indexPath.row]objectAtIndex:8] isEqual:@"0"]?@"否":@"正在开票中，无法操作",[[self.List objectAtIndex:indexPath.row]objectAtIndex:9],[[self.List objectAtIndex:indexPath.row]objectAtIndex:10]];
        
        //Date
        CGRect DateRect = CGRectMake(20,15,WIDTH/2,90);
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.numberOfLines = 6;
        DateLabel.font = [UIFont systemFontOfSize:12];
        DateLabel.text = label1;
        [cell.contentView addSubview:DateLabel];
        
        //Date
        DateRect = CGRectMake(WIDTH/2,15,WIDTH/2,90);
        UILabel *DateLabel1 = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel1.numberOfLines = 6;
        DateLabel1.font = [UIFont systemFontOfSize:12];
        DateLabel1.text = label2;
        [cell.contentView addSubview:DateLabel1];

    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    //cell.textLabel.textColor = [UIColor blackColor];
    
    Item* item = [_items objectAtIndex:indexPath.row];
    
    if (![[[self.List objectAtIndex:indexPath.row]objectAtIndex:8] isEqual:@"0"]) {
        cell.userInteractionEnabled = NO;
    }
    
    [cell setChecked:item.isChecked];
    
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item* item = [_items objectAtIndex:indexPath.row];
    
    if (self.editing)
    {
        FileItemTableCell *cell = (FileItemTableCell*)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        [cell setChecked:item.isChecked];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end