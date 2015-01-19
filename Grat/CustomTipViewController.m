//
//  CustomTipViewController.m
//  Grat
//
//  Created by Chad Ackerman on 1/19/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "CustomTipViewController.h"
#import "SPTableViewController.h"

@interface CustomTipViewController ()

@end

@implementation CustomTipViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.inptTipAmount becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    SPTableViewController *dest = [segue destinationViewController];
    
    if ([segue.identifier isEqual:@"Custom Tip"]) {
        dest.selectedTipAmount = [NSString stringWithFormat:@"$%@", self.inptTipAmount.text];
        dest.cameFromCreateTip = YES;
    }
}


- (IBAction)btnDismissTipView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnTipSelected:(id)sender {
    if ([self.inptTipAmount.text length] > 0) {
        [self performSegueWithIdentifier:@"Custom Tip" sender:self];
    } else {
        UIAlertView *needValidTip = [[UIAlertView alloc] initWithTitle:@"Valid Tip Required" message:@"You must enter a valid tip amount to proceed." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [needValidTip show];
    }
}

@end
