//
//  RootViewController.h
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryViewController.h"
#import "ResultListViewController.h"


@interface RootViewController : UIViewController < QueryControllerDelegate >

@property (weak, nonatomic) QueryViewController * vcTop;
@property (weak, nonatomic) IBOutlet UIView * topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * bottomConstraint;

@property (weak, nonatomic) ResultListViewController * vcResult;
@property (weak, nonatomic) IBOutlet UIView * resultView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * heightConstraint;


@end

