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

@interface MyTableViewController (){
    NSMutableArray *cells;
    NSArray *dataArr;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    dataArr = [NSArray array];
    
        cells = [NSMutableArray new];
    
        [[DataManager sharedInstance] asyncListOfFruits:^(NSArray *arr) {
                dataArr = [NSArray arrayWithArray:arr];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                dataArr = [NSArray arrayWithArray:arr];
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
    cell.titleLabel.text=[dataArr[indexPath.row] objectForKey:@"title"];
    cell.activity.hidden=NO;
    [cell.activity startAnimating];
    cell.imgView.image=nil;
    [[DataManager sharedInstance] asyncGetImage:[dataArr[indexPath.row] objectForKey:@"thumb_img"] complection:^(UIImage *img){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *index=indexPath;
            TableViewCell* oldCell=[self.tableView cellForRowAtIndexPath:index];
            oldCell.imgView.image=img;
            [oldCell.activity stopAnimating];
            oldCell.activity.hidden=YES;
        });
    }];
    // Configure the cell...
    
    return cell;
}



@end
