//
//  RootViewController.m
//  iPort
//
//  Created by zhangchao on 15/4/10.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "IndexViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "FunctionListTableViewController.h"
#import <Leo/Leo.h>
#import <Leo/HUD.h>
//@import Leo.HUD;



static NSString *kcellIdentifier = @"collectionCellID";
@interface IndexViewController()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)AppDelegate *delegate;
@property int functionMarkCount;
@end


@implementation IndexViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.delegate = [[UIApplication sharedApplication]delegate];
    self.functionMarkCount = 0 ;
    
    //背景+标题
    //self.view.backgroundColor  =

    //九宫格
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-48) collectionViewLayout:layout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.collectionView.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.collectionView];
    
    [HUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeClear];
    [self performSelector:@selector(select) withObject:nil afterDelay:0.1f];
    

    }

- (void)select{
    
    self.delegate.Authority = [self getAuthority];
    if ([[[self.delegate.Authority objectForKey:@"IsGet"]objectAtIndex:0]isEqualToString:@"No"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[[self.delegate.Authority objectForKey:@"Message"]objectAtIndex:0] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        self.List = [[NSMutableArray alloc]initWithArray:[self.delegate.Authority objectForKey:@"Order"]];
        [self.collectionView reloadData];
    }
    [HUD dismiss];
}

-(NSDictionary *)getAuthority
{
    
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/UserPermission/GetUserPermissions.aspx?CodeUser=%@&AppName=%@",self.delegate.Code_User,AppName];
    NSError *error;
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setTimeoutInterval:60.0f];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
}


#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.List.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    
    //button
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH/375*80, WIDTH/375*80)];
    bt.tag =2;
    bt.titleLabel.textColor = [UIColor redColor];
    bt.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [bt addTarget:self action:@selector(cellbutton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:bt];
    //title
    UILabel *tt = [[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH/375*80, WIDTH/375*80, 20)];
    tt.textAlignment = NSTextAlignmentCenter;
    tt.font = [UIFont systemFontOfSize:14];
    //[cell.contentView addSubview:tt];
    
    //赋值
    
    NSString *imageName = [NSString stringWithFormat:@"%@1",[self.List objectAtIndex:indexPath.row]];
    
    [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    tt.text =imageName;
    
    //为图片添加边框
    CALayer *layer = [bt.imageView layer];
    layer.cornerRadius = 8;
    layer.borderColor = [[UIColor whiteColor]CGColor];
    layer.borderWidth = 1;
    layer.masksToBounds = YES;

    return cell;
    
}

-(void)cellbutton:(UIButton*)sender
{

    NSString *FunctionName =[self.List objectAtIndex:[sender.titleLabel.text intValue]];
    NSLog(FunctionName,nil);
    
    [self OpenFunctionList:FunctionName];
}

-(void)OpenFunctionList:(NSString *)FunctionName
{
    
    
    FunctionListTableViewController *view = [[FunctionListTableViewController alloc]initWithStyle:UITableViewStylePlain];
    view.title = FunctionName;
    view.List = [self.delegate.Authority objectForKey:FunctionName];
    
    [self.navigationController pushViewController:view animated:YES];
}



//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH/375*80, WIDTH/375*80);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake((HEIGHT-(WIDTH/375*320+HEIGHT/10+122))*2/5, 35, HEIGHT/30, 35);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return HEIGHT/30;
}
//每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}




@end
