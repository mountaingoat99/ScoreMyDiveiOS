//
//  MeetEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetEdit : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtMeetName;
@property (weak, nonatomic) IBOutlet UITextField *txtSchool;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UIDatePicker *meetDate;

-(IBAction)saveInfo:(id)sender;

@end
