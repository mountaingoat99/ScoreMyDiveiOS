//
//  DiveListEnter.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiveListEdit.h"
#import "HTAutocompleteTextField.h"

@interface DiveListEnter : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, DiveListEnterViewControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;

@property (nonatomic) int diveGroupID;
@property (nonatomic) int diveID;
@property (nonatomic) int divePositionID;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDiverName;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;
@property (weak, nonatomic) IBOutlet UITextField *txtDiveGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtDive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveddText;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterDive;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblDive1;
@property (weak, nonatomic) IBOutlet UILabel *lblDive2;
@property (weak, nonatomic) IBOutlet UILabel *lblDive3;
@property (weak, nonatomic) IBOutlet UILabel *lblDive4;
@property (weak, nonatomic) IBOutlet UILabel *lblDive5;
@property (weak, nonatomic) IBOutlet UILabel *lblDive6;
@property (weak, nonatomic) IBOutlet UILabel *lblDive7;
@property (weak, nonatomic) IBOutlet UILabel *lblDive8;
@property (weak, nonatomic) IBOutlet UILabel *lblDive9;
@property (weak, nonatomic) IBOutlet UILabel *lblDive10;
@property (weak, nonatomic) IBOutlet UILabel *lblDive11;

@property (weak, nonatomic) IBOutlet UILabel *lblDive1text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive2text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive3text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive4text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive5text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive6text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive7text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive8text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive9text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive10text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive11text;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;
@property (weak, nonatomic) IBOutlet UIView *view9;
@property (weak, nonatomic) IBOutlet UIView *view10;
@property (weak, nonatomic) IBOutlet UIView *view11;

// autofill controls
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txtDiveNumberEntry;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txtDivePositionEntry;

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender;
- (IBAction)btnEnterDive:(id)sender;
- (IBAction)lblOptionsClick:(id)sender;
//- (IBAction)btnBackClick:(id)sender;

// touch events for the dive edits
- (IBAction)Dive1EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive2EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive3EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive4EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive5EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive6EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive7EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive8EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive9EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive10EditClick:(UILongPressGestureRecognizer *)sender;
- (IBAction)Dive11EditClick:(UILongPressGestureRecognizer *)sender;

@end
