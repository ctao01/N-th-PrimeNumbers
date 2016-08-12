//
//  GeneratorViewController.h
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QueryControllerDelegate;


@interface QueryViewController : UIViewController   < UITextFieldDelegate >

@property (nonatomic, strong) IBOutlet UIButton * upButton;

@property (nonatomic, strong) IBOutlet UITextField * inputField;
@property (nonatomic, strong) IBOutlet UILabel * titleLabel;
@property (nonatomic, strong) IBOutlet UIButton * centerButton;
@property (nonatomic, strong) IBOutlet UILabel * warningLabel;

@property (nonatomic, weak) id<QueryControllerDelegate> delegate;

@end

@protocol QueryControllerDelegate <NSObject>
@optional

- (void) generatePrimeNumbersByInputValue:(int)value;
- (void) resumePrimeNumbersGenerator;

@end
