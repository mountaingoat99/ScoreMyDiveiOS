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
#import "Results.h"
#import "DiveNumber.h"
#import "DiveListChoose.h"
#import "DiverBoardSize.h"
#import "DiveEnter.h"
#import "DiveList.h"
#import "MeetCollection.h"

@interface DiveListScore ()

@property (nonatomic, strong) NSNumber *judgesTotal;
@property (nonatomic, strong) NSNumber *scr1;
@property (nonatomic, strong) NSNumber *scr2;
@property (nonatomic, strong) NSNumber *scr3;
@property (nonatomic, strong) NSNumber *scr4;
@property (nonatomic, strong) NSNumber *scr5;
@property (nonatomic, strong) NSNumber *scr6;
@property (nonatomic, strong) NSNumber *scr7;
@property (nonatomic, strong) NSNumber *boardSize;

-(void)whatJudgeTotal;
-(void)HideControls;
-(void)DiveText;
-(BOOL)CalcScores;
-(BOOL)updateFailedDive;
-(void)DiverBoardSize;

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
    self.txt1.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt1.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt1.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt1.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt1.delegate = self;
    
    self.txt2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt2.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt2.layer.masksToBounds = NO;
    self.txt2.layer.shadowRadius = 4.0f;
    self.txt2.layer.shadowOpacity = .3;
    self.txt2.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt2.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt2.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt2.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt2.delegate = self;
    
    self.txt3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt3.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt3.layer.masksToBounds = NO;
    self.txt3.layer.shadowRadius = 4.0f;
    self.txt3.layer.shadowOpacity = .3;
    self.txt3.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt3.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt3.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt3.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt3.delegate = self;
    
    self.txt4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt4.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt4.layer.masksToBounds = NO;
    self.txt4.layer.shadowRadius = 4.0f;
    self.txt4.layer.shadowOpacity = .3;
    self.txt4.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt4.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt4.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt4.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt4.delegate = self;
    
    self.txt5.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt5.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt5.layer.masksToBounds = NO;
    self.txt5.layer.shadowRadius = 4.0f;
    self.txt5.layer.shadowOpacity = .3;
    self.txt5.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt5.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt5.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt5.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt5.delegate = self;
    
    self.txt6.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt6.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt6.layer.masksToBounds = NO;
    self.txt6.layer.shadowRadius = 4.0f;
    self.txt6.layer.shadowOpacity = .3;
    self.txt6.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt6.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt6.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt6.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt6.delegate = self;
    
    self.txt7.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txt7.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txt7.layer.masksToBounds = NO;
    self.txt7.layer.shadowRadius = 4.0f;
    self.txt7.layer.shadowOpacity = .3;
    self.txt7.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.txt7.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txt7.keyboardType = UIKeyboardTypeDecimalPad;
    self.txt7.autocompleteType = HTAutoCompleteTypeNumbers;
    self.txt7.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self whatJudgeTotal];
    [self HideControls];
    [self DiveText];
    
}

