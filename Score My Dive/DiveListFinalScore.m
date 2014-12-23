//
//  DiveListFinalScore.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListFinalScore.h"

@interface DiveListFinalScore ()

@end

@implementation DiveListFinalScore

#pragma viewcontroller methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.txtTotalScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtTotalScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtTotalScore.layer.masksToBounds = NO;
    self.txtTotalScore.layer.shadowRadius = 4.0f;
    self.txtTotalScore.layer.shadowOpacity = .3;
    self.txtTotalScore.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtTotalScore.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtTotalScore.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide the Keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (!string.length)
        return YES;
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]{1,3}+)?(\\.([0-9]{1,2})?)?$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0) return NO;
    return YES;
}

- (IBAction)btnTotalClick:(id)sender {
    
}

- (IBAction)btnFailedClick:(id)sender {
    
}

#pragma private methods
@end
