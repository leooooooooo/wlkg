//
//  BNJZXDLLQSFXViewController.m
//  wlkg
//
//  Created by zhangchao on 15/6/16.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "BNJZXDLLQSFXViewController.h"
#import "Header.h"


@interface BNJZXDLLQSFXViewController ()

@property (nonatomic,retain) NSArray *ChartDate;
@property (nonatomic,retain) NSArray *ChartFund;
@property (nonatomic,retain) NSArray *ChartDOD;

@end

@implementation BNJZXDLLQSFXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self loadChartAndTabel];
}

-(void)loadChartAndTabel
{
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/ServiceWLKG.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:20.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"ServiceNum=%@",@"5"];
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
            self.ChartDate = [Info objectForKey:@"Date"];
            self.ChartFund = [Info objectForKey:@"Amount"];
            self.ChartDOD = [Info objectForKey:@"AmountPercent"];
            
            //Chart
            UUChart *chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 70, WIDTH-20, HEIGHT/5)
                                                               withSource:self
                                                                withStyle:UUChartLineStyle];
            [chartView showInView:self.view];
            CGPoint i = chartView.frame.origin;
            CGSize j = chartView.frame.size;
            
            //Tabel
            UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(i.x-10, (i.y+j.height)+10,WIDTH, (HEIGHT-i.y-j.height)-10) style:UITableViewStylePlain];
            tableview.dataSource=self;
            tableview.delegate=self;
            tableview.sectionHeaderHeight = 44;
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
        CGRect DateRect = CGRectMake(20,11,50,22);
        CGPoint i = DateRect.origin;
        CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentCenter;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(WIDTH/2-25, i.y, 50, 22);
        UILabel *FundLabel = [[UILabel alloc]initWithFrame:FundRect];
        i = FundRect.origin;
        j = FundRect.size;
        FundLabel.font = [UIFont systemFontOfSize:16];
        FundLabel.tag = 2;
        FundLabel.textAlignment= NSTextAlignmentCenter;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:FundLabel];
        
        //DOD
        CGRect DODRect = CGRectMake(WIDTH-95, i.y, 85, 22);
        UILabel *DODLabel = [[UILabel alloc]initWithFrame:DODRect];
        DODLabel.font = [UIFont systemFontOfSize:16];
        DODLabel.tag = 3;
        DODLabel.textAlignment= NSTextAlignmentCenter;
        DODLabel.textColor = [UIColor whiteColor];
        //为图片添加边框
        CALayer *layer = [DODLabel layer];
        layer.cornerRadius = 4;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 0;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:DODLabel];
    }
    
    //Date
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [[[self.ChartDate reverseObjectEnumerator] allObjects] objectAtIndex:indexPath.row];
    //Fund
    ((UILabel *)[cell.contentView viewWithTag:2]).text = [[[self.ChartFund reverseObjectEnumerator] allObjects]objectAtIndex:indexPath.row];
    //DOD
    NSString *DOD =[[[self.ChartDOD reverseObjectEnumerator] allObjects]objectAtIndex:indexPath.row];
    ((UILabel *)[cell.contentView viewWithTag:3]).backgroundColor = [DOD rangeOfString:@"+"].location!=NSNotFound?UURed:UUGreen;
    ((UILabel *)[cell.contentView viewWithTag:3]).text = DOD;
    
    cell.userInteractionEnabled = NO;
    return cell;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.95];
    //Date
    UILabel *Date = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 50, 20)];
    CGPoint i = Date.frame.origin;
    CGSize  j = Date.frame.size;
    Date.textColor=[UIColor whiteColor];
    Date.backgroundColor = [UIColor clearColor];
    Date.text=@"月份";
    Date.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Date];
    //Fund
    UILabel *Fund = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-60, i.y, 120, 20)];
    i = Fund.frame.origin;
    j = Fund.frame.size;
    Fund.textColor=[UIColor whiteColor];
    Fund.backgroundColor = [UIColor clearColor];
    Fund.text=@"代理量(TUE)";
    Fund.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:Fund];
    //DOD
    UILabel *DOD = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-95, i.y, 85, 20)];
    DOD.textColor=[UIColor whiteColor];
    DOD.backgroundColor = [UIColor clearColor];
    DOD.text=@"同比去年";
    DOD.textAlignment= NSTextAlignmentCenter;
    [myView addSubview:DOD];
    
    return myView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return self.ChartDate;
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    return @[self.ChartFund];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    
    NSInteger max = [[self.ChartFund valueForKeyPath:@"@max.intValue"] integerValue];
    NSInteger min =[[self.ChartFund valueForKeyPath:@"@min.intValue"] integerValue];
    return CGRangeMake(max*1.2, min*0.8);
}

#pragma mark 折线图专享功能
/*
 //标记数值区域
 - (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
 {
 return CGRangeMake(25, 75);
 }
 */

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}

@end
