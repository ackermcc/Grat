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
#import "SPTableViewCell.h"

@interface SPTableViewController ()

@end

@implementation SPTableViewController

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        NSLog(@"I backed out");
        if(self.cameFromCreateTip == YES){
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Back Button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style: UIBarButtonItemStylePlain
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.proximityKitManager startRangingIBeacons];
    
    self.SPs = [[NSMutableArray alloc] init];
    
    [center addObserverForName:@"FoundBeacon"
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *notification)
     {
         //         NSLog(@"Beacon Notificaton: %@",notification.userInfo);
         
//         [self.tempSPs addObject:notification.userInfo];
         [self newSP:notification.userInfo];
         //         NSLog(@"Notifications Count: %lu",(unsigned long)self.SPs.count);
     }];

    self.navigationItem.title = [NSString stringWithFormat:@"Tip: %@", self.selectedTipAmount];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    
//    [self findNearbySP];
    [self.SPs addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Daryl",@"firstName",@"Mootoo",@"lastName",@"Junior Valet",@"position",@"Best Valet, Llc",@"company",@" ",@"hard", nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newSP: (NSDictionary *)sp {
    [self.SPs addObject:sp];
    [self reloadData];
}

-(void)refresh {
    if ([self.refreshControl isRefreshing]) {
        NSLog(@"Refreshing");
        [self.SPs removeAllObjects];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.proximityKitManager startRangingIBeacons];
        
    }
    
    [self reloadData];
}

- (void)reloadData
{
    NSLog(@"Reload");
    
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
    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[SPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *firstName = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"firstName"];
    NSString *lastInitial = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"lastName"];
    NSString *position = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"position"];
//    NSString *company = [[self.SPs objectAtIndex:indexPath.row] objectForKey:@"company"];
    
    cell.lblSpName.text = [NSString stringWithFormat:@"%@ %@",firstName, lastInitial];
    cell.lblSpPosition.text = [NSString stringWithFormat:@"%@",position];
    
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
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    SPTableViewCell *cell = (SPTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
    NSLog(@"%@", cell.textLabel);
    
    if([segue.identifier isEqualToString:@"name"]) {
        
        ConfirmTipViewController *dest = [segue destinationViewController];
        if(self.cameFromCreateTip == YES){
            dest.cameFromCreateTip = YES;
        }
        dest.SP = cell.lblSpName.text;
        dest.tipAmount = self.selectedTipAmount;
        dest.confirmStatement = [NSString stringWithFormat:@"Do you want to tip %@, to %@?", self.selectedTipAmount,cell.lblSpName.text];
    }
    
}


@end
