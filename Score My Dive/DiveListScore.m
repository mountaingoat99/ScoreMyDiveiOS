//
//  DiveListScore.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListScore.h"
#import "ValidScores.h"
#import "HTAutocompleteManager.h"

@interface DiveListScore ()

@property (nonatomic, strong) NSNumber *judgesTotal;
@property (nonatomic, strong) NSArray *validScores;

-(void)whatJudgeTotal;
-(void)ScoreOptions;

@end

@implementation DiveListScore

#pragma View Controller methods

- (void)viewDidLoad {
    [super viewDidLoad];

    // sets the default datasource for the autocomplete custom text boxes
    [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
    
    self.txt1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt1.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt1.layer.masksToBounds = NO;
    self.txt1.layer.shadowRadius = 4.0f;
    self.txt1.layer.shadowOpacity = .3;
    self.txt1.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt1.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt1.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt1.delegate = self;
    
    self.txt2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt2.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt2.layer.masksToBounds = NO;
    self.txt2.layer.shadowRadius = 4.0f;
    self.txt2.layer.shadowOpacity = .3;
    self.txt2.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt2.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt2.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt2.delegate = self;
    
    self.txt3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt3.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt3.layer.masksToBounds = NO;
    self.txt3.layer.shadowRadius = 4.0f;
    self.txt3.layer.shadowOpacity = .3;
    self.txt3.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt3.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt3.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt3.delegate = self;
    
    self.txt4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt4.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt4.layer.masksToBounds = NO;
    self.txt4.layer.shadowRadius = 4.0f;
    self.txt4.layer.shadowOpacity = .3;
    self.txt4.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt4.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt4.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt4.delegate = self;
    
    self.txt5.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt5.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt5.layer.masksToBounds = NO;
    self.txt5.layer.shadowRadius = 4.0f;
    self.txt5.layer.shadowOpacity = .3;
    self.txt5.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt5.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt5.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt5.delegate = self;
    
    self.txt6.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt6.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt6.layer.masksToBounds = NO;
    self.txt6.layer.shadowRadius = 4.0f;
    self.txt6.layer.shadowOpacity = .3;
    self.txt6.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt6.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt6.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt6.delegate = self;
    
    self.txt7.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt7.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt7.layer.masksToBounds = NO;
    self.txt7.layer.shadowRadius = 4.0f;
    self.txt7.layer.shadowOpacity = .3;
    self.txt7.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt7.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt7.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt7.delegate = self;
    
    self.txt8.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt8.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt8.layer.masksToBounds = NO;
    self.txt8.layer.shadowRadius = 4.0f;
    self.txt8.layer.shadowOpacity = .3;
    self.txt8.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt8.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt8.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt8.delegate = self;
    
    self.txt9.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt9.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt9.layer.masksToBounds = NO;
    self.txt9.layer.shadowRadius = 4.0f;
    self.txt9.layer.shadowOpacity = .3;
    self.txt9.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt9.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt9.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt9.delegate = self;
    
    self.txt10.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt10.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt10.layer.masksToBounds = NO;
    self.txt10.layer.shadowRadius = 4.0f;
    self.txt10.layer.shadowOpacity = .3;
    self.txt10.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt10.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt10.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt10.delegate = self;
    
    self.txt11.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt11.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt11.layer.masksToBounds = NO;
    self.txt11.layer.shadowRadius = 4.0f;
    self.txt11.layer.shadowOpacity = .3;
    self.txt11.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt11.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt11.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt11.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
    [self whatJudgeTotal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (!string.length)
        return YES;
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]|10{1}+)?(\\.([0|5]{1})?)?$";
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
-(void)whatJudgeTotal {
    
}

-(void)ScoreOptions {
    
    ValidScores *score = [[ValidScores alloc] init];
    self.validScores = [score GetValidScores];
    
}


@end
