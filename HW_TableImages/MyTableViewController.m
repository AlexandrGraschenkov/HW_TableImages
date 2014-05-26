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
    int cellsDisplayed;
    BOOL *haveDataArr;
    NSArray *dataArr;
}
@end

@implementation MyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    haveDataArr = false;
    cellsDisplayed = 0;
    
    [[DataManager sharedInstance] asyncListOfFruits:^(NSArray *bottleForMilkArray){
        dispatch_async(dispatch_get_main_queue(), ^{
            dataArr = bottleForMilkArray;
            haveDataArr = true;
            for (id itemToPreview in dataArr) {
                NSLog(@"%@", [itemToPreview description]);
            }
        [self.tableView reloadData];
        });
    }];
    
    

//    NSArray rows = [[NSArray alloc] init];
//    for (
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView insertRowsAtIndexPaths:??? withRowAnimation:UITableViewRowAnimationBottom];
//    });
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (haveDataArr) {
        return [dataArr count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    /*cellsDisplayed++;
    [cell.titleLabel setText:[NSString stringWithFormat:@"%d", cellsDisplayed]];*/
    [cell.titleLabel setText:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    [cell.activity setHidden:NO];
    [cell.activity startAnimating];
    [cell.imgView setImage:nil];
    [[DataManager sharedInstance] asyncGetImage:[[dataArr objectAtIndex:indexPath.row] valueForKey:@"thumb_img"] complection:^(UIImage *img) {
        dispatch_async(dispatch_get_main_queue(), ^{
            TableViewCell *newCell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (newCell) {
                [cell.imgView setImage:img];
                [cell.activity setHidden:YES];
            }
        });
    }];
    
    
    return cell;
}


@end
