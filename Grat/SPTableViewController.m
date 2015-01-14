//
//  SPTableViewController.m
//  Grat-Demo
//
//  Created by Chad Ackerman on 1/8/15.
//  Copyright (c) 2015 Grat. All rights reserved.
//

#import "SPTableViewController.h"
#import "AppDelegate.h"
#import "ConfirmTipViewController.h"

@interface SPTableViewController ()

@end

@implementation SPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationItem.title = [NSString stringWithFormat:@"Tip: %@", self.selectedTipAmount];
    
    self.SPs = [[NSMutableArray alloc] init];
    [self findNearbySP];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(findNearbySP)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)findNearbySP {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if ([self.refreshControl isRefreshing]) {
        NSLog(@"refreshing");
        [self.SPs removeAllObjects];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.proximityKitManager startRangingIBeacons];
    
    [center addObserverForName:@"FoundBeacon"
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *notification)
     {
//         NSLog(@"Beacon Notificaton: %@",notification.userInfo);
         
         [self reloadData:notification];
         NSLog(@"Notifications Count: %lu",(unsigned long)self.SPs.count);
     }];
}

- (void)reloadData: (NSNotification *)notification
{
    if (notification) {
        [self.SPs addObject:notification.userInfo];
    }
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.SPs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"sp";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSString *firstName = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"firstName"];
    NSString *lastInitial = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"lastName"];
    NSString *position = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"position"];
    NSString *company = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"company"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",firstName, lastInitial];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",position, company];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"name" sender:self];
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
    
    if([segue.identifier isEqualToString:@"name"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        
        ConfirmTipViewController *dest = [segue destinationViewController];
        dest.confirmStatement = [NSString stringWithFormat:@"Do you want to tip %@, to %@?", self.selectedTipAmount,cell.textLabel.text];
    }
}


@end
