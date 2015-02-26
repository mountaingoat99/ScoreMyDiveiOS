//
//  DiveListChoose.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListChoose : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITextFieldDelegate>

//popover
@property (nonatomic, retain) UIPopoverController *popoverContr;

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int listOrNot;


@property (weak, nonatomic) IBOutlet UITextField *txtDiveNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterScore;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *lblDiverName;
@property (weak, nonatomic) IBOutlet UILabel *lblSchoolName;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *lblBoardType;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel1;
@property (weak, nonatomic) IBOutlet UILabel *bacgroundPanel2;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel3;

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

- (IBAction)btnEnterScoreClick:(id)sender;
- (IBAction)btnEnterTotalScoreClick:(id)sender;

- (IBAction)btnSwitchDiver:(id)sender;

@end
