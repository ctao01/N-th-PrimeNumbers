//
//  RootViewController.m
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import "RootViewController.h"
#import "Constants.h"
#import "ResultListViewController.h"

@interface RootViewController ()
@property (nonatomic , strong) ResultListViewController * vcResult;
@end


@implementation RootViewController

#pragma mark- 

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbededResultsIdentifier"]) {
        self.vcResult = segue.destinationViewController;
    }
}


#pragma mark - Actions

- (IBAction) generatePrimeNumbers:(id)sender
{
    BOOL validate = [self validateInputFields:self.inputField.text];
    if (!validate)
    {
        
    }
    else
    {
        [self.vcResult getPrimeNumbersToNthNumber:[self.inputField.text intValue]];
    }
}


- (BOOL) validateInputFields:(NSString *) value
{
    if (value == nil || value.length == 0 ||[value isEqualToString:@""]) {return false;}
    
    int number = [value intValue];
    return  (number <= MaxInputValue && number >= MinInputValue);
    
}

@end
