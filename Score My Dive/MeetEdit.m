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

@interface MeetEdit ()

// private method to load the edited data
-(void)loadInfoToEdit;
-(void)updateJudgeControls;

@end

@implementation MeetEdit

#pragma View Controller Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.judgeTotal = @2;
    
    // drop shadow for the text boxes
    self.txtMeetName.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtMeetName.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtMeetName.layer.masksToBounds = NO;
    //self.txtMeetName.layer.shadowRadius = 4.0f;
    self.txtMeetName.layer.shadowOpacity = .3;
    self.txtMeetName.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtSchool.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSchool.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtSchool.layer.masksToBounds = NO;
    //self.txtSchool.layer.shadowRadius = 4.0f;
    self.txtSchool.layer.shadowOpacity = .3;
    self.txtSchool.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtCity.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtCity.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtCity.layer.masksToBounds = NO;
    //self.txtCity.layer.shadowRadius = 4.0f;
    self.txtCity.layer.shadowOpacity = .3;
    self.txtCity.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtState.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtState.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtState.layer.masksToBounds = NO;
    //self.txtState.layer.shadowRadius = 4.0f;
    self.txtState.layer.shadowOpacity = .3;
    self.txtState.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtDate.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDate.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDate.layer.masksToBounds = NO;
    //self.txtDate.layer.shadowRadius = 4.0f;
    self.txtDate.layer.shadowOpacity = .3;
    
    self.txtMeetName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtCity.delegate = self;
    self.txtState.delegate = self;
    self.txtDate.delegate = self;
    
    self.SCJudges.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCJudges.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCJudges.layer.masksToBounds = NO;
    //self.SCJudges.layer.shadowRadius = 4.0f;
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
    
    if (self.recordIDToEdit != -1) {
        
        [self loadInfoToEdit];
        
    }
    
    // initilize the date to today
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    self.txtDate.text = [formatter stringFromDate:[NSDate date]];
    
    //replace keyboard with a date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.layer.backgroundColor = [UIColor grayColor].CGColor;
    datePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    datePicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    datePicker.layer.masksToBounds = NO;
    datePicker.layer.shadowOpacity = .5;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtDate setInputView:datePicker];
}

// handles the return button
-(IBAction)unwindAddMeet:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
        
        lastInsertRecord = [meet UpdateMeet:self.recordIDToEdit Name:self.txtMeetName.text School:self.txtSchool.text City:self.txtCity.text State:self.txtSchool.text Date:self.txtDate.text];
        
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
            [self dismissViewControllerAnimated:YES completion:nil];
            
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

#pragma private methods

// loads a current record into the text fields
-(void)loadInfoToEdit {
    
    // send the id to the class method to get the results array for the text boxes
    Meet *meet = [[Meet alloc] init];
    NSArray *meetArray = [meet LoadMeet:self.recordIDToEdit];
    
    // set the data to the correct text boxes to edit
    self.txtMeetName.text = [[meetArray objectAtIndex:0] objectAtIndex:1];
    self.txtSchool.text = [[meetArray objectAtIndex:0] objectAtIndex:2];
    self.txtCity.text = [[meetArray objectAtIndex:0] objectAtIndex:3];
    self.txtState.text = [[meetArray objectAtIndex:0] objectAtIndex:4];
    self.txtDate.text = [[meetArray objectAtIndex:0] objectAtIndex:5];
    
    // update the control
    [self updateJudgeControls];
    
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
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal isEqualToNumber:@3]) {
        self.SCJudges.selectedSegmentIndex = 1;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @5]) {
        self.SCJudges.selectedSegmentIndex = 2;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @7]) {
        self.SCJudges.selectedSegmentIndex = 3;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else {
        self.SCJudges.selectedSegmentIndex = 0;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
        self.judgeTotal = @2;
    }
    
}

@end
