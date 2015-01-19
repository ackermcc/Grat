//
//  CustomTipViewController.h
//  Grat
//
//  Created by Chad Ackerman on 1/19/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTipViewController : UIViewController
- (IBAction)btnDismissTipView:(id)sender;
- (IBAction)btnTipSelected:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *inptTipAmount;

@end
