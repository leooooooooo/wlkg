//
//  HYYWViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ExcelViewController.h"
#import "Header.h"
#import "UUColor.h"
//#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import <Leo/Leo.h>
@import Leo.HUD;

@interface ExcelViewController ()
@property (nonatomic,strong) NSURL *FileURL;
@property (nonatomic,retain) UIDocumentInteractionController *documentController;
@end

@implementation ExcelViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [Header NavigationConifigInitialize:self];
    
    beginDateLabel.text = [self dateToStringDate:[NSDate date]];
    endDateLabel.text = [self dateToStringDate:[NSDate date]];
    
    
    //查询按钮
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showWithStatus)];
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openInOtherApp)];
    NSArray *bt = [[NSArray alloc]initWithObjects:select,share, nil];
    [self.navigationItem setRightBarButtonItems:bt];
    
    
    //分割线
    UILabel *fenge = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, WIDTH*2, 2)];
    fenge.backgroundColor = [UIColor redColor];
    fenge.text = @"";
    [self.view addSubview:fenge];
    //backview
    [backview setFrame:CGRectMake(0, 60, WIDTH, 50)];
    //
    [webView setFrame:CGRectMake(0, 48, WIDTH-20, HEIGHT-48)];
    webView.scalesPageToFit = YES;

}


-(NSURL *)getArray
{
    
    NSString *URL = [[NSString alloc]init];
    
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    switch (self.mark) {
        case 30://货运业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/ReportFile/GetBS_BusinessCondictionReport.aspx?CodeUser=%@&startTime=%@&endTime=%@",delegate.Code_User,beginDateLabel.text,endDateLabel.text];
            break;
        case 31://船务业务
            URL = [NSString stringWithFormat:@"http://218.92.115.55/wlkg/Service/ReportFile/GetBS_CustomerOperationReport.aspx?CodeUser=%@&startTime=%@&endTime=%@",delegate.Code_User,beginDateLabel.text,endDateLabel.text];
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
    
    NSString *urlstring = [Json objectForKey:@"ReportUrl"];
    NSString *name = [Json objectForKey:@"ReportName"];
    
    if ([[Json objectForKey:@"IsGet"]isEqualToString:@"No"]) {
        return [NSURL URLWithString:@""];
    }
    
    NSURL *xlsURL = [[NSURL alloc]initWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *locURL = [self downloadFile:name withURL:xlsURL];
    self.FileURL = locURL;

    return locURL;
    
}

-(NSURL *)downloadFile:(NSString *)FileName withURL:(NSURL *)URL
{
    //下载文件
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *FilePath = [doc stringByAppendingPathComponent:FileName];
    
    NSLog(FilePath,nil);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Copy the database sql file from the resourcepath to the documentpath
    if (![fileManager fileExistsAtPath:FilePath])
    {
        NSData *data = [NSData dataWithContentsOfURL:URL];
        [data writeToFile:FilePath atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
    }
    return [NSURL fileURLWithPath:FilePath];
}

-(void)openInOtherApp
{
    if (!self.FileURL) {
        return;
    }
    // Initialize Document Interaction Controller
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:self.FileURL];
    
    // Configure Document Interaction Controller
    [self.documentController setDelegate:self];
    
    // Present Open In Menu
    [self.documentController presentOpenInMenuFromRect:CGRectMake(760, 20, 100, 100) inView:self.view animated:YES];
}

#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
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
    
    NSURL *webURL = [self getArray];
    NSURLRequest *RQ =[[NSURLRequest alloc]initWithURL:webURL];
    [webView loadRequest:RQ];
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
