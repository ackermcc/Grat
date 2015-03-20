//
//  LocateSPViewController.m
//  Grat
//
//  Created by Chad Ackerman on 3/16/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "LocateSPViewController.h"
#import "AppDelegate.h"
#import "ConfirmTipViewController.h"
#import "SPTableViewCell.h"
#import "GestureViewController.h"

#import <NSString+FontAwesome.h>

@interface LocateSPViewController ()

@end

@implementation LocateSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.spTableView.dataSource = self;
    self.spTableView.delegate = self;
    
    //Back Button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style: UIBarButtonItemStylePlain
                                   target: nil action: nil];
    
    //Search
    UIBarButtonItem *search = [[UIBarButtonItem alloc]
                               initWithTitle: @"Search"
                               style: UIBarButtonItemStylePlain
                               target: nil action: nil];
    
    [search setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"FontAwesome" size:20.0], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    nil]
     
                          forState:UIControlStateNormal];
    
    search.title = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-search"];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    [self.navigationItem setRightBarButtonItems:@[search] animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
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
    
    //    self.navigationItem.title = [NSString stringWithFormat:@"Tip: %@", self.selectedTipAmount];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [self.spTableView addSubview:self.refreshControl];
    
    //    [self findNearbySP];
    [self.SPs addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Daryl",@"firstName",@"Mootoo",@"lastName",@"Junior Valet",@"position",@"Best Valet, Llc",@"company",@" ",@"hard", nil]];
    
    //Long Press
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdAction:)];
    [self.longPress setMinimumPressDuration:0.01];
    [self.btnFindSP addGestureRecognizer:self.longPress];
}

- (void)holdAction:(UILongPressGestureRecognizer *)holdRecognizer
{
    if (holdRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Holding Correctly. Release when ready.");
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.proximityKitManager startRangingIBeacons];
    } else if (holdRecognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"You let go!");
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.proximityKitManager stopRangingIBeacons];
    }
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
    [self.spTableView reloadData];
    
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
    [self performSegueWithIdentifier:@"chooseTip" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *path = [self.spTableView indexPathForSelectedRow];
    SPTableViewCell *cell = (SPTableViewCell *)[self.spTableView cellForRowAtIndexPath:path];
    NSLog(@"%@", cell.textLabel);
    
    if([segue.identifier isEqualToString:@"chooseTip"]) {
        
        GestureViewController *dest = [segue destinationViewController];
//        if(self.cameFromCreateTip == YES){
//            dest.cameFromCreateTip = YES;
//        }
        dest.SPname = cell.lblSpName.text;
        dest.SPtitle = cell.lblSpPosition.text;
    }
    
}

@end
