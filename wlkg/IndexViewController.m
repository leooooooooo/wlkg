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



static NSString *kcellIdentifier = @"collectionCellID";
@interface IndexViewController()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImage *image;
@end


@implementation IndexViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    //背景图片
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds]autorelease];
    imageView.image = [UIImage imageNamed:@"登录"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];

    

    //今日信息
    UIWebView *webview = [[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT/3)]autorelease];
    webview.delegate=self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://218.92.115.55/wlkg/Page/TodayReport.html"]]];
    CGPoint i = webview.frame.origin;
    CGSize j = webview.frame.size;
    
    [self.view addSubview:webview];
    */
    //背景+标题
    self.view.backgroundColor  = NavigationBackArrowColor;

    //九宫格
    UICollectionViewFlowLayout *layout= [[[UICollectionViewFlowLayout alloc]init]autorelease];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
    collectionView.backgroundColor = [UIColor grayColor];
    collectionView.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"l_n_bg.png"]];
    [self.view addSubview:collectionView];
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
    return 12;
    
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
    UILabel *tt = [[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH/375*80, WIDTH/375*80, 20)]autorelease];
    tt.textAlignment = NSTextAlignmentCenter;
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
    
    [self OpenFunctionList:[sender.titleLabel.text intValue]];
}

-(void)OpenFunctionList:(NSInteger)num
{
    //二级菜单
    NSDictionary *dic1 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日资金存量",@"name",@"icon_4",@"image",@"1",@"mark",nil]autorelease];
    NSDictionary *dic2 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"收入成本月度情况",@"name",@"icon_4",@"image",@"2",@"mark",nil]autorelease];
    NSDictionary *dic3 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"公司流动资产负债情况",@"name",@"icon_4",@"image",@"3",@"mark",nil]autorelease];
    NSDictionary *dic4 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"利润月度情况",@"name",@"icon_4",@"image",@"4",@"mark",nil]autorelease];
    NSDictionary *dic5 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"本年集装箱代理量趋势分析",@"name",@"icon_0",@"image",@"5",@"mark",nil]autorelease];
    NSDictionary *dic6 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"本年散杂货代理量趋势分析",@"name",@"icon_0",@"image",@"6",@"mark",nil]autorelease];
    NSDictionary *dic7 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"本年船舶代理量趋势分析",@"name",@"icon_0",@"image",@"7",@"mark",nil]autorelease];
    NSDictionary *dic8 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日保税进出量",@"name",@"icon_0",@"image",@"8",@"mark",nil]autorelease];
    NSDictionary *dic9 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日贸易情况",@"name",@"icon_0",@"image",@"9",@"mark",nil]autorelease];
    NSDictionary *dic10 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日仓储进出量",@"name",@"icon_0",@"image",@"10",@"mark",nil]autorelease];
    NSDictionary *dic11 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日发运业务情况",@"name",@"icon_0",@"image",@"11",@"mark",nil]autorelease];
    NSDictionary *dic12 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"今日B保公司业务情况",@"name",@"icon_0",@"image",@"12",@"mark",nil]autorelease];
    NSDictionary *dic13 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"各公司年度盈利情况",@"name",@"icon_4",@"image",@"13",@"mark",nil]autorelease];
    NSDictionary *dic14 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"报关查询",@"name",@"icon_3",@"image",@"14",@"mark",nil]autorelease];
    NSDictionary *dic15 = [[[NSDictionary alloc]initWithObjectsAndKeys:@"报检查询",@"name",@"icon_3",@"image",@"15",@"mark",nil]autorelease];
    
    FunctionListTableViewController *view = [[[FunctionListTableViewController alloc]initWithStyle:UITableViewStylePlain]autorelease];
    switch (num) {
        case 0:
            view.title = @"今日快报";
            view.List=[[NSArray alloc]initWithObjects:dic1,dic8,dic9,dic10,dic11,dic12, nil];
            break;
        case 1:
            view.title = @"协同办公";
            //view.List=[[NSArray alloc]initWithObjects:dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12, nil];
            break;
        case 2:
            view.title = @"公司新闻";
            //view.List=[[NSArray alloc]initWithObjects:dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12, nil];
            break;
        case 3:
            view.title = @"业务中心";
            view.List=[[NSArray alloc]initWithObjects:dic14,dic15, nil];
            break;
        case 4:
            view.title = @"审批中心";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        case 5:
            view.title = @"报表中心";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        case 6:
            view.title = @"业务分析";
            view.List=[[NSArray alloc]initWithObjects:dic5,dic6,dic7, nil];
            break;
        case 7:
            view.title = @"财务管理";
            view.List=[[NSArray alloc]initWithObjects:dic2,dic3,dic4,dic13, nil];
            break;
        case 8:
            view.title = @"运营监控";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        case 9:
            view.title = @"设备运行";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        case 10:
            view.title = @"能源消耗";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        case 11:
            view.title = @"员工通信录";
            //view.List=[[NSArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic13, nil];
            break;
        default:
            break;
    }

    
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
