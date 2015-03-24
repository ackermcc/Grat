//
//  ConfirmTipViewController.m
//  Grat
//
//  Created by Chad Ackerman on 1/11/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "ConfirmTipViewController.h"
#import "TipSelectionTableViewController.h"
#import <Firebase/Firebase.h>

@interface ConfirmTipViewController ()

@end

@implementation ConfirmTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lblConfirm.text = self.confirmStatement;
    
    //Back Button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style: UIBarButtonItemStylePlain
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    UIColor *pink = [UIColor colorWithRed:240.0/255.0 green:70.0/255.0 blue:94.0/255.0 alpha:1.0];
    
    self.btnSubmitTip.layer.cornerRadius = 5;
    [self.btnSubmitTip setBackgroundColor:pink];
    self.btnSubmitTip.tintColor = [UIColor whiteColor];
    
    self.btnCancelTip.layer.cornerRadius = 5;
    [self.btnCancelTip setBackgroundColor:[UIColor grayColor]];
    self.btnCancelTip.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSubmitTip:(id)sender {
    
    UIAlertView *confirmSubmit = [[UIAlertView alloc] initWithTitle:@"Confirm Tip" message:[NSString stringWithFormat:@"Tip %@ to %@?", self.tipAmount, self.SP] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    
    [confirmSubmit setTag:0];
    [confirmSubmit show];
}

- (IBAction)btnCancelTip:(id)sender {
    UIAlertView *confirmCancel = [[UIAlertView alloc] initWithTitle:@"Cancel Tip" message:[NSString stringWithFormat:@"Cancel tip %@ to %@?", self.tipAmount, self.SP] delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Cancel Tip", nil];
    
    [confirmCancel setTag:1];
    [confirmCancel show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if (buttonIndex == 1) {
            NSLog(@"Submit Tip");
            if (self.cameFromCreateTip == YES) {
                [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
                self.navigationItem.prompt = @"Select Tip Amount";
            }
            
            NSDate *now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
            NSString *timeStamp = [dateFormatter stringFromDate:now];
            
            [self submitTipTransactionWithTime:timeStamp tip:self.tipAmount sp:self.SP];
        }
    } else if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            NSLog(@"Cancel Tip");
            if (self.cameFromCreateTip == YES) {
                [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
                self.navigationItem.prompt = @"Select Tip Amount";
            }
        }
    }
}

-(void)submitTipTransactionWithTime:(NSString *)time tip:(NSString *)tip sp:(NSString *)sp {
    // Create a reference to a Firebase location
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://grat.firebaseio.com"];
    // Write data to Firebase
    Firebase *transactions = [myRootRef childByAppendingPath:@"transactions"];
    Firebase *postRef = [transactions childByAutoId];
    
    NSDictionary *transaction = @{
                                  @"time-stamp": time,
                                  @"service-professional": sp,
                                  @"tip-amount": tip
                                  };
    
    [postRef setValue:transaction];
}

@end
