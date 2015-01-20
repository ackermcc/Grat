//
//  TransactionHistoryTableViewController.m
//  Grat
//
//  Created by Chad Ackerman on 1/19/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "TransactionHistoryTableViewController.h"
#import <Firebase/Firebase.h>

@interface TransactionHistoryTableViewController ()

@end

@implementation TransactionHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Create a reference to a Firebase location
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://grat.firebaseio.com"];
    // Write data to Firebase
    Firebase *transactions = [ref childByAppendingPath:@"transactions"];
    
    self.transactionsHistory = [[NSArray alloc] init];
    
    // Attach a block to read the data at our posts reference
    [transactions observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        self.transactionsHistory = [snapshot.value allValues];
        NSLog(@"%@", self.transactionsHistory);
        [self.tableView reloadData];
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.transactionsHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transaction" forIndexPath:indexPath];
    
    NSString *sp = [[self.transactionsHistory objectAtIndex:indexPath.row] objectForKey:@"service-professional"];
    NSString *time = [[self.transactionsHistory objectAtIndex:indexPath.row] objectForKey:@"time-stamp"];
    NSString *tip = [[self.transactionsHistory objectAtIndex:indexPath.row] objectForKey:@"tip-amount"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", sp, tip];
    cell.detailTextLabel.text = time;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnHideHistory:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
