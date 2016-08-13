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
    
    [self updateConstraints];
    
    self.inputField.delegate = self;
    self.inputField.backgroundColor = InputFieldNormalColor;
    self.inputField.borderStyle = UITextBorderStyleNone;
    self.inputField.layer.masksToBounds = true;
    self.inputField.layer.borderColor = [[UIColor clearColor]CGColor];
    self.inputField.layer.cornerRadius = 4.0f;
    self.inputField.font = [UIFont fontWithName:ThemeFont size:(iPadModel) ? iPadLargeFont : iPhoneLargeFont];
    
    self.centerButton.backgroundColor = [UIColor whiteColor];
    self.centerButton.layer.masksToBounds = true;
    self.centerButton.layer.cornerRadius = 4.0f;
    self.centerButton.titleLabel.font = [UIFont fontWithName:ThemeFont size:(iPadModel) ? iPadMediumFont : iPhoneMediumFont];
   
    self.upButton.backgroundColor = [UIColor whiteColor];
    self.upButton.layer.masksToBounds = true;
    self.upButton.layer.cornerRadius = 4.0f;
    self.upButton.layer.borderWidth = 2.0f;
    self.upButton.layer.borderColor = [ThemeColor CGColor];
    self.upButton.titleLabel.font = [UIFont fontWithName:ThemeFont size:(iPadModel) ? iPadMediumFont : iPhoneMediumFont];
    self.upButton.alpha = 0;
    
    self.titleLabel.font = [UIFont fontWithName:ThemeFont size:(iPadModel) ? iPadMediumFont : iPhoneMediumFont];
    self.warningLabel.font = [UIFont fontWithName:ThemeFont size:(iPadModel) ? iPadSmallFont : iPhoneSmallFont];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    

}

- (void) updateConstraints {
    
    self.inputWidth.constant = (iPadModel) ? 240.0f : 120.0f;
    self.inputHeight.constant = (iPadModel) ? 80.0f : 60.0f;
    self.inputTopOffset.constant = (iPadModel) ? 40.0f : 20.0f;
    self.inputBottomOffset.constant = (iPadModel) ? 40.0f : 20.0f;
   
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
