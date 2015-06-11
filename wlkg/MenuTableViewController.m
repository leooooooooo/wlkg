//
//  MenuTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/5/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"

@interface MenuTableViewController ()
{
    NSArray *List;
}

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     UILabel *welcome =[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16, self.view.bounds.size.width/8, self.view.bounds.size.width, 200)];
     welcome.numberOfLines = 4;
     welcome.text=[NSString stringWithFormat:@"你好,%@\n欢迎使用iPort移动版\n当前位置 %@\n今天是2015年4月15日，气温4～18℃，晴天",[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName],[(AppDelegate *)[[UIApplication sharedApplication]delegate]Department]];
     [self.view addSubview:welcome];
    
    UIImageView *head = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height/3)]autorelease];
    head.image = [UIImage imageNamed:@"head1.jpg"];
    self.tableView.tableHeaderView = welcome;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"个人信息",@"name",@"icon_0",@"image",@"1",@"mark",nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"修改密码",@"name",@"icon_0",@"image",@"2",@"mark",nil];
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"设备绑定",@"name",@"icon_0",@"image",@"3",@"mark",nil];
    NSDictionary *dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"检查更新",@"name",@"icon_0",@"image",@"4",@"mark",nil];
    NSDictionary *dic5 = [[NSDictionary alloc]initWithObjectsAndKeys:@"登出",@"name",@"icon_0",@"image",@"5",@"mark",nil];

    List = [[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    self.tableView.tableFooterView = [[UIView alloc]init];
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
    return List.count;
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
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier]autorelease];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[[UIImageView alloc]initWithFrame:imageRect]autorelease];
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
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, self.view.bounds.size.width/1.5, 10);
        UILabel *nameLabel = [[[UILabel alloc]initWithFrame:nameRect]autorelease];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dic  = [List objectAtIndex:indexPath.row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectForKey:@"name"];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic  = [List objectAtIndex:indexPath.row];
    int mark = [[dic objectForKey:@"mark"] intValue];
    switch (mark) {
        case 1:
            [self JRZJCL];
            break;
        case 5:
            [self.LeftDelegate Logout];
        default:
            break;
    }
    
}

- (void)JRZJCL
{
    NSLog(@"123",nil);
}


@end
