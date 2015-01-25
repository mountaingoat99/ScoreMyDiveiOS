//
//  DiveListEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListEnter.h"
#import "HTAutocompleteManager.h"
#import "Diver.h"
#import "Meet.h"
#import "DiveTotal.h"
#import "DiverBoardSize.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "DiveNumber.h"
#import "JudgeScores.h"
#import "DiveListEdit.h"
#import "DiveListChoose.h"
#import "DiveList.h"
#import "ChooseDiver.h"
#import "DiveNumberCheck.h"

@interface DiveListEnter ()

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) NSNumber *onDiveNumber;
@property (nonatomic) int maxDiveNumber;
@property (nonatomic, strong) NSNumber *editDiveNumber;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic, strong) NSString *straight;
@property (nonatomic, strong) NSString *pike;
@property (nonatomic, strong) NSString *tuck;
@property (nonatomic, strong) NSString *free;
@property (nonatomic) BOOL allDivesEntered;
@property (nonatomic, strong) NSString *oldDiveName;
@property (nonatomic) int diveTotal;
@property (nonatomic) int selectedPosition;

@property (nonatomic, strong) NSString *diveNumberEntered;
@property (nonatomic, strong) NSString *divePositionEntered;
@property (nonatomic, strong) NSArray *diveTextArray;

-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)fillText;
-(void)DiverBoardSize;
-(void)fillDiveNumber;
-(void)fillDiveInfo;
-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)hideInitialControls;
-(void)DisableDivePositions;
-(void)GetDiveDOD;
-(void)UpdateJudgeScores;
-(void)CheckValidDiveFromText;
-(void)ConvertTextEntries;
-(void)resetValues;
-(void)updateButtonText;
-(void)HideAllControls;
-(void)updateListFilled;
-(void)updateListStarted;

@end

@implementation DiveListEnter

#pragma ViewController Events

-(void)viewDidLoad {
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
    
    self.txtDiveGroup.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveGroup.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveGroup.layer.masksToBounds = NO;
    self.txtDiveGroup.layer.shadowRadius = 4.0f;
    self.txtDiveGroup.layer.shadowOpacity = .3;
    self.txtDiveGroup.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDiveGroup.delegate = self;
    //[self.txtDiveGroup addTarget:self action:@selector(CheckDDForDiveGroup) forControlEvents:UIControlEventAllEvents];
    
    self.txtDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDive.layer.masksToBounds = NO;
    self.txtDive.layer.shadowRadius = 4.0f;
    self.txtDive.layer.shadowOpacity = .3;
    self.txtDive.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDive.delegate = self;
    //[self.txtDive addTarget:self action:@selector(CheckDDForDive) forControlEvents:UIControlEventAllEvents];
    
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
    
    // sets up the following delegate method to disable horizontal scrolling
    // don't forget to declare the UIScrollViewDelegate in the .h file
    self.scrollView.delegate = self;
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // lets hide some controls
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self loadGroupPicker];
    [self fillDiveInfo];
    [self updateButtonText];
    [self DisableDivePositions];
    
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
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeObject:self.txtDiveGroup.text forKey:@"diveGroupText"];
    [coder encodeInt:self.diveGroupID forKey:@"diveGroupId"];
    [coder encodeObject:self.txtDive.text forKey:@"diveText"];
    [coder encodeInt:self.diveID forKey:@"diveId"];
    [coder encodeInt:self.divePositionID forKey:@"divePos"];
    [coder encodeObject:self.diveGroupArray forKey:@"diveGroupArray"];
    [coder encodeObject:self.diveArray forKey:@"diveArray"];
    [coder encodeObject:self.lblDivedd.text forKey:@"dd"];
    
    [coder encodeObject:self.txtDiveNumberEntry.text forKey:@"diveNumEntry"];
    [coder encodeObject:self.txtDivePositionEntry.text forKey:@"divePosEntry"];
    [coder encodeObject:self.diveTextArray forKey:@"diveTextArray"];
    
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.SCPosition.selectedSegmentIndex = [[coder decodeObjectForKey:@"segment"] intValue];
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
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

