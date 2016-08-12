//
//  GeneratorViewController.m
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import "QueryViewController.h"

#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation QueryViewController

#pragma mark - 

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.inputField.delegate = self;
    self.inputField.backgroundColor = InputFieldNormalColor;
    self.inputField.borderStyle = UITextBorderStyleNone;
    self.inputField.layer.masksToBounds = true;
    self.inputField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.inputField.layer.cornerRadius = 4.0f;
    
    self.centerButton.backgroundColor = [UIColor whiteColor];
    self.centerButton.layer.masksToBounds = true;
    self.centerButton.layer.cornerRadius = 4.0f;
    
    self.upButton.backgroundColor = [UIColor whiteColor];
    self.upButton.layer.masksToBounds = true;
    self.upButton.layer.cornerRadius = 4.0f;
    self.upButton.layer.borderWidth = 2.0f;
    self.upButton.layer.borderColor = [ThemeColor CGColor];
    self.upButton.alpha = 0;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

#pragma mark - UITextField Delegate

#pragma mark - Actions

- (void) dismissKeyboard {
    [self.inputField resignFirstResponder];
}

- (IBAction) generatePrimeNumbers:(id)sender
{
    BOOL validate = [self validateInputFields:self.inputField.text];
    if (!validate)
    {
        self.inputField.backgroundColor = InputFieldWarningColor;
        [UIView animateWithDuration:.4f animations:^{
            self.warningLabel.alpha = 1.0f;
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name: UITextFieldTextDidChangeNotification object:nil];
    }
    else
    {
        [self dismissKeyboard];
        
        if ([self.delegate respondsToSelector:@selector(generatePrimeNumbersByInputValue:)])
        {
            [self.delegate generatePrimeNumbersByInputValue:[self.inputField.text intValue]];
        }
        
    }
}

- (IBAction)resumeTheQuery:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(resumePrimeNumbersGenerator)])
    {
        [self.delegate resumePrimeNumbersGenerator];
    }
}

- (BOOL) validateInputFields:(NSString *) value
{
    if (value == nil || value.length == 0 ||[value isEqualToString:@""]) {return false;}
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", InputRegex];
    BOOL isValid = [predicate evaluateWithObject:value];
    
    if (isValid == false) { return false;}
    
    int number = [value intValue];
    return  (number <= MaxInputValue && number >= MinInputValue);
    
}

#pragma mark - Notification 

- (void) textDidChange:(NSNotification *)notification
{
    BOOL validate = [self validateInputFields:self.inputField.text];
    if (validate) {
        self.inputField.backgroundColor = InputFieldNormalColor;
        self.warningLabel.alpha = 0;
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }

}

@end
