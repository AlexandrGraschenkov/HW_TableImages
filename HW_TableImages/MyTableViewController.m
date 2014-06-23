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
    [[DataManager sharedInstance] asyncListOfFruits:^(NSArray *array) {
        dataArr = array;
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataArr.count;
}

///*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.titleLabel.text = [dataArr objectAtIndex:indexPath.row][@"title"];
    [cell.activity startAnimating];
    cell.imgView.image = nil;
    [[DataManager sharedInstance] asyncGetImage:[dataArr objectAtIndex:indexPath.row][@"thumb_img"] complection:^(UIImage *img) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.imgView.image = img;
            [cell.activity setHidesWhenStopped:true];
            [cell.activity stopAnimating];
        });
    }];
    return cell;
}
//*/


@end
