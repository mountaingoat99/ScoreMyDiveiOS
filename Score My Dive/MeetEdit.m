//
//  MeetEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetEdit.h"
#import "Meet.h"
#import "Judges.h"
#import "Results.h"

@interface MeetEdit ()

@property (nonatomic) BOOL previousScores;
@property (nonatomic, strong) UIDatePicker *datePicker;


// private method to load the edited data
-(void)loadInfoToEdit;
-(void)updateJudgeControls;
-(void)previousScoresCheck;

@end

@implementation MeetEdit

#pragma View Controller Events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.judgeTotal = @2;
    [self.lblJudgeWarning setHidden:YES];
    
    // drop shadow for the text boxes
    self.txtMeetName.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtMeetName.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtMeetName.layer.masksToBounds = NO;
    self.txtMeetName.layer.shadowOpacity = .3;
    self.txtMeetName.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtMeetName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtMeetName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtSchool.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSchool.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtSchool.layer.masksToBounds = NO;
    self.txtSchool.layer.shadowOpacity = .3;
    self.txtSchool.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtSchool.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtSchool.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtCity.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtCity.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtCity.layer.masksToBounds = NO;
    self.txtCity.layer.shadowOpacity = .3;
    self.txtCity.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtCity.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtCity.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtState.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtState.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtState.layer.masksToBounds = NO;
    self.txtState.layer.shadowOpacity = .3;
    self.txtState.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtState.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.txtState.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtDate.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDate.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDate.layer.masksToBounds = NO;
    self.txtDate.layer.shadowOpacity = .3;
    self.txtDate.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtMeetName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtCity.delegate = self;
    self.txtState.delegate = self;
    self.txtDate.delegate = self;
    
    self.SCJudges.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCJudges.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCJudges.layer.masksToBounds = NO;
    self.SCJudges.layer.shadowOpacity = .7;
    
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
    
    // initilize the date to today
    if (!self.previousDate) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        self.txtDate.text = [formatter stringFromDate:[NSDate date]];
        
    }
    
    //replace keyboard with a date picker
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.layer.backgroundColor = [UIColor grayColor].CGColor;
    self.datePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.datePicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.datePicker.layer.masksToBounds = NO;
    self.datePicker.layer.shadowOpacity = .5;
    [self.datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtDate setInputView:self.datePicker];
    
    // add a done button to the date picker
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    toolbar.barTintColor = [UIColor grayColor];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(dateSelectionDone:)];
    
    toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone, nil];
    barButtonDone.tintColor = [UIColor blackColor];
    //[self.datePicker addSubview:toolbar];
    self.txtDate.inputAccessoryView = toolbar;
}

// done button a picker
-(void)dateSelectionDone:(id)sender {
    
    [self.txtDate resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.recordIDToEdit != -1) {
        [self loadInfoToEdit];
    }
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    NSNumber *segment = [NSNumber numberWithInt:(int)self.SCJudges.selectedSegmentIndex];
    
    [coder encodeObject:self.delegate forKey:@"Delegate"];
    [coder encodeInt:self.recordIDToEdit forKey:@"RecordId"];
    [coder encodeObject:segment forKey:@"Segment"];
    
    // lets see if there is any text in the fields and save those as well
    if (self.txtMeetName.text.length > 0) {
        [coder encodeObject:self.txtMeetName.text forKey:@"Name"];
    }
    if (self.txtSchool.text.length > 0) {
        [coder encodeObject:self.txtSchool.text forKey:@"School"];
    }
    if (self.txtCity.text.length > 0) {
        [coder encodeObject:self.txtCity.text forKey:@"City"];
    }
    if (self.txtState.text.length > 0) {
        [coder encodeObject:self.txtState.text forKey:@"State"];
    }
    if (self.txtDate.text.length > 0) {
        [coder encodeObject:self.txtDate.text forKey:@"Date"];
        self.previousDate = YES;
        [coder encodeBool:self.previousDate forKey:@"PreviousDate"];
    }
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.delegate = [coder decodeObjectForKey:@"Delegate"];
    self.recordIDToEdit = [coder decodeIntForKey:@"RecordId"];
    self.SCJudges.selectedSegmentIndex = [[coder decodeObjectForKey:@"Segment"] intValue];
    self.txtMeetName.text = [coder decodeObjectForKey:@"Name"];
    self.txtSchool.text = [coder decodeObjectForKey:@"School"];
    self.txtCity.text = [coder decodeObjectForKey:@"City"];
    self.txtState.text = [coder decodeObjectForKey:@"State"];
    self.txtDate.text = [coder decodeObjectForKey:@"Date"];
    self.previousDate = [coder decodeBoolForKey:@"PreviousDate"];
    
}

// handles the return button
-(IBAction)unwindAddMeet:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    
    if (textField == self.txtMeetName) {
        [self.txtSchool becomeFirstResponder];
    }
    if (textField == self.txtSchool) {
        [self.txtCity becomeFirstResponder];
    }
    if (textField == self.txtCity) {
        [self.txtState becomeFirstResponder];
    }
    if (textField == self.txtState) {
        [self.txtDate becomeFirstResponder];
    }
    if (textField == self.txtDate) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//keps the user from entering text in the txtfield
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.txtDate == textField) {
        return NO;
    }
    
    return YES;
    
}

