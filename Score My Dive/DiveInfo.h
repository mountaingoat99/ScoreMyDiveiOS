//
//  DiveInfo.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveInfo : UIViewController

@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int meetIdToView;
@property (nonatomic) int diverIdToView;
@property (nonatomic) int callingIDToReturnTo;
@property (nonatomic) int diveNumber;
@property (nonatomic, strong) NSNumber *boardSize;

@property (weak, nonatomic) IBOutlet UILabel *lblDiverName;
@property (weak, nonatomic) IBOutlet UILabel *lblDiverSchool;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveType;
@property (weak, nonatomic) IBOutlet UILabel *lblDivePostion;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblFailed;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge1;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge2;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge3;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge4;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge5;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge6;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge7;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge3Text;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge4Text;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge5Text;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge6Text;
@property (weak, nonatomic) IBOutlet UILabel *lblJudge7Text;

//- (IBAction)btnReturnClick:(id)sender;

@end
