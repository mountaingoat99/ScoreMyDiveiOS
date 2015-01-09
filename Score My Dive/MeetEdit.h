//
//  MeetEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// lets us tell the MeetEdit View Controller we have updated
// a field when we pop this viewcontroller off the stack
@protocol MeetDetailsViewControllerDelegate

-(void)editInfoWasFinished;

@end

@interface MeetEdit : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>

// delegate property
@property (nonatomic, strong) id<MeetDetailsViewControllerDelegate> delegate;

// edit record property
@property (nonatomic) int recordIDToEdit;
@property (nonatomic) NSNumber *judgeTotal;
@property (nonatomic) BOOL previousDate;

@property (weak, nonatomic) IBOutlet UITextField *txtMeetName;
@property (weak, nonatomic) IBOutlet UITextField *txtSchool;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (strong, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCJudges;
@property (weak, nonatomic) IBOutlet UILabel *lblJudgeWarning;

-(IBAction)saveInfo:(id)sender;
- (IBAction)JudgesClick:(UISegmentedControl *)sender;

@end