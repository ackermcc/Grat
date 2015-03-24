//
//  SPTableViewController.h
//  Grat-Demo
//
//  Created by Chad Ackerman on 1/8/15.
//  Copyright (c) 2015 Grat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTableViewController : UITableViewController

@property(nonatomic) NSString *selectedTipAmount;

@property (nonatomic) NSDictionary *SP;
@property (nonatomic) NSMutableArray *SPs;
@property (weak, nonatomic) IBOutlet UIView *btnFindSP;

@property (nonatomic) BOOL cameFromCreateTip;
@property (nonatomic) BOOL holding;

@property (nonatomic) UILongPressGestureRecognizer *longPress;

@end
