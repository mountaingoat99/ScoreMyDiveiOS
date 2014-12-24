//
//  DiveListScore.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListScore.h"
#import "HTAutocompleteManager.h"
#import "Judges.h"
#import "JudgeScores.h"

@interface DiveListScore ()

@property (nonatomic, strong) NSNumber *judgesTotal;
@property (nonatomic, strong) NSArray *validScores;
@property (nonatomic) bool validScore;
@property (nonatomic, strong) NSNumber *scr1;
@property (nonatomic, strong) NSNumber *scr2;
@property (nonatomic, strong) NSNumber *scr3;
@property (nonatomic, strong) NSNumber *scr4;
@property (nonatomic, strong) NSNumber *scr5;
@property (nonatomic, strong) NSNumber *scr6;
@property (nonatomic, strong) NSNumber *scr7;

-(void)whatJudgeTotal;
-(void)HideControls;
-(void)DiveText;
-(BOOL)CalcScores;

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
    self.txt1.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt1.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt1.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt1.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt1.delegate = self;
    
    self.txt2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt2.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt2.layer.masksToBounds = NO;
    self.txt2.layer.shadowRadius = 4.0f;
    self.txt2.layer.shadowOpacity = .3;
    self.txt2.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt2.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt2.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt2.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt2.delegate = self;
    
    self.txt3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt3.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt3.layer.masksToBounds = NO;
    self.txt3.layer.shadowRadius = 4.0f;
    self.txt3.layer.shadowOpacity = .3;
    self.txt3.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt3.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt3.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt3.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt3.delegate = self;
    
    self.txt4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt4.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt4.layer.masksToBounds = NO;
    self.txt4.layer.shadowRadius = 4.0f;
    self.txt4.layer.shadowOpacity = .3;
    self.txt4.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt4.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt4.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt4.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt4.delegate = self;
    
    self.txt5.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt5.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt5.layer.masksToBounds = NO;
    self.txt5.layer.shadowRadius = 4.0f;
    self.txt5.layer.shadowOpacity = .3;
    self.txt5.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt5.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt5.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt5.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt5.delegate = self;
    
    self.txt6.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt6.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt6.layer.masksToBounds = NO;
    self.txt6.layer.shadowRadius = 4.0f;
    self.txt6.layer.shadowOpacity = .3;
    self.txt6.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt6.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt6.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt6.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt6.delegate = self;
    
    self.txt7.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt7.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt7.layer.masksToBounds = NO;
    self.txt7.layer.shadowRadius = 4.0f;
    self.txt7.layer.shadowOpacity = .3;
    self.txt7.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txt7.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt7.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt7.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt7.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
    [self whatJudgeTotal];
    [self HideControls];
    [self DiveText];
    
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
    
    bool good;
    
    if ([self.judgesTotal isEqualToNumber:@2]) {
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                message:@"Score was not valid, please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [error show];
                [error reloadInputViews];
                
            }
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You forgot a score"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else if ([self.judgesTotal isEqualToNumber:@3]) {
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0 && self.txt3.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                message:@"Score was not valid, please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [error show];
                [error reloadInputViews];
                
            }
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You forgot a score"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else if ([self.judgesTotal isEqualToNumber:@5]) {
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0 && self.txt3.text.length > 0 && self.txt2.text.length > 0 && self.txt5.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                message:@"Score was not valid, please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [error show];
                [error reloadInputViews];
                
            }
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You forgot a score"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else {
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0 && self.txt3.text.length > 0 && self.txt2.text.length > 0 && self.txt5.text.length > 0 && self.txt6.text.length > 0 && self.txt7.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                
                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                message:@"Score was not valid, please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [error show];
                [error reloadInputViews];
                
            }
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You forgot a score"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    }
}

- (IBAction)btnFailedClick:(id)sender {
    
}

