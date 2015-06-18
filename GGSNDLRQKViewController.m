
//
//  GGSNDLRQKViewController.m
//  wlkg
//
//  Created by zhangchao on 15/6/17.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "GGSNDLRQKViewController.h"
#import "Header.h"

@interface GGSNDLRQKViewController ()
@property (nonatomic,retain) NSArray *ChartMonth;
@property (nonatomic,retain) NSArray *ChartLastProfi;

@end

@implementation GGSNDLRQKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    /*
     NSArray *Date = [[NSArray alloc] initWithObjects:@"06-01",@"06-02",@"06-03",@"06-04",@"06-05",nil];
     NSArray *Fund =[[NSArray alloc] initWithObjects:@"22",@"44",@"15",@"12",@"45",nil];
     NSArray *DOD = [[NSArray alloc] initWithObjects:@"+3.87%",@"+3.87%",@"+3.87%",@"-3.87%",@"-3.87%",@"+3.87%",@"+3.87%",@"+3.87%",@"-3.87%",nil];
     NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:Date,@"Date",Fund,@"Fund",DOD,@"DOD", nil];
     
     self.ChartDate = [data objectForKey:@"Date"];
     self.ChartFund = [data objectForKey:@"Fund"];
     self.ChartDOD = [data objectForKey:@"FundInterval"];
     */
    
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
    NSString *bodyStr = [NSString stringWithFormat:@"ServiceNum=%@",@"13"];
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
            self.ChartMonth = [Info objectForKey:@"Company"];
            self.ChartLastProfi = [Info objectForKey:@"AnnualProfit"];
            
            //Chart
            UUChart *chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 70, WIDTH-20, HEIGHT/5)
                                                               withSource:self
                                                                withStyle:UUChartBarStyle];
            [chartView showInView:self.view];
            CGPoint i = chartView.frame.origin;
            CGSize j = chartView.frame.size;
            
            //Tabel
            UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, i.y+j.height,WIDTH, HEIGHT) style:UITableViewStylePlain];
            tableview.dataSource=self;
            tableview.delegate=self;
            //tableview.sectionHeaderHeight = 44;
            tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            tableview.tableFooterView = [[UIView alloc] init];
            //tableview.backgroundColor = [UIColor whiteColor];
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
    return self.ChartMonth.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil)
    {
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(20,11,200,22);
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
    //Date
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [self.ChartMonth objectAtIndex:indexPath.row];
    //Fund
    
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 万元",[self.ChartLastProfi objectAtIndex:indexPath.row]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,str.length-2)];
    ((UILabel *)[cell.contentView viewWithTag:2]).attributedText = str;
    
    
    cell.userInteractionEnabled = NO;
    return cell;
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return self.ChartMonth;
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    return @[self.ChartLastProfi];
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
    
    NSInteger max = [[self.ChartLastProfi valueForKeyPath:@"@max.intValue"] integerValue];
    NSInteger min =[[self.ChartLastProfi valueForKeyPath:@"@min.intValue"] integerValue];
    
    return max<0?CGRangeMake(max*0.8, min*1.2):CGRangeMake(max*1.2, min*0.8);
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
    return index==1?YES:NO;
}

@end