// stops horitontal scrolling
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToEnterDiveList:(UIStoryboardSegue*)sender {
    
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the diveListEdit
    if ([segue.identifier isEqualToString:@"idSegueDiveListEdit"]) {
        // send the variables to edit a JudgesDive
        DiveListEdit *edit = [segue destinationViewController];
        
        //set the delegate here
        edit.delegate = self;
        
        edit.meetInfo = self.meetInfo;
        edit.meetRecordID = self.meetRecordID;
        edit.diverRecordID = self.diverRecordID;
        edit.boardSize = self.boardSize;
        edit.diveNumber = self.editDiveNumber;
        edit.oldDiveName = self.oldDiveName;
    }
    
    if([segue.identifier isEqualToString:@"idSegueDiveListChoose"]) {
        
        DiveListChoose *choose = [segue destinationViewController];
        choose.meetRecordID = self.meetRecordID;
        choose.diverRecordID = self.diverRecordID;
    }
    
    if([segue.identifier isEqualToString:@"idSegueListToChooseDiver"]) {
        
        ChooseDiver *choose = [segue destinationViewController];
        choose.meetRecordID = self.meetRecordID;
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
        
            // lets add the dive number to the dive name
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
    
    if (self.allDivesEntered) {
        
        [self performSegueWithIdentifier:@"idSegueDiveListChoose" sender:self];
        
    } else {
        
        // see if user is using the txtfields or the pickers
        if (self.txtDiveNumberEntry.text.length > 0) {
            // now make sure there is text in the position field
            if (self.txtDivePositionEntry.text.length > 0) {
                
                // now make sure the dive is legit
                [self CheckValidDiveFromText];
                if (self.diveTextArray.count > 0) {
                
                    [self ConvertTextEntries];
                    [self UpdateJudgeScores];
                    
                    // start the list
                    if ([self.onDiveNumber isEqualToNumber:@1]) {
                        
                        [self updateListStarted];
                    }
                    
                    // once we update the score we need to re-fill the dive number
                    // refill the info and reset the fields
                    [self fillDiveNumber];
                    [self fillDiveInfo];
                    [self updateButtonText];
                    [self resetValues];
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
            
                // start the list
                if ([self.onDiveNumber isEqualToNumber:@1]) {
                
                    [self updateListStarted];
                }

                // once we update the score we need to re-fill the dive number
                // refill the info and reset the fields
                [self fillDiveNumber];
                [self fillDiveInfo];
                [self updateButtonText];
                [self resetValues];
            
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
}

- (IBAction)lblOptionsClick:(id)sender {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Edit a Dive"
                                                    message:@"To edit a Dive-List entry, just long-press the dive-name that you want to edit."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
}

- (IBAction)Dive1EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive1 edit Test");
        self.editDiveNumber = @1;
        self.oldDiveName = self.lblDive1.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive2EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive2 edit Test");
        self.editDiveNumber = @2;
        self.oldDiveName = self.lblDive2.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive3EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive3 edit Test");
        self.editDiveNumber = @3;
        self.oldDiveName = self.lblDive3.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive4EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive4 edit Test");
        self.editDiveNumber = @4;
        self.oldDiveName = self.lblDive4.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive5EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive5 edit Test");
        self.editDiveNumber = @5;
        self.oldDiveName = self.lblDive5.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive6EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive6 edit Test");
        self.editDiveNumber = @6;
        self.oldDiveName = self.lblDive6.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive7EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive7 edit Test");
        self.editDiveNumber = @7;
        self.oldDiveName = self.lblDive7.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive8EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive8 edit Test");
        self.editDiveNumber = @8;
        self.oldDiveName = self.lblDive8.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive9EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive9 edit Test");
        self.editDiveNumber = @9;
        self.oldDiveName = self.lblDive9.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive10EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive10 edit Test");
        self.editDiveNumber = @10;
        self.oldDiveName = self.lblDive10.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive11EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive11 edit Test");
        self.editDiveNumber = @11;
        self.oldDiveName = self.lblDive11.text;
        [self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

// delegate method to update the info after the dive edit is popped off
-(void)editDiveListWasFinished {
    
    [self fillDiveNumber];
    [self fillDiveInfo];
    [self updateButtonText];
    [self resetValues];
}


#pragma private methods

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
    
    // meet info
//    Meet *meet = [[Meet alloc] init];
    Meet *meet = [self.meetInfo objectAtIndex:0];
    self.lblMeetName.text = meet.meetName;
    
    // diver info
//    Diver *diver = [[Diver alloc] init];
    Diver *diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    self.lblDiverName.text = diver.Name;
    
}

-(void)DiverBoardSize {
    
//    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    DiverBoardSize *board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    self.boardSize = board.firstSize;
    
}

-(void)fillDiveNumber {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    self.maxDiveNumber = [scores GetMaxDiveNumber:self.meetRecordID diverid:self.diverRecordID];
    
    // we need to see what the dive total is first and set it for the whole class
//    DiveTotal *total = [[DiveTotal alloc] init];
    DiveTotal *total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = [total.diveTotal intValue];
    
    if (self.maxDiveNumber != self.diveTotal) {
        
        NSString *diveNum = @"Dive ";
        // here we will set the value for the whole class to use
        self.onDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
        
        diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.onDiveNumber]];
        self.lblDiveNumber.text = diveNum;
    } else {
        
        self.lblDiveNumber.text = @"Begin Scoring";
    }
    
}

-(void)DisableDivePositions {
    
    //NSArray *dods = [[NSArray alloc] init];
    
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

//-(void)CheckDDForDiveGroup {
//    
//    if (self.txtDiveGroup.text.length > 0 && self.txtDive.text.length > 0) {
//        // this will disable dive position choices based on cat, board, and dive type
//        [self DisableDivePositions];
//        
//        // then this will set the divedod label to the correct dod
//        [self GetDiveDOD];
//    }
//}
//
//-(void)CheckDDForDive {
//    
//    if (self.txtDiveGroup.text.length > 0 && self.txtDive.text.length > 0) {
//        // this will disable dive position choices based on cat, board, and dive type
//        [self DisableDivePositions];
//        
//        // then this will set the divedod label to the correct dod
//        [self GetDiveDOD];
//    }
//}

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

-(void)fillDiveInfo {
    
    //int diveNumInt = [self.onDiveNumber integerValue];
    JudgeScores *diveInfo = [[JudgeScores alloc] init];
    
    if (self.maxDiveNumber >= 1) {
        self.lblDive1.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:1];
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
        [self.view1 setUserInteractionEnabled:YES];
    }
    
    if (self.maxDiveNumber >= 2) {
        self.lblDive2.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:2];
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
        [self.view2 setUserInteractionEnabled:YES];
    }
    
    if (self.maxDiveNumber >= 3) {
        self.lblDive3.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:3];
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
        [self.view3 setUserInteractionEnabled:YES];
    }
    
    if (self.maxDiveNumber >= 4) {
        self.lblDive4.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:4];
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
        [self.view4 setUserInteractionEnabled:YES];
    }
    
    if (self.maxDiveNumber >= 5) {
        self.lblDive5.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:5];
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
        [self.view5 setUserInteractionEnabled:YES];
    }
    
    if (self.maxDiveNumber >= 6) {
        self.lblDive6.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:6];
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
        [self.view6 setUserInteractionEnabled:YES];
    }
    
    // we won't even bother checking these unless the diveTotal is 11
    if (self.diveTotal == 11) {
        if (self.maxDiveNumber >= 7) {
            self.lblDive7.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:7];
            [self.lblDive7 setHidden:NO];
            [self.lblDive7text setHidden:NO];
            [self.view7 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 8) {
            self.lblDive8.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:8];
            [self.lblDive8 setHidden:NO];
            [self.lblDive8text setHidden:NO];
            [self.view8 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 9) {
            self.lblDive9.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:9];
            [self.lblDive9 setHidden:NO];
            [self.lblDive9text setHidden:NO];
            [self.view9 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 10) {
            self.lblDive10.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:10];
            [self.lblDive10 setHidden:NO];
            [self.lblDive10text setHidden:NO];
            [self.view10 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 11) {
            self.lblDive11.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:11];
            [self.lblDive11 setHidden:NO];
            [self.lblDive11text setHidden:NO];
            [self.view11 setUserInteractionEnabled:YES];
        }
    }
}

