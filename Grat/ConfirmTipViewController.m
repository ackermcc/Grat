//
//  ConfirmTipViewController.m
//  Grat
//
//  Created by Chad Ackerman on 1/11/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "ConfirmTipViewController.h"

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
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } else if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            NSLog(@"Cancel Tip");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

@end
