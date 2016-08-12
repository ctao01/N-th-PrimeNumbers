//
//  RootViewController.h
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrimeNumbersGeneratorDelegate;

@interface RootViewController : UIViewController
@property (nonatomic , strong) IBOutlet UITextField * inputField;
@end

