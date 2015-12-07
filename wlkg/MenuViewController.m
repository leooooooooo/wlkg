//
//  MenuTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/5/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "Header.h"


@interface MenuViewController ()
{
    NSArray *List;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect head = CGRectMake(0, 0, WIDTH, HEIGHT/4);
    UIImageView *img = [[UIImageView alloc]initWithFrame:head];
    img.image = [UIImage imageNamed:@"header"];
    [self.view addSubview:img];
    UIImageView *h = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, HEIGHT/8, HEIGHT/8)];
    h.image = [UIImage imageNamed:@"head_icon.png"];
    [self.view addSubview:h];

     UILabel *welcome =[[UILabel alloc]initWithFrame:CGRectMake(30, HEIGHT/8, WIDTH, 100)];
     welcome.numberOfLines = 2;
    welcome.textColor = [UIColor whiteColor];
    welcome.font = [UIFont systemFontOfSize:13];
     welcome.text=[NSString stringWithFormat:@"你好,%@\n欢迎使用物流控股移动应用",[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName]];
    [self.view addSubview:welcome];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHT/4, WIDTH, HEIGHT*3/4)];
    //NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"个人信息",@"name",@"22_05",@"image",@"1",@"mark",nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"修改密码",@"name",@"fc_1",@"image",@"2",@"mark",nil];
    //NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"设备绑定",@"name",@"22_10",@"image",@"3",@"mark",nil];
    NSDictionary *dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"检查更新",@"name",@"fc_3",@"image",@"4",@"mark",nil];
    NSDictionary *dic5 = [[NSDictionary alloc]initWithObjectsAndKeys:@"登出",@"name",@"fc_4",@"image",@"5",@"mark",nil];

    List = [[NSArray alloc]initWithObjects:dic2,dic4,dic5, nil];
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.delegate = self;
    tableView.dataSource=self;
    tableView.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"listbg"]];
    
    [self.view addSubview:tableView];
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
    
    NSDictionary *dic  = [List objectAtIndex:indexPath.row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectForKey:@"name"];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    //办公室
    //((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic  = [List objectAtIndex:indexPath.row];
    int mark = [[dic objectForKey:@"mark"] intValue];
    switch (mark) {
        case 1:
            [self.LeftDelegate ChangeInfo];
            break;
        case 2:
            [self.LeftDelegate ChangePassword];
            
            break;
        case 3:
            //[self JRZJCL];
            break;
        case 4:
            self.UpdateDelegate = [[Update alloc]init];
            [self.UpdateDelegate CheckUpdate:self.view];
            break;
        case 5:
            [self.LeftDelegate Logout];
        default:
            break;
    }
    
}

@end
