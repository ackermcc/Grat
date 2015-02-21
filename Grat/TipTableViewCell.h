//
//  TipTableViewCell.h
//  Grat
//
//  Created by Chad Ackerman on 2/21/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTipAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTipSugestionString;

@end
