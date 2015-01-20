//
//  TransactionHistoryTableViewController.h
//  Grat
//
//  Created by Chad Ackerman on 1/19/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionHistoryTableViewController : UITableViewController
- (IBAction)btnHideHistory:(id)sender;
@property (nonatomic) NSArray *transactionsHistory;
@end
