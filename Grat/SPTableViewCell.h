//
//  SPTableViewCell.h
//  Grat
//
//  Created by Chad Ackerman on 2/21/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSpName;
@property (weak, nonatomic) IBOutlet UILabel *lblSpPosition;

@end
