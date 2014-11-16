//
//  MeetEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetEdit.h"
#import "DBManager.h"

@interface MeetEdit ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation MeetEdit


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the text boxes
    self.txtMeetName.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtMeetName.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtMeetName.layer.masksToBounds = NO;
    self.txtMeetName.layer.shadowRadius = 4.0f;
    self.txtMeetName.layer.shadowOpacity = .5;
    
    self.txtSchool.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSchool.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtSchool.layer.masksToBounds = NO;
    self.txtSchool.layer.shadowRadius = 4.0f;
    self.txtSchool.layer.shadowOpacity = .5;
    
    self.txtCity.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtCity.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtCity.layer.masksToBounds = NO;
    self.txtCity.layer.shadowRadius = 4.0f;
    self.txtCity.layer.shadowOpacity = .5;
    
    self.txtState.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtState.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtState.layer.masksToBounds = NO;
    self.txtState.layer.shadowRadius = 4.0f;
    self.txtState.layer.shadowOpacity = .5;
    
    self.txtDate.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDate.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDate.layer.masksToBounds = NO;
    self.txtDate.layer.shadowRadius = 4.0f;
    self.txtDate.layer.shadowOpacity = .5;
    
    self.txtMeetName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtCity.delegate = self;
    self.txtState.delegate = self;
    self.txtDate.delegate = self;
    
    // alloc the database
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
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

//updates the dateText field with values from the date picker
-(void)updateTextField:(UIDatePicker *)sender
{
    //date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    self.txtDate.text = [formatter stringFromDate:sender.date];
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

// database insert
-(IBAction)saveInfo:(id)sender{
    // prepare the query string
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
    
        NSString *query = [NSString stringWithFormat:
                           @"insert into meet(name, school, city, state, date) values('%@', '%@', '%@', '%@', '%@')",
                           self.txtMeetName.text, self.txtSchool.text, self.txtCity.text, self.txtState.text, self.txtDate.text];
    
        // execute the query
        [self.dbManager executeQuery:query];
    
        // if the query was succesfully executed then pop the view controller
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        
            // pop the view controller
            //[self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"Could not execute the query");
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
