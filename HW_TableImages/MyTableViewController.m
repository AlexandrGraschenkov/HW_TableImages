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
    DataManager *manager;
    NSArray *dataArr;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [DataManager sharedInstance];
    [manager asyncListOfFruits:^void (NSArray *result){
        dataArr = result;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self tableView] reloadData];
        });}];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    // Return the number of rows in the section.
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = [[dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    [manager asyncGetImage:[[dataArr objectAtIndex:indexPath.row] objectForKey:@"thumb_img"] complection:
     ^void (UIImage *img)
     
    {
        TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           cell.imgView.image = img;
                           [cell.activity setHidden:YES];
                       }
                       );
        
    }];
    
    // Configure the cell...
    
    return cell;
}



@end
