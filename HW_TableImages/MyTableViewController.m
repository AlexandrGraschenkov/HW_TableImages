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
    DataManager *data;
    NSArray *dataArr;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [DataManager sharedInstance];
    [data asyncListOfFruits:^(NSArray *arr) {
        dataArr = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
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
   static NSString *cellIdentifier = @"TableViewCell";
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.activity startAnimating];
    cell.titleLabel.text = [[dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imgView.image = nil;
    
    [data asyncGetImage:[[dataArr objectAtIndex:indexPath.row]objectForKey:@"thumb_img"] complection:^void (UIImage *img)
    {
        TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imgView.image = img;
                [cell.activity setHidesWhenStopped:YES];
                [cell.activity stopAnimating];
            });
        }
        	
    }];
    return cell;
    
}



@end
