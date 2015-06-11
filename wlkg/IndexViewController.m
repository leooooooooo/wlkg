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
#import "LoginViewController.h"
#import "baoshuiViewController.h"

static NSString *kcellIdentifier = @"collectionCellID";
@interface IndexViewController()
{
    NSArray *ZHFX;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *image;
@end


@implementation IndexViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.NavigationDelegate setneedSwipeShowMenu:true];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.NavigationDelegate setneedSwipeShowMenu:false];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //返回按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    //导航栏按钮文字颜色+返回按钮颜色
    [self.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    //导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    
    //导航栏标题颜色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dict;
    //导航栏标题
    self.navigationItem.title =@"首页";//[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName];
    //导航栏左按钮
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[self reSizeImage:[UIImage imageNamed:@"登录_07"] toSize:CGSizeMake(20, 24)] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    //背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"登录"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];

    

    //今日信息
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT/3)];
    webview.delegate=self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    CGPoint i = webview.frame.origin;
    CGSize j = webview.frame.size;
    
    [self.view addSubview:webview];
    
    //退出登陆button
    UIBarButtonItem *logoutButton =[[UIBarButtonItem alloc]initWithTitle:@"登出" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
    [self.navigationItem setRightBarButtonItem:logoutButton];
    
    //菜单BUTTON
    UIBarButtonItem *Menu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"the_arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    [self.navigationItem setLeftBarButtonItem:Menu];
    
    //九宫格
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(i.x, i.y+j.height, WIDTH, HEIGHT*2/3-60) collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
    collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:collectionView];
    
    //二级菜单
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"今日资金存量",@"name",@"icon_0",@"image",@"1",@"mark",nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"收入成本",@"name",@"icon_0",@"image",@"2",@"mark",nil];
    
    ZHFX = [[NSArray alloc]initWithObjects:dic1,dic2, nil];
}

-(void)showMenu
{
    [self.NavigationDelegate showLeftViewController:true];
}

-(void)Logout
{
    
    [super dismissModalViewControllerAnimated:YES];
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    [status setObject:@"0" forKey:(id)kSecValueData];
     /*
    LoginViewController *asd = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    asd.title = @"票货查询";
    [super.navigationController pushViewController:asd animated:YES];
     */
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
    return 6;
    
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
    bt.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    [bt addTarget:self action:@selector(cellbutton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:bt];
    //title
    UILabel *tt = [[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH/375*80, WIDTH/375*80, 20)];
    tt.textAlignment = UITextAlignmentCenter;
    tt.font = [UIFont systemFontOfSize:14];
    //[cell.contentView addSubview:tt];
    
    //赋值
    
    NSString *imageName = [NSString stringWithFormat:@"icon_%ld",(long)indexPath.row];
    
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
    NSLog(sender.titleLabel.text,nil);
    [self OpenFunctionList];
}

-(void)OpenFunctionList
{
    //[self.LeftDelegate setneedSwipeShowMenu:false];
    FunctionListTableViewController *view = [[FunctionListTableViewController alloc]initWithStyle:UITableViewStylePlain];
    view.title = @"综合分析";
    view.List=ZHFX;
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
    return UIEdgeInsetsMake(45, 35, 5, 35);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}
//每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}




@end
