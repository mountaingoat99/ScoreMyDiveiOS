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

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveType;
@property (weak, nonatomic) IBOutlet UILabel *lblScore1;
@property (weak, nonatomic) IBOutlet UILabel *lblScore2;
@property (weak, nonatomic) IBOutlet UILabel *lblScore3;
@property (weak, nonatomic) IBOutlet UILabel *lblScore4;
@property (weak, nonatomic) IBOutlet UILabel *lblScore5;
@property (weak, nonatomic) IBOutlet UILabel *lblScore6;
@property (weak, nonatomic) IBOutlet UILabel *lblScore7;
@property (weak, nonatomic) IBOutlet UILabel *lblScore8;
@property (weak, nonatomic) IBOutlet UILabel *lblScore9;
@property (weak, nonatomic) IBOutlet UILabel *lblScore10;
@property (weak, nonatomic) IBOutlet UILabel *lblScore11;
@property (weak, nonatomic) IBOutlet UITextField *txtScore1;
@property (weak, nonatomic) IBOutlet UITextField *txtScore2;
@property (weak, nonatomic) IBOutlet UITextField *txtScore3;
@property (weak, nonatomic) IBOutlet UITextField *txtScore4;
@property (weak, nonatomic) IBOutlet UITextField *txtScore5;
@property (weak, nonatomic) IBOutlet UITextField *txtScore6;
@property (weak, nonatomic) IBOutlet UITextField *txtScore7;
@property (weak, nonatomic) IBOutlet UITextField *txtScore8;
@property (weak, nonatomic) IBOutlet UITextField *txtScore9;
@property (weak, nonatomic) IBOutlet UITextField *txtScore10;
@property (weak, nonatomic) IBOutlet UITextField *txtScore11;
@property (weak, nonatomic) IBOutlet UIButton *btnTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnFailed;

- (IBAction)btnTotalClick:(id)sender;
- (IBAction)btnFailedClick:(id)sender;

@end
