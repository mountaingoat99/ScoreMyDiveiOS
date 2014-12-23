//
//  DiveListFinalScore.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListFinalScore : UIViewController

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic) int diveNumber;
@property (nonatomic, strong) NSArray *meetInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbldiveType;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalScore;
@property (weak, nonatomic) IBOutlet UIButton *btnTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnFailed;

- (IBAction)btnTotalClick:(id)sender;
- (IBAction)btnFailedClick:(id)sender;

@end
