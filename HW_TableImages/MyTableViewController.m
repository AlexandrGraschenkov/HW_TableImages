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
    
    NSMutableArray *cells;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArr = [NSArray array];
    
    cells = [NSMutableArray new];
    
    [[DataManager sharedInstance] asyncListOfFruits:^(NSArray *arr) {
        dataArr = [NSArray arrayWithArray:arr];
        
        NSMutableArray *newCellsPaths = [NSMutableArray array];
        for (NSInteger i = 0; i < dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [newCellsPaths addObject:indexPath];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView insertRowsAtIndexPaths:newCellsPaths withRowAnimation:UITableViewRowAnimationMiddle];
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
    
    [cell.titleLabel setText:[[dataArr objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    [cell.activity startAnimating];
    [cell.imgView setImage:nil];
    
    [[DataManager sharedInstance] asyncGetImage:[[dataArr objectAtIndex:indexPath.row] objectForKey:@"thumb_img"] complection:^(UIImage *img) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *newPath = [tableView indexPathForCell:cell];
            if ([newPath isEqual:indexPath]) {
                [cell.activity stopAnimating];
                [cell.imgView setImage:img];
            }
        });
    }];
    
    return cell;
}


@end
