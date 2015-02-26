//
//  TypeDiveNumberEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/24/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "TypeDiveNumberEnter.h"
#import "HTAutocompleteManager.h"
#import "DiveNumberCheck.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "DiveListScore.h"
#import "DiveListFinalScore.h"

@interface TypeDiveNumberEnter ()

@property (nonatomic, strong) NSString *diveNumberEntered;
@property (nonatomic, strong) NSString *divePositionEntered;
@property (nonatomic, strong) NSArray *diveTextArray;
@property (nonatomic) int selectedPosition;

// properties to send to the diveScore screen
@property (nonatomic, strong) NSString *diveCategory;
@property (nonatomic, strong) NSString *divePosition;
@property (nonatomic, strong) NSString *diveNameForDB;
@property (nonatomic, strong) NSNumber *multiplierToSend;

-(void)UpdateDiveInfoToSend;
-(void)CheckDDForDiveNumberEntry;
-(void)CheckDDForDivePositionEntry;
-(void)GetDiveDOD;
-(void)CheckValidDiveFromText;
-(void)ConvertTextEntries;

@end

@implementation TypeDiveNumberEnter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the default datasource for the autocomplete custom text boxes
    [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
    
    self.backgroundLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundLabel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundLabel.layer.masksToBounds = NO;
    self.backgroundLabel.layer.shadowOpacity = 1.0;
    
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
    
    // here we need to set the autocomplete type to the correct DiveTypes
    if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        self.txtDiveNumberEntry.autocompleteType = HTAutocompleteSpringboard;
    } else {
        self.txtDiveNumberEntry.autocompleteType = HTAutocompletePlatform;
    }
    
    [self.txtDiveNumberEntry becomeFirstResponder];

}

// restore state because Apple doesn't know how to write a modern OS
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeInt:self.divePositionID forKey:@"divePos"];
    [coder encodeObject:self.lblDivedd.text forKey:@"dd"];
    [coder encodeObject:self.txtDiveNumberEntry.text forKey:@"diveNumEntry"];
    [coder encodeObject:self.txtDivePositionEntry.text forKey:@"divePosEntry"];
    [coder encodeObject:self.diveTextArray forKey:@"diveTextArray"];
    [coder encodeObject:self.boardSize forKey:@"board"];
    [coder encodeInt:self.listOrNot forKey:@"listOrNot"];
    [coder encodeObject:self.onDiveNumber forKey:@"onDiveNumber"];
    
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.diveGroupID = [coder decodeIntForKey:@"diveGroupId"];
    self.diveID = [coder decodeIntForKey:@"diveId"];
    self.divePositionID = [coder decodeIntForKey:@"divePos"];
    self.lblDivedd.text = [coder decodeObjectForKey:@"dd"];
    
    self.txtDiveNumberEntry.text = [coder decodeObjectForKey:@"diveNumEntry"];
    if (self.txtDiveNumberEntry.text.length == 0) {
        self.txtDiveNumberEntry.text = @"";
    }
    self.txtDivePositionEntry.text = [coder decodeObjectForKey:@"divePosEntry"];
    if (self.txtDivePositionEntry.text.length == 0) {
        self.txtDivePositionEntry.text = @"";
    }
    self.diveTextArray = [coder decodeObjectForKey:@"diveTextArray"];
    self.boardSize = [coder decodeObjectForKey:@"board"];
    self.listOrNot = [coder decodeIntForKey:@"listOrNot"];
    self.onDiveNumber = [coder decodeObjectForKey:@"onDiveNumber"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the diveListScore
    if ([segue.identifier isEqualToString:@"SegueTypeEnterToJudge"]) {
        
        DiveListScore *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.diveCategory = self.diveCategory;
        score.divePosition = self.divePosition;
        score.diveNameForDB = self.diveNameForDB;
        score.multiplierToSend = self.multiplierToSend;
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListFinalScore
    if ([segue.identifier isEqualToString:@"SegueTypeEnterToTotal"]) {
        
        DiveListFinalScore *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.diveCategory = self.diveCategory;
        score.divePosition = self.divePosition;
        score.diveNameForDB = self.diveNameForDB;
        score.multiplierToSend = self.multiplierToSend;
        score.meetInfo = self.meetInfo;
    }
}

//kepes the user from entering text in the txtfield
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

- (IBAction)btnEnterScores:(id)sender {
    
    // Make sure both fields are entered
    if (self.txtDiveNumberEntry.text.length > 0 && self.txtDivePositionEntry.text.length > 0) {
        // now make sure the dive is legit
        [self CheckValidDiveFromText];
        if (![self.lblDivedd.text isEqual:@"0.0"]) {
            
            [self ConvertTextEntries];
            
            [self ConvertTextEntries];
            [self UpdateDiveInfoToSend];
            [self performSegueWithIdentifier:@"SegueTypeEnterToJudge" sender:self];
            
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

- (IBAction)btnEnterTotalScores:(id)sender {
    
    // Make sure both fields are entered
    if (self.txtDiveNumberEntry.text.length > 0 && self.txtDivePositionEntry.text.length > 0) {
        // now make sure the dive is legit
        [self CheckValidDiveFromText];
        if (![self.lblDivedd.text isEqual:@"0.0"]) {
            
            [self ConvertTextEntries];
            [self UpdateDiveInfoToSend];
            [self performSegueWithIdentifier:@"SegueTypeEnterToTotal" sender:self];
            
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

#pragma Private methods

-(void)UpdateDiveInfoToSend {
    
    NSString *diveName;
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                self.diveCategory = @"Forward Dive";
                break;
            case 2:
                self.diveCategory = @"Back Dive";
                break;
            case 3:
                self.diveCategory = @"Reverse Dive";
                break;
            case 4:
                self.diveCategory = @"Inward Dive";
                break;
            case 5:
                self.diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                self.diveCategory = @"Front Platform Dive";
                break;
            case 2:
                self.diveCategory = @"Back Platform Dive";
                break;
            case 3:
                self.diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                self.diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                self.diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                self.diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (self.selectedPosition) {
        case 0:
            self.divePosition = @"A - Straight";
            break;
        case 1:
            self.divePosition = @"B - Pike";
            break;
        case 2:
            self.divePosition = @"C - Tuck";
            break;
        case 3:
            self.divePosition = @"D - Free";
            break;
    }
    
    // get the dive name and then append it to the diveid
    diveName = [self.diveTextArray objectAtIndex:1];
    self.diveNameForDB = [NSString stringWithFormat:@"%d", self.diveID];
    self.diveNameForDB = [self.diveNameForDB stringByAppendingString:@" - "];
    self.diveNameForDB = [self.diveNameForDB stringByAppendingString:diveName];
        
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    self.multiplierToSend = [formatString numberFromString:multi];
    
}

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

@end