-(void)hideInitialControls {
    
    [self.lblDive1 setHidden:YES];
    [self.lblDive2 setHidden:YES];
    [self.lblDive3 setHidden:YES];
    [self.lblDive4 setHidden:YES];
    [self.lblDive5 setHidden:YES];
    [self.lblDive6 setHidden:YES];
    [self.lblDive7 setHidden:YES];
    [self.lblDive8 setHidden:YES];
    [self.lblDive9 setHidden:YES];
    [self.lblDive10 setHidden:YES];
    [self.lblDive11 setHidden:YES];
    [self.lblDive1text setHidden:YES];
    [self.lblDive2text setHidden:YES];
    [self.lblDive3text setHidden:YES];
    [self.lblDive4text setHidden:YES];
    [self.lblDive5text setHidden:YES];
    [self.lblDive6text setHidden:YES];
    [self.lblDive7text setHidden:YES];
    [self.lblDive8text setHidden:YES];
    [self.lblDive9text setHidden:YES];
    [self.lblDive10text setHidden:YES];
    [self.lblDive11text setHidden:YES];
    [self.view1 setUserInteractionEnabled:NO];
    [self.view2 setUserInteractionEnabled:NO];
    [self.view3 setUserInteractionEnabled:NO];
    [self.view4 setUserInteractionEnabled:NO];
    [self.view5 setUserInteractionEnabled:NO];
    [self.view6 setUserInteractionEnabled:NO];
    [self.view7 setUserInteractionEnabled:NO];
    [self.view8 setUserInteractionEnabled:NO];
    [self.view9 setUserInteractionEnabled:NO];
    [self.view10 setUserInteractionEnabled:NO];
    [self.view11 setUserInteractionEnabled:NO];
}

