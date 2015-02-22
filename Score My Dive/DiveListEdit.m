//
//  DiveListEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListEdit.h"
#import "HTAutocompleteManager.h"
#import "JudgeScores.h"
#import "DiveTypes.h"
#import "DiveCategory.h"
#import "DiveListEnter.h"
#import "DiveNumberCheck.h"

@interface DiveListEdit ()

@property (nonatomic) int diveGroupID;
@property (nonatomic) int diveID;
@property (nonatomic) int divePositionID;
@property (nonatomic) BOOL noWarning;

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;

@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic, strong) NSString *straight;
@property (nonatomic, strong) NSString *pike;
@property (nonatomic, strong) NSString *tuck;
@property (nonatomic, strong) NSString *free;
@property (nonatomic) int selectedPosition;

@property (nonatomic, strong) NSString *diveNumberEntered;
@property (nonatomic, strong) NSString *divePositionEntered;
@property (nonatomic, strong) NSArray *diveTextArray;

-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)fillText;
-(void)fillDiveNumber;
-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)DisableDivePositions;
-(void)GetDiveDOD;
-(void)UpdateJudgeScores;
-(void)CheckValidDiveFromText;
-(void)ConvertTextEntries;
-(void)showFirstWarning;

@end

@implementation DiveListEdit

#pragma viewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the default datasource for the autocomplete custom text boxes
    [HTAutocompleteTextField setDefaultAutocompleteDataSource:[HTAutocompleteManager sharedManager]];
    
    // attributes for controls
    self.txtDiveNumberEntry.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveNumberEntry.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveNumberEntry.layer.masksToBounds = NO;
    self.txtDiveNumberEntry.layer.shadowRadius = 4.0f;
    self.txtDiveNumberEntry.layer.shadowOpacity = .3;
    self.txtDiveNumberEntry.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtDiveNumberEntry.keyboardType = UIKeyboardTypeNumberPad;
    self.txtDiveNumberEntry.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.txtDiveNumberEntry.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDiveNumberEntry.delegate = self;
    [self.txtDiveNumberEntry addTarget:self action:@selector(CheckDDForDiveNumberEntry) forControlEvents:UIControlEventEditingChanged];
    
    self.txtDivePositionEntry.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDivePositionEntry.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDivePositionEntry.layer.masksToBounds = NO;
    self.txtDivePositionEntry.layer.shadowRadius = 4.0f;
    self.txtDivePositionEntry.layer.shadowOpacity = .3;
    self.txtDivePositionEntry.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtDivePositionEntry.autocompleteType = HTAutocompletePositions;
    self.txtDivePositionEntry.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.txtDivePositionEntry.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDivePositionEntry.delegate = self;
    [self.txtDivePositionEntry addTarget:self action:@selector(CheckDDForDivePositionEntry) forControlEvents:UIControlEventEditingChanged];
    
    // attributes for controls
    self.txtDiveGroup.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveGroup.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveGroup.layer.masksToBounds = NO;
    self.txtDiveGroup.layer.shadowRadius = 4.0f;
    self.txtDiveGroup.layer.shadowOpacity = .3;
    self.txtDiveGroup.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDive.layer.masksToBounds = NO;
    self.txtDive.layer.shadowRadius = 4.0f;
    self.txtDive.layer.shadowOpacity = .3;
    self.txtDive.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.SCPosition.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCPosition.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCPosition.layer.masksToBounds = NO;
    self.SCPosition.layer.shadowOpacity = .7;
    
    self.btnEnterDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterDive.layer.masksToBounds = NO;
    self.btnEnterDive.layer.shadowOpacity = .7;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        // color attributes for the segmented controls in iphone
        NSDictionary *segmentedControlTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateSelected];
        
        
    } else {
        
        // color and size attributes for the SC in iPad
        NSDictionary *segmentedControlTextAttributesiPad = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateSelected];
    }
    
    [self makeGroupPicker];
    [self makeDivePicker];
    
    // add a done button to the pickers
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    toolbar.barTintColor = [UIColor grayColor];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(dateSelectionDone:)];
    
    toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone, nil];
    barButtonDone.tintColor = [UIColor blackColor];
    self.txtDiveGroup.inputAccessoryView = toolbar;
    self.txtDive.inputAccessoryView = toolbar;
}

