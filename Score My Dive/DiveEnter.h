//
//  DiveEnter.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/26/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAutocompleteTextField.h"

@interface DiveEnter : UIViewController <UIScrollViewDelegate>

//popover
@property (nonatomic, retain) UIPopoverController *popoverContr;

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDiverName;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *lblBoardType;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel1;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel2;
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

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterScore;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterTotalScore;

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

- (IBAction)lblOptionsClick:(id)sender;
- (IBAction)btnTypeNumber:(id)sender;
- (IBAction)btnChooseDives:(id)sender;
- (IBAction)btnSwitchDiver:(id)sender;

@end