// only allow portrait in iphone
-(BOOL)shouldAutorotate {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

// restore state because Apple doesn't know how to write a modern OS
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeInt:self.diveNumber forKey:@"diveNumber"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeBool:self.listOrNot forKey:@"listOrNot"];
    [coder encodeObject:self.diveCategory forKey:@"diveCat"];
    [coder encodeObject:self.divePosition forKey:@"divePos"];
    [coder encodeObject:self.diveNameForDB forKey:@"diveNameDB"];
    [coder encodeObject:self.multiplierToSend forKey:@"multiplier"];
    
    if (self.txt1.text.length > 0) {
        [coder encodeObject:self.txt1.text forKey:@"text1"];
    }
    if (self.txt2.text.length > 0) {
        [coder encodeObject:self.txt2.text forKey:@"text2"];
    }
    if (self.txt3.text.length > 0) {
        [coder encodeObject:self.txt3.text forKey:@"text3"];
    }
    if (self.txt4.text.length > 0) {
        [coder encodeObject:self.txt4.text forKey:@"text4"];
    }
    if (self.txt5.text.length > 0) {
        [coder encodeObject:self.txt5.text forKey:@"text5"];
    }
    if (self.txt6.text.length > 0) {
        [coder encodeObject:self.txt6.text forKey:@"text6"];
    }
    if (self.txt7.text.length > 0) {
        [coder encodeObject:self.txt7.text forKey:@"text7"];
    }
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.diveNumber = [coder decodeIntForKey:@"diveNumber"];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.listOrNot = [coder decodeBoolForKey:@"listOrNot"];
    self.diveCategory = [coder decodeObjectForKey:@"diveCat"];
    self.divePosition = [coder decodeObjectForKey:@"divePos"];
    self.diveNameForDB = [coder decodeObjectForKey:@"diveNameDB"];
    self.multiplierToSend = [coder decodeObjectForKey:@"multiplier"];
    self.txt1.text = [coder decodeObjectForKey:@"text1"];
    self.txt2.text = [coder decodeObjectForKey:@"text2"];
    self.txt3.text = [coder decodeObjectForKey:@"text3"];
    self.txt4.text = [coder decodeObjectForKey:@"text4"];
    self.txt5.text = [coder decodeObjectForKey:@"text5"];
    self.txt6.text = [coder decodeObjectForKey:@"text6"];
    self.txt7.text = [coder decodeObjectForKey:@"text7"];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idReturnToDiveListChoose"]) {
        
        DiveListChoose *choose = [segue destinationViewController];
        choose.diverRecordID = self.diverRecordID;
        choose.meetRecordID = self.meetRecordID;
        
    }
    
    if ([segue.identifier isEqualToString:@"idSegueListScoreToDiveEnter"]) {
        
        DiveEnter *choose = [segue destinationViewController];
        choose.meetInfo = self.meetInfo;
        choose.diverRecordID = self.diverRecordID;
        choose.meetRecordID = self.meetRecordID;
        
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    
    if (textField == self.txt1) {
        [self.txt2 becomeFirstResponder];
    }
    if (textField == self.txt2) {
        [self.txt3 becomeFirstResponder];
    }
    if (textField == self.txt3) {
        [self.txt4 becomeFirstResponder];
    }
    if (textField == self.txt4) {
        [self.txt5 becomeFirstResponder];
    }
    if (textField == self.txt5) {
        [self.txt6 becomeFirstResponder];
    }
    if (textField == self.txt6) {
        [self.txt7 becomeFirstResponder];
    }
    if (textField == self.txt7) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)btnTotalClick:(id)sender {
    
    bool good;
    
    if ([self.judgesTotal isEqualToNumber:@2]) {
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                // here we need to test the self.listOrNot and see who sent us, then return to them
                if (self.listOrNot == 0) {
                    [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
                }
                
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
                
                // here we need to test the self.listOrNot and see who sent us, then return to them
                if (self.listOrNot == 0) {
                    [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
                }
                
                
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
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0 && self.txt3.text.length > 0 && self.txt4.text.length > 0 && self.txt5.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                // here we need to test the self.listOrNot and see who sent us, then return to them
                if (self.listOrNot == 0) {
                    [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
                }
                
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
        
        if (self.txt1.text.length > 0 && self.txt2.text.length > 0 && self.txt3.text.length > 0 && self.txt4.text.length > 0 && self.txt5.text.length > 0 && self.txt6.text.length > 0 && self.txt7.text.length > 0) {
            
            if ((good = [self CalcScores])) {
                
                // here we need to test the self.listOrNot and see who sent us, then return to them
                if (self.listOrNot == 0) {
                    [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
                }
                
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
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Failed Dive! Are you sure?"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Action");
                                   
                                   bool good;
                                   
                                   if ((good = [self updateFailedDive])) {
                                       
                                       // here we need to test the self.listOrNot and see who sent us, then return to them
                                       if (self.listOrNot == 0) {
                                           [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
                                       } else {
                                           [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
                                       }
                                       
                                   } else {
                                       
                                       UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                                       message:@"Dive couldn't be failed, please try again"
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil];
                                       [error show];
                                       [error reloadInputViews];
                                   }
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)btnReturnClick:(id)sender {
    
    // here we need to test the self.listOrNot and see who sent us, then return to them
    if (self.listOrNot == 0) {
        [self performSegueWithIdentifier:@"idReturnToDiveListChoose" sender:self];
    } else {
        [self performSegueWithIdentifier:@"idSegueListScoreToDiveEnter" sender:self];
    }
}

#pragma private methods
-(void)whatJudgeTotal {
    
    //Judges *judges = [[Judges alloc] init];
    
    Judges *judges = [self.meetInfo objectAtIndex:1];
    
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
    
    if (self.listOrNot == 1) {
        
        NSRange dash;
        NSString *diveName;
        NSString *divePos;
        
        //now lets parse the diveNumber out of the dive
        dash = [self.diveNameForDB rangeOfString:@"-"];
        if (dash.location != NSNotFound) {
            diveName = [self.diveNameForDB substringWithRange:NSMakeRange(0, (dash.location - 1))];
        }
        // now parse the dive Position
        dash = [self.divePosition rangeOfString:@"-"];
        if (dash.location != NSNotFound) {
            divePos = [self.divePosition substringWithRange:NSMakeRange(0, (dash.location - 1))];
        }
        
        NSString *divetype = self.diveCategory;
        divetype = [divetype stringByAppendingString:@" - "];
        divetype = [divetype stringByAppendingString:diveName];
        divetype = [divetype stringByAppendingString:divePos];
        divetype = [divetype stringByAppendingString:@" - DD: "];
        divetype = [divetype stringByAppendingString:[self.multiplierToSend stringValue]];
        self.lblDiveType.text = divetype;
        
    } else {
    
        JudgeScores *scores = [[JudgeScores alloc] init];
        
        self.lblDiveType.text = [scores GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    }
    
    NSString *diveNumberString = @"Score Dive ";
    
    diveNumberString = [diveNumberString stringByAppendingString:[NSString stringWithFormat:@"%d", self.diveNumber]];
    
    self.lblDiveNumber.text = diveNumberString;
    
}

-(BOOL)CalcScores {
    
    bool good;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // if not a dive list we need to write the dive record first then update the score
    if (self.listOrNot == 1) {
        
        if (self.diveNumber == 1) {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            
            //update record
            [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:self.diveCategory divetype:self.diveNameForDB divepos:self.divePosition  multiplier:self.multiplierToSend oldDiveNumber:@0 divenumber:diveNumberNumber];
            
            DiveList *list = [[DiveList alloc] init];
            [list MarkNoList:self.meetRecordID diverid:self.diverRecordID];
            
        } else {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            //convert the board size to a double
            double boardSizeDouble = [self.boardSize doubleValue];
            
            //create record
            [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:diveNumberNumber divecategory:self.diveCategory divetype:self.diveNameForDB diveposition:self.divePosition failed:@0 multiplier:self.multiplierToSend totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
        }
        
        // here we need to get a new MeetCollection
        MeetCollection *meets = [[MeetCollection alloc] init];
        self.meetInfo = nil;
        self.meetInfo = [meets GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
    }
    
    // then we write the actual score info
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

-(BOOL)updateFailedDive {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert = false;
    BOOL validDiveNumberIncrement = false;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // if not a dive list we need to write the dive record first then update the score
    if (self.listOrNot == 1) {
        
        if (self.diveNumber == 1) {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            
            //update record
            [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:self.diveCategory divetype:self.diveNameForDB divepos:self.divePosition  multiplier:self.multiplierToSend oldDiveNumber:diveNumberNumber divenumber:diveNumberNumber];
            
            DiveList *list = [[DiveList alloc] init];
            [list MarkNoList:self.meetRecordID diverid:self.diverRecordID];
            
        } else {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            //convert the board size to a double
            double boardSizeDouble = [self.boardSize doubleValue];
            
            //create record
            [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:diveNumberNumber divecategory:self.diveCategory divetype:self.diveNameForDB diveposition:self.divePosition failed:@0 multiplier:self.multiplierToSend totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
        }
    }
    
    validJudgeScoreInsert = [scores UpdateJudgeAllScoresFailed:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber failed:@1 totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    
    if (validJudgeScoreInsert) {
        //update the results table
        Results *result = [[Results alloc] init];
        validResultsInsert = [result UpdateOneResult:self.meetRecordID DiverID:self.diverRecordID DiveNumber:self.diveNumber score:@0];
    }
    
    if (validJudgeScoreInsert && validResultsInsert) {
    
        // increment the dive number in the dive_number table
        DiveNumber *number = [[DiveNumber alloc] init];
        validDiveNumberIncrement = [number UpdateDiveNumber:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    }
    
    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(void)DiverBoardSize {
    
    //DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    DiverBoardSize *board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    self.boardSize = board.firstSize;
    
}

@end
