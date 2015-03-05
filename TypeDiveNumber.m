//
//  TypeDiveNumber.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/21/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "TypeDiveNumber.h"
#import "HTAutocompleteManager.h"
#import "DiveNumberCheck.h"
#import "JudgeScores.h"
#import "DiveList.h"
#import "DiveListEnter.h"

@interface TypeDiveNumber ()

@property (nonatomic, strong) NSString *diveNumberEntered;
@property (nonatomic, strong) NSString *divePositionEntered;
@property (nonatomic, strong) NSArray *diveTextArray;
@property (nonatomic) int selectedPosition;

-(void)CheckDDForDiveNumberEntry;
-(void)CheckDDForDivePositionEntry;
-(void)GetDiveDOD;
-(void)CheckValidDiveFromText;
-(void)ConvertTextEntries;
-(void)UpdateJudgeScores;
-(void)updateListStarted;
-(void)editDive;

@end

@implementation TypeDiveNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the default datasource for the autocomplete custom text boxes
    [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
    
    self.backgroundPanel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel.layer.masksToBounds = NO;
    self.backgroundPanel.layer.shadowOpacity = 1.0;
    
    self.txtDiveNumberEntry.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtDiveNumberEntry.keyboardType = UIKeyboardTypeNumberPad;
    self.txtDiveNumberEntry.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.txtDiveNumberEntry.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDiveNumberEntry.delegate = self;
    [self.txtDiveNumberEntry addTarget:self action:@selector(CheckDDForDiveNumberEntry) forControlEvents:UIControlEventEditingChanged];
    
    self.txtDivePositionEntry.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtDivePositionEntry.autocompleteType = HTAutocompletePositions;
    self.txtDivePositionEntry.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.txtDivePositionEntry.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDivePositionEntry.delegate = self;
    [self.txtDivePositionEntry addTarget:self action:@selector(CheckDDForDivePositionEntry) forControlEvents:UIControlEventEditingChanged];
    
    self.popoverPresentationController.backgroundColor = [UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1];
    
    // we only want the keyboard popping up right away on the ipad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.txtDiveNumberEntry becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//keps the user from entering text in the txtfield
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // we need to see which field is getting entry, only the number and position should use keyboard
    // then we will clear the text of the pickers if text is entered and vice-versa
    if (textField == self.txtDiveNumberEntry || textField == self.txtDivePositionEntry) {
        
        // lets the user use the back key
        if (!string.length)
            return YES;
        
        // only lets the user enter numeric digits and only 4 total
        if (textField == self.txtDiveNumberEntry) {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^\\d";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
            if (numberOfMatches == 0) return NO;
            
            // regex {4} was not working, had to cheese out and do this
            if (textField.text.length >= 4) {
                return NO;
            }
        }
        
        // only lets the user enter A, B, C, or D
        if (textField == self.txtDivePositionEntry) {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^[A-D]$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
            if (numberOfMatches == 0) return NO;
        }
        
        // clears out the picker text if user uses the txtfields
        self.diveGroupID = 0;
        self.diveID = 0;
        self.divePositionID = 0;
        self.lblDivedd.text = @"0.0";
        
        return YES;
        
    } else {
        
        return NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.txtDiveNumberEntry) {
        [self.txtDivePositionEntry becomeFirstResponder];
    }
    if (textField == self.txtDivePositionEntry) {
        [self.txtDivePositionEntry resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)btnEnter:(id)sender {
    
    // Make sure both fields are entered
    if (self.txtDiveNumberEntry.text.length > 0 && self.txtDivePositionEntry.text.length > 0) {
        // now make sure the dive is legit
        [self CheckValidDiveFromText];
        if (![self.lblDivedd.text isEqual:@"0.0"]) {
            
            [self ConvertTextEntries];
            
            // see who called depends on how we update or create a judge scores
            if (self.whoCalled == 1) {
                [self UpdateJudgeScores];
                
                // start the list
                if ([self.onDiveNumber isEqualToNumber:@1]) {
                    
                    [self updateListStarted];
                }
            } else if (self.whoCalled == 2) {
                [self editDive];
            } 
            
            // call the delegate method to reload the class that called it and pop it off
            // this lets the class know who called them
            // 1 is the DiveListEnter
            // 2 is the DiveListEdit
            // 3 is the DiveEnter
            if (self.whoCalled == 1) {
                [self.delegate typeDiveNumberWasFinished];
                
                // using the custome class dismiss the popover after passing instance of the class
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    [self.controller dismissPopoverAnimated:YES];
                // else just dismiss the ViewController
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            // this calls the delegate and then goes right back to diveListEnter
            } else if (self.whoCalled == 2) {
                [self.delegate typeDiveNumberWasFinished];
                
                // using the custome class dismiss the popover after passing instance of the class
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    [self.controller dismissPopoverAnimated:YES];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    //[self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                }
            } else {
                // diveEnterDelegate - this may need to go right to score
            }

        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"That is not a valid dive! Make sure the Dive DD is more than 0.0"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"You have to enter a Dive Number and Position"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

#pragma private methods
// we are using these as selector methods on the textfield to update the divedd when appropriate
-(void)CheckDDForDiveNumberEntry {
    
    if (self.txtDiveNumberEntry.text.length >= 3 && self.txtDivePositionEntry.text.length > 0) {
        [self GetDiveDOD];
    }
    
    if (self.txtDiveNumberEntry.text.length == 0) {
        self.lblDivedd.text = @"0.0";
    }
}

-(void)CheckDDForDivePositionEntry {
    
    if (self.txtDiveNumberEntry.text.length >= 3 && self.txtDivePositionEntry.text.length > 0) {
        [self GetDiveDOD];
    }
    
    if (self.txtDivePositionEntry.text.length == 0) {
        self.lblDivedd.text = @"0.0";
    }
}

-(void)GetDiveDOD {
    
    //test dd on the txtfields
    if (self.txtDiveNumberEntry.text.length > 0 || self.txtDivePositionEntry.text.length > 0) {
        
        DiveNumberCheck *check = [[DiveNumberCheck alloc] init];
        self.diveNumberEntered = self.txtDiveNumberEntry.text;
        self.divePositionEntered = self.txtDivePositionEntry.text;
        
        self.diveTextArray = [check CheckDiveNumberInput:self.diveNumberEntered Position:self.divePositionEntered BoardSize:self.boardSize];
        
        if (self.diveTextArray.count > 0) {
            self.lblDivedd.text = [self.diveTextArray objectAtIndex:2];
        } else {
            self.lblDivedd.text = @"0.0";
        }
    }
}

-(void)CheckValidDiveFromText {
    
    DiveNumberCheck *check = [[DiveNumberCheck alloc] init];
    self.diveNumberEntered = self.txtDiveNumberEntry.text;
    self.divePositionEntered = self.txtDivePositionEntry.text;
    
    self.diveTextArray = [check CheckDiveNumberInput:self.diveNumberEntered Position:self.divePositionEntered BoardSize:self.boardSize];
}

// this will take the totals entered in the textbox and update the JudgeScoring variables we need
-(void)ConvertTextEntries {
    
    // this decides which dive group we are using from the substring of the diveNumberText
    int testString = [[self.txtDiveNumberEntry.text substringToIndex:1] intValue];
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        
        switch (testString) {
            case 1:
                self.diveGroupID = 1;
                break;
            case 2:
                self.diveGroupID = 2;
                break;
            case 3:
                self.diveGroupID = 3;
                break;
            case 4:
                self.diveGroupID = 4;
                break;
            case 5:
                self.diveGroupID = 5;
                break;
        }
        
    } else {
        
        switch (testString) {
            case 1:
                self.diveGroupID = 1;
                break;
            case 2:
                self.diveGroupID = 2;
                break;
            case 3:
                self.diveGroupID = 3;
                break;
            case 4:
                self.diveGroupID = 4;
                break;
            case 5:
                self.diveGroupID = 5;
                break;
            case 6:
                self.diveGroupID = 6;
                break;
        }
    }
    
    // convert the diveID to the global one the JudgeScore method uses
    self.diveID = [self.txtDiveNumberEntry.text intValue];
    
    // convert the divePosition text
    if ([self.txtDivePositionEntry.text isEqualToString:@"A"]) {
        self.selectedPosition = 0;
    } else if ([self.txtDivePositionEntry.text isEqualToString:@"B"]) {
        self.selectedPosition = 1;
    } else if ([self.txtDivePositionEntry.text isEqualToString:@"C"]) {
        self.selectedPosition = 2;
    } else {
        self.selectedPosition = 3;
    }
}

-(void)UpdateJudgeScores {
    
    NSString *diveCategory;
    NSString *divePosition;
    NSString *diveName;
    NSString *diveNameForDB;
    NSNumber *multiplier;
    //int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Forward Dive";
                break;
            case 2:
                diveCategory = @"Back Dive";
                break;
            case 3:
                diveCategory = @"Reverse Dive";
                break;
            case 4:
                diveCategory = @"Inward Dive";
                break;
            case 5:
                diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Front Platform Dive";
                break;
            case 2:
                diveCategory = @"Back Platform Dive";
                break;
            case 3:
                diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (self.selectedPosition) {
        case 0:
            divePosition = @"A - Straight";
            break;
        case 1:
            divePosition = @"B - Pike";
            break;
        case 2:
            divePosition = @"C - Tuck";
            break;
        case 3:
            divePosition = @"D - Free";
            break;
    }
    
    // get the dive name and then append it to the diveid
    // when entered in the text box
    if (self.txtDiveNumberEntry.text.length > 0) {
        
        diveName = [self.diveTextArray objectAtIndex:1];
        diveNameForDB = [NSString stringWithFormat:@"%d", self.diveID];
        diveNameForDB = [diveNameForDB stringByAppendingString:@" - "];
        diveNameForDB = [diveNameForDB stringByAppendingString:diveName];
    }

    // use this dive number for the first entry
    NSNumber *firstDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber];
    
    // create a new dive number, just increment the old number
    NSNumber *newDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    multiplier = [formatString numberFromString:multi];
    
    // get a double value from the boardSize
    double boardSizeDouble = [self.boardSize doubleValue];
    
    if ([newDiveNumber isEqualToNumber:@1]) {
        
        // if this is the first dive we are just updating the first record we wrote
        [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:diveCategory divetype:diveNameForDB divepos:divePosition  multiplier:multiplier
                        oldDiveNumber:firstDiveNumber divenumber:self.onDiveNumber];
        
    } else {
        // create a new record
        [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:newDiveNumber divecategory:diveCategory divetype:diveNameForDB diveposition:divePosition failed:@0 multiplier:multiplier totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    }
}

-(void)editDive {
    
    NSString *diveCategory;
    NSString *divePosition;
    NSString *diveName;
    NSString *diveNameForDB;
    NSNumber *multiplier;
    //int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Forward Dive";
                break;
            case 2:
                diveCategory = @"Back Dive";
                break;
            case 3:
                diveCategory = @"Reverse Dive";
                break;
            case 4:
                diveCategory = @"Inward Dive";
                break;
            case 5:
                diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Front Platform Dive";
                break;
            case 2:
                diveCategory = @"Back Platform Dive";
                break;
            case 3:
                diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (self.selectedPosition) {
        case 0:
            divePosition = @"A - Straight";
            break;
        case 1:
            divePosition = @"B - Pike";
            break;
        case 2:
            divePosition = @"C - Tuck";
            break;
        case 3:
            divePosition = @"D - Free";
            break;
    }
    
    // get the dive name and then append it to the diveid
    // if entered in the text box
    if (self.txtDiveNumberEntry.text.length > 0) {
        
        diveName = [self.diveTextArray objectAtIndex:1];
        diveNameForDB = [NSString stringWithFormat:@"%d", self.diveID];
        diveNameForDB = [diveNameForDB stringByAppendingString:@" - "];
        diveNameForDB = [diveNameForDB stringByAppendingString:diveName];
    }

    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    multiplier = [formatString numberFromString:multi];
    
    // if this is the first dive we are just updating the first record we wrote
    [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:diveCategory divetype:diveNameForDB divepos:divePosition  multiplier:multiplier
                    oldDiveNumber:self.onDiveNumber divenumber:self.onDiveNumber];
    
}

-(void)updateListStarted {
    
    DiveList *list = [[DiveList alloc] init];
    
    [list updateListStarted:self.meetRecordID diverid:self.diverRecordID];
}

@end
