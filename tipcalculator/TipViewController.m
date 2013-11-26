//
//  TipViewController.m
//  tipcalculator
//
//  Created by Utkarsh Sengar on 11/24/13.
//  Copyright (c) 2013 area42. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
- (IBAction)onTap:(id)sender;
- (void)updateValues;
@end

@implementation TipViewController

static NSString *billTextField;

+(void)initialize {
    if (self == [TipViewController class]) {
        billTextField = @"0";
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Simple Tip";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTapFromTipControl:(id)sender {
    [self computeValues:[billTextField floatValue]];
}

- (void)updateValues {
    [self renderAlert];
}

- (void) renderAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bill" message:@"What is your bill?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];

    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        billTextField = [[alertView textFieldAtIndex:0] text];
        float billAmount = [billTextField floatValue];
        [self computeValues:billAmount];
    }
}

- (void)computeValues:(float)billAmount{
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.billLabel.text = [NSMutableString stringWithFormat:@"$%0.2f", billAmount];
    self.tipLabel.text = [NSMutableString stringWithFormat:@"+ $%0.2f", tipAmount];
    self.totalLabel.text = [NSMutableString stringWithFormat:@"$%0.2f", totalAmount];
}

@end
