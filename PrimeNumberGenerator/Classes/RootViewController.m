//
//  RootViewController.m
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import "RootViewController.h"
#import "ResultListViewController.h"

#import "Constants.h"

@implementation RootViewController

#pragma mark- 

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = NavigationBarColor;
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.title = @"Prime Numbers";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbededResultsIdentifier"])
    {
        self.vcResult = segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"EmbededGeneratorIdentifier"])
    {
        self.vcTop = segue.destinationViewController;
        self.vcTop.delegate = self;
    }
}



#pragma mark - QueryController Delegate

- (void) generatePrimeNumbersByInputValue:(int)value
{
    [self.vcResult getPrimeNumbersToNthNumber:value];
    
//    NSString *deviceType = [UIDevice currentDevice].model;
//    
//    if([deviceType isEqualToString:iPhoneModel])
//    {
        [UIView animateWithDuration:.6f delay:0.0f usingSpringWithDamping:0.75f initialSpringVelocity:0.4f options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self showResultList: true];
                             
                         } completion:^(BOOL completed){
                             
                             self.navigationItem.title = [NSString stringWithFormat:@"First %i Prime Numbers", value];
                             
                             [self.vcTop.upButton.layer addAnimation:[self bounceAnimationWithCompletion:^{
                                 self.vcTop.upButton.alpha = 1;
                                 
                             }] forKey:@"com.cyt.view.bounceAnimation"];
                             
                         }];
//    }
    
}

- (void) resumePrimeNumbersGenerator
{
//    NSString *deviceType = [UIDevice currentDevice].model;
//    if ([deviceType isEqualToString:iPhoneModel])
//    {
        [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.75f initialSpringVelocity:0.4f options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self showResultList:false];
                             
                         } completion:^(BOOL completed) {
                             self.navigationItem.title = @"Prime Numbers";
                         }];
//    }
    
  
}

- (void) showResultList:(bool) show
{
    if (show)
    {
        CGRect topFrame = self.topView.frame;

        self.bottomConstraint.constant = topFrame.size.height - 44;
        self.heightConstraint.constant = self.bottomConstraint.constant;
        
        self.vcTop.centerButton.alpha = 0;
        self.vcTop.titleLabel.alpha = 0;
        
        self.vcTop.inputField.alpha = 0;
        
        self.vcTop.view.backgroundColor = [UIColor whiteColor];
        
        
        [self.view layoutIfNeeded];
    }
    else
    {
        
        self.bottomConstraint.constant = 0;
        self.heightConstraint.constant = self.bottomConstraint.constant;
        
        self.vcTop.centerButton.alpha = 1;
        self.vcTop.titleLabel.alpha = 1;
        
        self.vcTop.inputField.text = nil;
        self.vcTop.inputField.alpha = 1;
        
        
        self.vcTop.view.backgroundColor = ThemeColor;
        self.vcTop.upButton.alpha = 0;

        
        [self.view layoutIfNeeded];
    }
}


- (CAKeyframeAnimation *) bounceAnimationWithCompletion:(void (^)(void))block
{
    [CATransaction begin];

    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    theAnimation.values = @[@(0.05), @(1.1), @(0.9), @(1)];
    
    theAnimation.duration = 0.6;
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:theAnimation.values.count];
    for (NSUInteger i = 0; i < theAnimation.values.count; i++) {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [theAnimation setTimingFunctions:timingFunctions.copy];
    theAnimation.removedOnCompletion = YES;
    
    [CATransaction setCompletionBlock:block];
    [CATransaction commit];

    
    return theAnimation;
    
}

@end
