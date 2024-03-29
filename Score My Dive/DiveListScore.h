//
//  DiveListScore.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel;
@property (weak, nonatomic) IBOutlet UILabel *line3;
@property (weak, nonatomic) IBOutlet UILabel *line4;
@property (weak, nonatomic) IBOutlet UILabel *line5;
@property (weak, nonatomic) IBOutlet UILabel *line6;
@property (weak, nonatomic) IBOutlet UILabel *line7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *panelConstraint;

//auto complete text fields
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UITextField *txt4;
@property (weak, nonatomic) IBOutlet UITextField *txt5;
@property (weak, nonatomic) IBOutlet UITextField *txt6;
@property (weak, nonatomic) IBOutlet UITextField *txt7;

- (IBAction)btnTotalClick:(id)sender;
- (IBAction)btnFailedClick:(id)sender;
- (IBAction)btnReturnClick:(id)sender;

@end
