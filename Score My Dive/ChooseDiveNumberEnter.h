//
//  ChooseDiveNumberEnter.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/24/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDiveNumberEnter : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic) int listOrNot;
@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic, strong) NSNumber *onDiveNumber;

@property (nonatomic) int diveGroupID;
@property (nonatomic) int diveID;
@property (nonatomic) int divePositionID;

@property (weak, nonatomic) IBOutlet UITextField *txtDiveGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtDive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveddText;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;

@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel;

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender;
- (IBAction)btnEnterScores:(id)sender;
- (IBAction)btnEnterTotalScores:(id)sender;

@end