#pragma private methods
-(void)whatJudgeTotal {
    
    Judges *judges = [[Judges alloc] init];
    
    judges = [self.meetInfo objectAtIndex:1];
    
    self.judgesTotal = judges.judgeTotal;
    
}

-(void)HideControls {
    
    int judgetotal = [self.judgesTotal intValue];
    
    switch (judgetotal) {
        case 2:
            [self.txt3 setHidden:YES];
            [self.txt4 setHidden:YES];
            [self.txt5 setHidden:YES];
            [self.txt6 setHidden:YES];
            [self.txt7 setHidden:YES];
            [self.lblScore3 setHidden:YES];
            [self.lblScore4 setHidden:YES];
            [self.lblScore5 setHidden:YES];
            [self.lblScore6 setHidden:YES];
            [self.lblScore7 setHidden:YES];
            break;
        case 3:
            [self.txt4 setHidden:YES];
            [self.txt5 setHidden:YES];
            [self.txt6 setHidden:YES];
            [self.txt7 setHidden:YES];
            [self.lblScore4 setHidden:YES];
            [self.lblScore5 setHidden:YES];
            [self.lblScore6 setHidden:YES];
            [self.lblScore7 setHidden:YES];
        case 5:
            [self.txt6 setHidden:YES];
            [self.txt7 setHidden:YES];
            [self.lblScore6 setHidden:YES];
            [self.lblScore7 setHidden:YES];
        default:
            break;
            
    }
}

-(void)DiveText {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    self.lblDiveType.text = [scores GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    
    NSString *diveNumberString = @"Score Dive ";
    
    diveNumberString = [diveNumberString stringByAppendingString:[NSString stringWithFormat:@"%d", self.diveNumber]];
    
    self.lblDiveNumber.text = diveNumberString;
    
}

-(BOOL)CalcScores {
    
    bool good;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    if ([self.judgesTotal isEqualToNumber:@2]) {
        self.scr1 = @([self.txt1.text doubleValue]);
        self.scr2 = @([self.txt2.text doubleValue]);
        
        return good = [scores Calculate2JudgesScore:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber meetinfo:self.meetInfo score1:self.scr1 score2:self.scr2];
        
    } else if ([self.judgesTotal isEqualToNumber:@3]) {
        
        self.scr1 = @([self.txt1.text doubleValue]);
        self.scr2 = @([self.txt2.text doubleValue]);
        self.scr3 = @([self.txt3.text doubleValue]);
        
        return good = [scores Calculate3JudgesScore:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber meetinfo:self.meetInfo score1:self.scr1 score2:self.scr2 score3:self.scr3];
        
    } else if ([self.judgesTotal isEqualToNumber:@5]) {
        
        self.scr1 = @([self.txt1.text doubleValue]);
        self.scr2 = @([self.txt2.text doubleValue]);
        self.scr3 = @([self.txt3.text doubleValue]);
        self.scr4 = @([self.txt4.text doubleValue]);
        self.scr5 = @([self.txt5.text doubleValue]);
        
        return good = [scores Calculate5JudgesScore:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber meetinfo:self.meetInfo score1:self.scr1 score2:self.scr2 score3:self.scr3 score4:self.scr4 score5:self.scr5];
        
    } else {
        
        self.scr1 = @([self.txt1.text doubleValue]);
        self.scr2 = @([self.txt2.text doubleValue]);
        self.scr3 = @([self.txt3.text doubleValue]);
        self.scr4 = @([self.txt4.text doubleValue]);
        self.scr5 = @([self.txt5.text doubleValue]);
        self.scr6 = @([self.txt6.text doubleValue]);
        self.scr7 = @([self.txt7.text doubleValue]);
        
        return good = [scores Calculate7JudgesScore:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber meetinfo:self.meetInfo score1:self.scr1 score2:self.scr2 score3:self.scr3 score4:self.scr4 score5:self.scr5 score6:self.scr6 score7:self.scr7];
        
    }
    
    return false;
}

@end
