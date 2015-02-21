//
//  DiverMeetScores.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiverMeetScores : UIViewController

// for the collection of meet objects
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int meetIdToView;
@property (nonatomic) int diverIdToView;
@property (nonatomic) int callingIDToReturnTo;
@property (nonatomic) int diveNumber;
@property (nonatomic, strong) NSNumber *boardSize;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSchool;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;
@property (weak, nonatomic) IBOutlet UILabel *lblSchoolName;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblBoardType;
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
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel1;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel2;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundConstraint;

@property (weak, nonatomic) IBOutlet UILabel *lblDive7Text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive8Text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive9Text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive10Text;
@property (weak, nonatomic) IBOutlet UILabel *lblDive11Text;

@property (weak, nonatomic) IBOutlet UIButton *btnDive1;
@property (weak, nonatomic) IBOutlet UIButton *btnDive2;
@property (weak, nonatomic) IBOutlet UIButton *btnDive3;
@property (weak, nonatomic) IBOutlet UIButton *btnDive4;
@property (weak, nonatomic) IBOutlet UIButton *btnDive5;
@property (weak, nonatomic) IBOutlet UIButton *btnDive6;
@property (weak, nonatomic) IBOutlet UIButton *btnDive7;
@property (weak, nonatomic) IBOutlet UIButton *btnDive8;
@property (weak, nonatomic) IBOutlet UIButton *btnDive9;
@property (weak, nonatomic) IBOutlet UIButton *btnDive10;
@property (weak, nonatomic) IBOutlet UIButton *btnDive11;

- (IBAction)btnDive1Click:(id)sender;
- (IBAction)btnDive2Click:(id)sender;
- (IBAction)btnDive3Click:(id)sender;
- (IBAction)btnDive4Click:(id)sender;
- (IBAction)btnDive5Click:(id)sender;
- (IBAction)btnDive6Click:(id)sender;
- (IBAction)btnDive7Click:(id)sender;
- (IBAction)btnDive8Click:(id)sender;
- (IBAction)btnDive9Click:(id)sender;
- (IBAction)btnDive10Click:(id)sender;
- (IBAction)btnDive11Click:(id)sender;

- (IBAction)btnReturnClick:(id)sender;

@end
