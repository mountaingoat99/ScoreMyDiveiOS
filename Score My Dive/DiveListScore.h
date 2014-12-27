//
//  DiveListScore.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAutocompleteTextField.h"

@interface DiveListScore : UIViewController <UITextFieldDelegate>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic) int diveNumber;
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int listOrNot;
@property (nonatomic, strong) NSString *diveCategory;
@property (nonatomic, strong) NSString *divePosition;
@property (nonatomic, strong) NSString *diveNameForDB;
@property (nonatomic, strong) NSNumber *multiplierToSend;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveType;
@property (weak, nonatomic) IBOutlet UILabel *lblScore1;
@property (weak, nonatomic) IBOutlet UILabel *lblScore2;
@property (weak, nonatomic) IBOutlet UILabel *lblScore3;
@property (weak, nonatomic) IBOutlet UILabel *lblScore4;
@property (weak, nonatomic) IBOutlet UILabel *lblScore5;
@property (weak, nonatomic) IBOutlet UILabel *lblScore6;
@property (weak, nonatomic) IBOutlet UILabel *lblScore7;
@property (weak, nonatomic) IBOutlet UIButton *btnTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnFailed;

//auto complete text fields
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt1;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt2;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt3;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt4;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt5;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt6;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txt7;

- (IBAction)btnTotalClick:(id)sender;
- (IBAction)btnFailedClick:(id)sender;
- (IBAction)btnReturnClick:(id)sender;

@end
