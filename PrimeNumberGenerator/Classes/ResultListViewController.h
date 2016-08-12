//
//  RootViewController.h
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultListViewController : UITableViewController
- (void) getPrimeNumbersToNthNumber:(int)nth;
@end