// done button a picker
-(void)dateSelectionDone:(id)sender {
    
    [self.txtDiveGroup resignFirstResponder];
    [self.txtDive resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fillText];
    [self fillDiveNumber];
    [self loadGroupPicker];
    [self showFirstWarning];
    
    // here we need to set the autocomplete type to the correct DiveTypes
    if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        self.txtDiveNumberEntry.autocompleteType = HTAutocompleteSpringboard;
    } else {
        self.txtDiveNumberEntry.autocompleteType = HTAutocompletePlatform;
    }
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
    
    NSNumber *segment = [NSNumber numberWithInt:(int)self.SCPosition.selectedSegmentIndex];
    [coder encodeObject:segment forKey:@"segment"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.boardSize forKey:@"boardSize"];
    [coder encodeObject:self.diveNumber forKey:@"diveNumber"];
    [coder encodeObject:self.oldDiveName forKey:@"oldDiveName"];
    [coder encodeObject:self.txtDiveGroup.text forKey:@"diveGroupText"];
    [coder encodeInt:self.diveGroupID forKey:@"diveGroupId"];
    [coder encodeObject:self.txtDive.text forKey:@"diveText"];
    [coder encodeInt:self.diveID forKey:@"diveId"];
    [coder encodeInt:self.divePositionID forKey:@"divePos"];
    [coder encodeObject:self.diveGroupArray forKey:@"diveGroupArray"];
    [coder encodeObject:self.diveArray forKey:@"diveArray"];
    [coder encodeObject:self.lblDivedd.text forKey:@"dd"];
    self.noWarning = YES;
    [coder encodeBool:self.noWarning forKey:@"warning"];
    
    [coder encodeObject:self.txtDiveNumberEntry.text forKey:@"diveNumEntry"];
    [coder encodeObject:self.txtDivePositionEntry.text forKey:@"divePosEntry"];
    [coder encodeObject:self.diveTextArray forKey:@"diveTextArray"];
    
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.SCPosition.selectedSegmentIndex = [[coder decodeObjectForKey:@"segment"] intValue];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
    self.diveNumber = [coder decodeObjectForKey:@"diveNumber"];
    self.oldDiveName = [coder decodeObjectForKey:@"oldDiveName"];
    self.txtDiveGroup.text = [coder decodeObjectForKey:@"diveGroupText"];
    if (self.txtDiveGroup.text.length == 0) {
        self.txtDiveGroup.text = @"";
    }
    self.diveGroupID = [coder decodeIntForKey:@"diveGroupId"];
    self.txtDive.text = [coder decodeObjectForKey:@"diveText"];
    if (self.txtDive.text.length == 0) {
        self.txtDive.text = @"";
    }
    self.diveID = [coder decodeIntForKey:@"diveId"];
    self.divePositionID = [coder decodeIntForKey:@"divePos"];
    self.diveGroupArray = [coder decodeObjectForKey:@"diveGroupArray"];
    self.diveArray = [coder decodeObjectForKey:@"diveArray"];
    self.lblDivedd.text = [coder decodeObjectForKey:@"dd"];
    self.noWarning = [coder decodeBoolForKey:@"warning"];
    
    self.txtDiveNumberEntry.text = [coder decodeObjectForKey:@"diveNumEntry"];
    if (self.txtDiveNumberEntry.text.length == 0) {
        self.txtDiveNumberEntry.text = @"";
    }
    self.txtDivePositionEntry.text = [coder decodeObjectForKey:@"divePosEntry"];
    if (self.txtDivePositionEntry.text.length == 0) {
        self.txtDivePositionEntry.text = @"";
    }
    self.diveTextArray = [coder decodeObjectForKey:@"diveTextArray"];
    
    [self loadDivePicker];
    [self DisableDivePositions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idEditListToEnterList"]) {
        
        DiveListEnter *enter = [segue destinationViewController];
        
        enter.meetInfo = self.meetInfo;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
    }
}

// hide the PickerView on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)makeGroupPicker {
    
    self.groupPicker = [[UIPickerView alloc] init];
    [self.groupPicker setBackgroundColor:[UIColor grayColor]];
    self.groupPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.groupPicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.groupPicker.layer.masksToBounds = NO;
    self.groupPicker.layer.shadowOpacity = .3;
    self.groupPicker.dataSource = self;
    self.groupPicker.delegate = self;
    self.txtDiveGroup.inputView = self.groupPicker;
    
}

