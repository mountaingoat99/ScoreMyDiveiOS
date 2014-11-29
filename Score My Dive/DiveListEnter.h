//
//  DiveListEnter.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListEnter : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;

@property (nonatomic) int diveGroupID;
@property (nonatomic) int diveID;
@property (nonatomic) int divePositionID;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDiverName;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;
@property (weak, nonatomic) IBOutlet UITextField *txtDiveGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtDive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCPosition;
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
@property (weak, nonatomic) IBOutlet UILabel *lblbDive11;

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender;
- (IBAction)btnEnterDive:(id)sender;

@end
