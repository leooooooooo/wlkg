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


@interface FunctionListTableViewController ()

@end

@implementation FunctionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]autorelease];
    [self.navigationItem setBackBarButtonItem:backButton];
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    self.view.backgroundColor =[UIColor whiteColor];

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

    NSDictionary *dic  = [self.List objectAtIndex:indexPath.row];
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

    NSDictionary *dic  = [self.List objectAtIndex:indexPath.row];
    int mark = [[dic objectForKey:@"mark"] intValue];
    switch (mark) {
        case 1:
            [self JRZJCL];
            break;
            
        default:
            break;
    }

}

- (void)JRZJCL
{
    JRZJCLViewController *vc = [[JRZJCLViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
