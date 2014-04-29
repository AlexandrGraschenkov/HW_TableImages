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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (dataArr)
    {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self reloadData];
    });
}

- (void)reloadData
{
    [[DataManager sharedInstance] asyncListOfFruits:^(NSArray *arr){
        dataArr = arr;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = dataArr[indexPath.row][@"title"];
    [cell.activity startAnimating];
    cell.imgView.image = nil;
    [[DataManager sharedInstance] asyncGetImage:dataArr[indexPath.row][@"thumb_img"] complection:^(UIImage *img) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            if (cell)
            {
                cell.imgView.image = img;
                cell.activity.hidesWhenStopped = YES;
                [cell.activity stopAnimating];
            }
        });
    }];
    return cell;
}


@end
