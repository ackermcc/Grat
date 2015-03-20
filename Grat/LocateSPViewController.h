//
//  LocateSPViewController.h
//  Grat
//
//  Created by Chad Ackerman on 3/16/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateSPViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) NSString *selectedTipAmount;

@property (nonatomic) NSDictionary *SP;
@property (nonatomic) NSMutableArray *SPs;
@property (weak, nonatomic) IBOutlet UIView *btnFindSP;

@property (nonatomic) BOOL cameFromCreateTip;

@property (nonatomic) UILongPressGestureRecognizer *longPress;
@property (weak, nonatomic) IBOutlet UITableView *spTableView;

@property (nonatomic) UIRefreshControl *refreshControl;

@end
