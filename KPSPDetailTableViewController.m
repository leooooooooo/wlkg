//
//  KPSPDetailTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "KPSPDetailTableViewController.h"
#import "FileItemTableCell.h"


@interface Item : NSObject

@property (retain, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation Item

@end


@interface KPSPDetailTableViewController ()

@end

@implementation KPSPDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    self.tableView.allowsSelectionDuringEditing = YES;
    [self setEditing:YES animated:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sendData)];
    
    self.items = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<50; i++) {
        Item *item = [[Item alloc] init];
        item.title = [NSString stringWithFormat:@"%d",i];
        item.isChecked = NO;
        [_items addObject:item];
    }
    
    // Do any additional setup after loading the view.
}

-(void)sendData
{
    for (int i = 0; i<5; i++) {
        Item* item = [_items objectAtIndex:i];
        if (item.isChecked) {
            NSLog(@"%d",i);
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    
    [super setEditing:!self.editing animated:YES];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    FileItemTableCell *cell = (FileItemTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FileItemTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:17];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    
    Item* item = [_items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    [cell setChecked:item.isChecked];
    
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item* item = [_items objectAtIndex:indexPath.row];
    
    if (self.editing)
    {
        FileItemTableCell *cell = (FileItemTableCell*)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        [cell setChecked:item.isChecked];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end