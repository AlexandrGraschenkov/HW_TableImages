//
//  MyTableViewController.m
//  HW_TableImages
//
//  Created by Alexander on 19.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MyTableViewController.h"
#import "DataManager.h"
#import "TableViewCell.h"

@interface MyTableViewController ()
{
    NSArray *dataArr;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end
