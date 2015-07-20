//
//  HYYWTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Header.h"

@interface DetailTableViewController ()
@property (nonatomic,retain) NSDictionary *ChartDate;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self loadChartAndTabel];
}

-(void)loadChartAndTabel
{
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
        default:
            break;
    }
    //1确定地址NSURL

    NSURL *url = [NSURL URLWithString:urlString];
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:60.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"startTime=%@&endTime=%@&ID=%@",self.beginDate,self.endDate,self.objID];
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
            self.ChartDate = Info;
            [self.tableView reloadData];
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
    return self.ChartDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil)
    {
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(20,11,120,22);
        CGPoint i = DateRect.origin;
        CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentLeft;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(WIDTH-220, i.y, 200, 22);
        UILabel *FundLabel = [[UILabel alloc]initWithFrame:FundRect];
        i = FundRect.origin;
        j = FundRect.size;
        FundLabel.font = [UIFont systemFontOfSize:16];
        FundLabel.tag = 2;
        FundLabel.textAlignment= NSTextAlignmentRight;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:FundLabel];
        
    }
    
    
    NSArray *name = [[NSArray alloc]initWithArray:[self.ChartDate allKeys]];
    NSArray *value =[[NSArray alloc]initWithArray:[self.ChartDate allValues]];
    //Date
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [name objectAtIndex:indexPath.row];
    //Fund
    
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[value objectAtIndex:indexPath.row]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,str.length)];
    ((UILabel *)[cell.contentView viewWithTag:2]).attributedText = str;
    
    
    cell.userInteractionEnabled = NO;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
