//
//  ContactsViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CoreDataManager = [[ContactsManager alloc]init];
    
    //更新时间
    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
    
    if (!updateDate) {
        //如果无此对象，表示第一次，那么就读数据写到数据库中
        [self writeDate];
        
    }else{
        //有此对象说明只要从数据库中读数据
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        //8小时一更新
        if ((now - update)>8*60*60) {
            //如果超出八小时就把数据库清空再重新写
            [CoreDataManager deleteData];
            [self writeDate];
        }else{
            //没有超过8小时就从数据库中读
            NSMutableArray *array = [CoreDataManager selectData:10 andOffset:0];
            self.List = [NSMutableArray arrayWithArray:array];
            //[newsTableView reloadData];
        }
    }

}

-(void)writeDate
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/Contacts/GetPersonContactList.aspx?AppName=%@",AppName];
    NSError *error;
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setTimeoutInterval:60.0f];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSArray *array = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    self.List = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        Person *info = [[Person alloc]initWithDictionary:dict];
        [self.List addObject:info];
    }
    //把数据写到数据库
    [CoreDataManager insertCoreData:self.List];
    //[newsTableView reloadData];
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

@end