-(void)makeDivePicker {
    
    self.divePicker = [[UIPickerView alloc] init];
    [self.divePicker setBackgroundColor:[UIColor grayColor]];
    self.divePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.divePicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.divePicker.layer.masksToBounds = NO;
    self.divePicker.layer.shadowOpacity = .3;
    self.divePicker.dataSource = self;
    self.divePicker.delegate = self;
    self.txtDive.inputView = self.divePicker;
    
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
        self.txtDiveGroup.text = @"";
        [self.groupPicker reloadAllComponents];
        self.txtDive.text = @"";
        [self.divePicker reloadAllComponents];
        [self.SCPosition setEnabled:NO];
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

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView ==self.groupPicker) {
        return self.diveGroupArray.count;
    } else {
        return self.diveArray.count;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        // if they choose anything from the pickers we need to clear the text on the regular text fields
        self.txtDiveNumberEntry.text = @"";
        self.txtDivePositionEntry.text = @"";
        [self.SCPosition setEnabled:YES];
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [[self.diveArray objectAtIndex:0] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[[self.diveArray objectAtIndex:0] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [[self.diveArray objectAtIndex:0] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[[self.diveArray objectAtIndex:0] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
        // this will disable dive position choices based on cat, board, and dive type
        [self DisableDivePositions];
        
        // then this will set the divedod label to the correct dod
        [self GetDiveDOD];
        
        return [self.diveGroupArray[row]objectAtIndex:1];
        
    } else {
        
        
        // if they choose anything from the pickers we need to clear the text on the regular text fields
        self.txtDiveNumberEntry.text = @"";
        self.txtDivePositionEntry.text = @"";
        [self.SCPosition setEnabled:YES];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            // assign the first item in array to text box right away, so user doesn't have to
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            return diveText;
            
        } else {
            
            // assign the first item in array to text box right away, so user doesn't have to
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            //return [self.diveArray[row]objectAtIndex:4];
            return diveText;
            
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        // empty and reload the type picker after a category has been changed
        self.diveArray= nil;
        [self.divePicker reloadAllComponents];
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
    } else {
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
        } else {
            
            // lets add the dive number to the dive name
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
        }
    }
    
    // this will disable dive position choices based on cat, board, and dive type
    [self DisableDivePositions];
    
    // then this will set the divedod label to the correct dod
    [self GetDiveDOD];
}

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender {
    
    switch (self.SCPosition.selectedSegmentIndex) {
        case 0:
            self.divePositionID = 0;
            self.lblDivedd.text = self.straight;
            break;
        case 1:
            self.divePositionID = 1;
            self.lblDivedd.text = self.pike;
            break;
        case 2:
            self.divePositionID = 2;
            self.lblDivedd.text = self.tuck;
            break;
        case 3:
            self.divePositionID = 3;
            self.lblDivedd.text = self.free;
            break;
    }
}

- (IBAction)btnEnterDive:(id)sender {
    
    // see if user is using the txtfields or the pickers
    if (self.txtDiveNumberEntry.text.length > 0) {
        // now make sure there is text in the position field
        if (self.txtDivePositionEntry.text.length > 0) {
            
            // now make sure the dive is legit
            [self CheckValidDiveFromText];
            if (self.diveTextArray.count > 0) {
                
                [self ConvertTextEntries];
                [self UpdateJudgeScores];
                
                [self.delegate editDiveListWasFinished];
                
                [self performSegueWithIdentifier:@"idEditListToEnterList" sender:self];
                
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
                                                            message:@"You also need to pick a Dive Position"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    } else {
    
        self.selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
        
        if (self.diveGroupID != 0 && self.diveID != 0 && self.selectedPosition >= 0) {
            
            [self UpdateJudgeScores];
            
            [self.delegate editDiveListWasFinished];
            
            [self performSegueWithIdentifier:@"idEditListToEnterList" sender:self];
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"Please make sure you've picked a dive and a valid position"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    }
}

#pragma private methods

-(void)showFirstWarning {
    
    if (!self.noWarning) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Heads up!"
                                                        message:@"If you edit a dive that already has a score, you will want to update the dive score in the \"Score Meet\" Screen."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
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
    // if entered in the text box
    if (self.txtDiveNumberEntry.text.length > 0) {
        
        diveName = [self.diveTextArray objectAtIndex:1];
        diveNameForDB = [NSString stringWithFormat:@"%d", self.diveID];
        diveNameForDB = [diveNameForDB stringByAppendingString:@" - "];
        diveNameForDB = [diveNameForDB stringByAppendingString:diveName];
        
        // if used the spinner
    } else {
        
        diveNameForDB = self.txtDive.text;
        
    }
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    multiplier = [formatString numberFromString:multi];
    
    // if this is the first dive we are just updating the first record we wrote
    [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:diveCategory divetype:diveNameForDB divepos:divePosition  multiplier:multiplier
                    oldDiveNumber:self.diveNumber divenumber:self.diveNumber];
    
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

-(void)CheckValidDiveFromText {
    
    DiveNumberCheck *check = [[DiveNumberCheck alloc] init];
    self.diveNumberEntered = self.txtDiveNumberEntry.text;
    self.divePositionEntered = self.txtDivePositionEntry.text;
    
    self.diveTextArray = [check CheckDiveNumberInput:self.diveNumberEntered Position:self.divePositionEntered BoardSize:self.boardSize];
}

-(void)loadGroupPicker {
    
    if (self.diveGroupArray != nil) {
        self.diveGroupArray = nil;
    }
    
    if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
        DiveCategory *cat = [[DiveCategory alloc] init];
        self.diveGroupArray = [cat GetSpringboardCategories];
        
    }
    else {
        
        DiveCategory *cat = [[DiveCategory alloc] init];
        self.diveGroupArray = [cat GetPlatformCategories];
        
    }
    
}

-(void)loadDivePicker {
    
    if (self.diveArray != nil) {
        self.diveArray = nil;
    }
    
    // call the class to decide which dives get loaded based on category and board size
    DiveTypes *types = [[DiveTypes alloc] init];
    self.diveArray = [types LoadDivePicker:self.diveGroupID BoardSize:self.boardSize];
    
}

-(void)fillText {
    
    self.lblOldDiveName.text = self.oldDiveName;
    
}

-(void)fillDiveNumber {
    
    NSString *diveNum = @"Edit Dive ";
    
    diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.diveNumber]];
    self.lblDiveNumber.text = diveNum;
}

-(void)DisableDivePositions {
    
//    NSArray *dods = [[NSArray alloc] init];
    
    if (self.txtDive.text.length > 0) {
        
        // set the segmented control back to enabled
        [self.SCPosition setEnabled:YES];
        
        // lets get the valid dods based on group, type and board size
        DiveTypes *types = [[DiveTypes alloc] init];
        NSArray *dods = [types GetAllDiveDODs:self.diveGroupID DiveTypeId:self.diveID BoardType:self.boardSize];
            
        if (dods.count > 0) {
        
            // now put those into a NSNumber variable
            self.straight = [[dods objectAtIndex:0] objectAtIndex:0];
            self.pike = [[dods objectAtIndex:0] objectAtIndex:1];
            self.tuck = [[dods objectAtIndex:0] objectAtIndex:2];
            self.free = [[dods objectAtIndex:0] objectAtIndex:3];
            
            if ([self.straight isEqualToString:@"0.0"]) {
                [self.SCPosition setEnabled:NO forSegmentAtIndex:0];
            } else {
                [self.SCPosition setEnabled:YES forSegmentAtIndex:0];
            }
            
            if ([self.pike isEqualToString:@"0.0"]) {
                [self.SCPosition setEnabled:NO forSegmentAtIndex:1];
            } else {
                [self.SCPosition setEnabled:YES forSegmentAtIndex:1];
            }
            
            if ([self.tuck isEqualToString:@"0.0"]) {
                [self.SCPosition setEnabled:NO forSegmentAtIndex:2];
            } else {
                [self.SCPosition setEnabled:YES forSegmentAtIndex:2];
            }
            
            if ([self.free isEqualToString:@"0.0"]) {
                [self.SCPosition setEnabled:NO forSegmentAtIndex:3];
            } else {
                [self.SCPosition setEnabled:YES forSegmentAtIndex:3];
            }
            
        } else {
            // disable the segmented control until a dive has been chosen
            [self.SCPosition setEnabled:NO];
        }
    } else {
        
        // disable the segmented control until a dive has been chosen
        [self.SCPosition setEnabled:NO];
    }
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
        
    } else if (self.txtDiveGroup.text.length > 0) {  // or on the pickers and SC
        
        switch (self.SCPosition.selectedSegmentIndex) {
            case 0:
                self.divePositionID = 0;
                self.lblDivedd.text = self.straight;
                break;
            case 1:
                self.divePositionID = 1;
                self.lblDivedd.text = self.pike;
                break;
            case 2:
                self.divePositionID = 2;
                self.lblDivedd.text = self.tuck;
                break;
            case 3:
                self.divePositionID = 3;
                self.lblDivedd.text = self.free;
                break;
        }
    }
}

#pragma private methods









































@end