// database insert
-(IBAction)saveInfo:(id)sender{
    
    // make sure all text fields have an entry
    if (self.txtMeetName.text.length == 0 || self.txtSchool.text.length == 0 ||
        self.txtCity.text.length == 0 || self.txtState.text.length == 0 || self.txtDate.text.length == 0) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please enter a value for all fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
    } else {
        
        int lastInsertRecord;
        
        Meet *meet = [[Meet alloc] init];
        
        lastInsertRecord = [meet UpdateMeet:self.recordIDToEdit Name:self.txtMeetName.text School:self.txtSchool.text City:self.txtCity.text State:self.txtState.text Date:self.txtDate.text];
        
        if (lastInsertRecord > 0) {
            
            Judges *judges = [[Judges alloc] init];
            [judges UpdateJudges:lastInsertRecord Total:self.judgeTotal];
            
            //inform the delegate that the edit was finished and update previous
            //viewcontroller table rows
            [self.delegate editInfoWasFinished];
            
            // pop the view controller
            [self dismissViewControllerAnimated:YES completion:nil];
        
        } else if (self.recordIDToEdit != 0) {
            
            Judges *judges = [[Judges alloc] init];
            [judges UpdateJudges:self.recordIDToEdit Total:self.judgeTotal];
            
            //inform the delegate that the edit was finished and update previous
            //viewcontroller table rows
            [self.delegate editInfoWasFinished];
            
            // pop the view controller
            //[self dismissViewControllerAnimated:YES completion:nil];
            [self performSegueWithIdentifier:@"idSegueAddMeetToDetails" sender:self];
            
        }
    }
}

- (IBAction)JudgesClick:(UISegmentedControl *)sender {
    
    switch (self.SCJudges.selectedSegmentIndex) {
        case 0:
            self.judgeTotal = @2;
            break;
        case 1:
            self.judgeTotal = @3;
            break;
        case 2:
            self.judgeTotal = @5;
            break;
        case 3:
            self.judgeTotal = @7;
            break;
    }
}

//- (IBAction)btnReturnClick:(id)sender {
//    
//    [self performSegueWithIdentifier:@"idSegueAddMeetToDetails" sender:self];
//}

#pragma private methods

// loads a current record into the text fields
-(void)loadInfoToEdit {
    
    if (self.recordIDToEdit > 0) {
        
        // send the id to the class method to get the results array for the text boxes
        Meet *meet = [[Meet alloc] init];
        NSArray *meetArray = [meet LoadMeet:self.recordIDToEdit];
        
        if (meetArray.count > 0) {
            // set the data to the correct text boxes to edit
            self.txtMeetName.text = [[meetArray objectAtIndex:0] objectAtIndex:1];
            self.txtSchool.text = [[meetArray objectAtIndex:0] objectAtIndex:2];
            self.txtCity.text = [[meetArray objectAtIndex:0] objectAtIndex:3];
            self.txtState.text = [[meetArray objectAtIndex:0] objectAtIndex:4];
            self.txtDate.text = [[meetArray objectAtIndex:0] objectAtIndex:5];
            
            // update the control
            [self updateJudgeControls];
            [self previousScoresCheck];
        }
    }
}

//updates the dateText field with values from the date picker
-(void)updateTextField:(UIDatePicker *)sender
{
    //date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    self.txtDate.text = [formatter stringFromDate:sender.date];
}

-(void)updateJudgeControls {
    
    Judges *judges = [[Judges alloc] init];
    self.judgeTotal = [judges getJudges:self.recordIDToEdit];
    
    if ([self.judgeTotal  isEqualToNumber: @2]) {
        self.SCJudges.selectedSegmentIndex = 0;
        //NSLog(@"Judges total is %@", self.judgeTotal);
        //NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal isEqualToNumber:@3]) {
        self.SCJudges.selectedSegmentIndex = 1;
        //NSLog(@"Judges total is %@", self.judgeTotal);
        //NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @5]) {
        self.SCJudges.selectedSegmentIndex = 2;
        //NSLog(@"Judges total is %@", self.judgeTotal);
        //NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @7]) {
        self.SCJudges.selectedSegmentIndex = 3;
        //NSLog(@"Judges total is %@", self.judgeTotal);
        //NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else {
        self.SCJudges.selectedSegmentIndex = 0;
        //NSLog(@"Judges total is %@", self.judgeTotal);
        //NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
        self.judgeTotal = @2;
    }
}

-(void)previousScoresCheck  {
    
    Results *result = [[Results alloc] init];
    
    if ((self.previousScores = [result ResultsExist:self.recordIDToEdit])) {
        [self.SCJudges setEnabled:NO];
        [self.lblJudgeWarning setHidden:NO];
    }
    
}

@end
