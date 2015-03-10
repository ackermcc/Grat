//
//  GestureViewController.m
//  Grat
//
//  Created by Chad Ackerman on 3/9/15.
//  Copyright (c) 2015 Chad Ackerman. All rights reserved.
//

#import "GestureViewController.h"

#define kMinimumPanDistance 10.0f
CGPoint lastRecognizedInterval;
CGPoint previousRecognizedInterval;

@interface GestureViewController ()

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *valuePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:valuePan];
}

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint touchLocation = [panGestureRecognizer translationInView:self.view];
    NSLog(@"location: %f", touchLocation.y);
    if (abs(lastRecognizedInterval.y - touchLocation.y) > kMinimumPanDistance) {

        previousRecognizedInterval = lastRecognizedInterval;
        lastRecognizedInterval = touchLocation;
        
        if (previousRecognizedInterval.y > lastRecognizedInterval.y) {
            NSLog(@"INCREASE");
            NSArray *components = [self.lblValue.text componentsSeparatedByString:@"$"];
            NSString *query = [components lastObject];
            CGFloat strFloat = (CGFloat)[query floatValue];
            self.lblValue.text = [NSString stringWithFormat:@"$%.f", (strFloat + 1)];
        } else {
            NSLog(@"DECREASE");
            NSArray *components = [self.lblValue.text componentsSeparatedByString:@"$"];
            NSString *query = [components lastObject];
            CGFloat strFloat = (CGFloat)[query floatValue];
            if(strFloat != 0)
                self.lblValue.text = [NSString stringWithFormat:@"$%.f", (strFloat - 1)];
        }
        
    }
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