-(void)resetValues {
    
    [self.txtDiveNumberEntry resignFirstResponder];
    [self.txtDivePositionEntry resignFirstResponder];
    [self.txtDiveGroup resignFirstResponder];
    [self.txtDive resignFirstResponder];
    self.txtDiveNumberEntry.text = @"";
    self.txtDivePositionEntry.text = @"";
    
    self.diveGroupID = 0;
    self.diveID = 0;
    
    [self.groupPicker reloadAllComponents];
    
    self.txtDiveGroup.text = @"";
    self.txtDive.text = @"";
    self.SCPosition.selectedSegmentIndex = -0;
    self.lblDivedd.text = @"0.0";
}

-(void)updateButtonText {
    
    if (self.maxDiveNumber < self.diveTotal) {
        
        self.allDivesEntered = NO;
        
        [self.btnEnterDive setTitle:@"Enter Dive" forState:UIControlStateNormal];
        [self.btnEnterDive setTitle:@"Enter Dive" forState:UIControlStateSelected];
        
    } else {
        
        self.allDivesEntered = YES;
        
        [self.btnEnterDive setTitle:@"Score Meet" forState:UIControlStateNormal];
        [self.btnEnterDive setTitle:@"Score Meet" forState:UIControlStateSelected];
        
        [self HideAllControls];
        
        // lets see if the diveList is filled yet and only update it if not
//        DiveList *list = [[DiveList alloc] init];
        DiveList *list = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:1];
        int filled = [list.listFilled intValue];
        
        if (filled == 1) {
            [self updateListFilled];
        }
    }
}

-(void)HideAllControls {
    
    [self.txtDiveGroup setEnabled:NO];
    [self.txtDive setEnabled:NO];
    [self.SCPosition setEnabled:NO];
    [self.lblDiveddText setEnabled:NO];
    [self.lblDivedd setEnabled:NO];
    [self.txtDiveNumberEntry setEnabled:NO];
    [self.txtDivePositionEntry setEnabled:NO];
    
}

-(void)updateListFilled {
    
    DiveList *list = [[DiveList alloc] init];
    [list UpdateListFilled:self.meetRecordID diverid:self.diverRecordID key:@2];
}

-(void)updateListStarted {
    
    DiveList *list = [[DiveList alloc] init];
    
    [list updateListStarted:self.meetRecordID diverid:self.diverRecordID];
}

@end
