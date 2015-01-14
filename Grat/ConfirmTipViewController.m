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

@end
