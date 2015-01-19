//
//  ConfirmTipViewController.h
//  Grat
//
//  Created by Chad Ackerman on 1/11/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmTipViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblConfirm;
@property (nonatomic) NSString *confirmStatement;
@property (nonatomic) NSString *tipAmount;
@property (nonatomic) NSString *SP;
- (IBAction)btnSubmitTip:(id)sender;
- (IBAction)btnCancelTip:(id)sender;

@end
