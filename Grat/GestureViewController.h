//
//  GestureViewController.h
//  Grat
//
//  Created by Chad Ackerman on 3/9/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (nonatomic) NSString *SPname;
@property (nonatomic) NSString *SPtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSPname;
@property (weak, nonatomic) IBOutlet UILabel *lblSPtitle;
@property (weak, nonatomic) IBOutlet UIView *SPcontainer;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *toConfirmTip;

@property (nonatomic) BOOL cameFromCreateTip;
@end
