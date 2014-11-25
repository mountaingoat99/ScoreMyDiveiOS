//
//  MeetEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetEdit.h"
#import "Meet.h"

@interface MeetEdit ()

// private method to load the edited data
-(void)loadInfoToEdit;

@end

@implementation MeetEdit

#pragma View Controller Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        
        Meet *meet = [[Meet alloc] init];
        
        if ([meet UpdateMeet:self.recordIDToEdit Name:self.txtMeetName.text School:self.txtSchool.text City:self.txtCity.text State:self.txtSchool.text Date:self.txtDate.text]) {
            
            //inform the delegate that the edit was finished and update previous
            //viewcontroller table rows
            [self.delegate editInfoWasFinished];
            
            // pop the view controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            //TODO: figure out something to do here
        }
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
    
}

//updates the dateText field with values from the date picker
-(void)updateTextField:(UIDatePicker *)sender
{
    //date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    self.txtDate.text = [formatter stringFromDate:sender.date];
}

@end
