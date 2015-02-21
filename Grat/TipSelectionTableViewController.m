//
//  TipSelectionTableViewController.m
//  Grat-Demo
//
//  Created by Chad Ackerman on 1/8/15.
//  Copyright (c) 2015 Grat. All rights reserved.
//

#import "TipSelectionTableViewController.h"
#import "SPTableViewController.h"
#import "TipTableViewCell.h"

@interface TipSelectionTableViewController ()

@end

@implementation TipSelectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *tip = @[@"$5",@"$3",@"$15",@"$$"];
    NSArray *suggestionString = @[@"Suggested",@"Tight Budget",@"Big Spender",@"Custom"];
    
    self.tipSuggestions = [[NSMutableArray alloc] initWithArray:tip];
    self.tipString = [[NSMutableArray alloc] initWithArray:suggestionString];
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
    if (self.tipSuggestions.count == 0) {
        return 1;
    } else {
        return self.tipSuggestions.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tip";
    TipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[TipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *amount = [self.tipSuggestions objectAtIndex:indexPath.row];
    NSString *suggestion = [self.tipString objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", amount];
    cell.lblTipAmount.textColor = [UIColor colorWithRed:27.0/255.0 green:188.0/255.0 blue:155.0/255.0 alpha:1.0];
    cell.lblTipAmount.text = amount;
    cell.lblTipSugestionString.text = suggestion;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text  isEqual: @"Other"]) {
        [self performSegueWithIdentifier:@"Create Tip" sender:self];
    } else {
        [self performSegueWithIdentifier:@"Tip" sender:self];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    TipTableViewCell *cell = (TipTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
    
    if ([segue.identifier isEqual:@"Tip"]) {
        SPTableViewController *destination = [segue destinationViewController];
        destination.selectedTipAmount = cell.lblTipAmount.text;
        destination.cameFromCreateTip = NO;
    } else if ([segue.identifier isEqual:@"Create Tip"]) {
        
    }
}


@end
