//
//  ChooseDiver.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/23/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDiver : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic) int diveTotalID;
@property (nonatomic) double boardSize1ID;
@property (nonatomic) double boardSize2ID;
@property (nonatomic) double boardSize3ID;

@property (weak, nonatomic) IBOutlet UITextField *txtChooseDiver;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblBoardSize;

@property (weak, nonatomic) IBOutlet UISegmentedControl *SCDiveTotals;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCBoardSize;

@property (weak, nonatomic) IBOutlet UIButton *btnEnterList;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterScores;
@property (weak, nonatomic) IBOutlet UIButton *btnResetDiver;

//segmented control methods
- (IBAction)DiveTotalIndexChanged:(UISegmentedControl *)sender;
- (IBAction)BoardSizeIndexChanged:(UISegmentedControl *)sender;

// button methods
- (IBAction)EnterListClick:(id)sender;
- (IBAction)EnterScoresClick:(id)sender;
- (IBAction)ResetDiverClick:(id)sender;

@end
