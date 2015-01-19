//
//  DiveInfo.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveInfo.h"
#import "Diver.h"
#import "Diver.h"
#import "Meet.h"
#import "Judges.h"
#import "DiverBoardSize.h"
#import "JudgeScores.h"
#import "DiverMeetScores.h"

@interface DiveInfo ()

@property (nonatomic) int judgeTotal;

-(void)loadDiverInfo;
-(void)loadMeetInfo;
-(void)loadScores;
-(void)findJudgeTotal;
-(void)HideControls;

@end

@implementation DiveInfo

#pragma ViewController events

-(void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.meetInfo.count > 0) {
        [self loadDiverInfo];
        [self loadMeetInfo];
        [self findJudgeTotal];
        [self loadScores];
    }
    
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeInt:self.meetIdToView forKey:@"meetId"];
    [coder encodeInt:self.diverIdToView forKey:@"diverId"];
    [coder encodeInt:self.callingIDToReturnTo forKey:@"CallingId"];
    [coder encodeInt:self.diveNumber forKey:@"diveNumber"];
    [coder encodeObject:self.boardSize forKey:@"boardSize"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.meetIdToView = [coder decodeIntForKey:@"meetId"];
    self.diverIdToView = [coder decodeIntForKey:@"diverId"];
    self.callingIDToReturnTo = [coder decodeIntForKey:@"CallingId"];
    self.diveNumber = [coder decodeIntForKey:@"diveNumber"];
    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idSegueInfoToScores"]) {
        
        DiverMeetScores *scores = [segue destinationViewController];
        
        scores.callingIDToReturnTo = self.callingIDToReturnTo;
        scores.meetIdToView = self.meetIdToView;
        scores.diverIdToView = self.diverIdToView;
        scores.meetInfo = self.meetInfo;
        scores.boardSize = self.boardSize;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)btnReturnClick:(id)sender {
//    
//    [self performSegueWithIdentifier:@"idSegueInfoToScores" sender:self];
//}

#pragma private methods

-(void)loadDiverInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    
    self.lblDiverName.text = diver.Name;
    
}

-(void)loadMeetInfo {
    
    Meet *meet = [[Meet alloc] init];
    
    meet = [self.meetInfo objectAtIndex:0];
    
    self.lblDiverSchool.text = meet.meetName;
    
}

-(void)findJudgeTotal {
    
    Judges *judge = [[Judges alloc] init];
    judge = [self.meetInfo objectAtIndex:1];
    self.judgeTotal = [judge.judgeTotal intValue];
    
    [self HideControls];
}

-(void)HideControls {
    
    if (self.judgeTotal == 2 || self.judgeTotal == 3) {
        
        [self.lblJudge4 setHidden:YES];
        [self.lblJudge4Text setHidden:YES];
        [self.lblJudge5 setHidden:YES];
        [self.lblJudge5Text setHidden:YES];
        [self.lblJudge6 setHidden:YES];
        [self.lblJudge6Text setHidden:YES];
        [self.lblJudge7 setHidden:YES];
        [self.lblJudge7Text setHidden:YES];
        
    }
    
    if (self.judgeTotal == 5) {
        
        [self.lblJudge6 setHidden:YES];
        [self.lblJudge6Text setHidden:YES];
        [self.lblJudge7 setHidden:YES];
        [self.lblJudge7Text setHidden:YES];
    }
}

-(void)loadScores {
    
    int location = self.diveNumber - 1;
    
    JudgeScores *judge = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:location];
    
    self.lblDiveType.text = judge.diveType;
    self.lblDivePostion.text = judge.divePosition;
    self.lblDivedd.text = [judge.multiplier stringValue];
    double totalScore = [judge.totalScore doubleValue];
    NSString *score = [NSString stringWithFormat:@"%.2f", totalScore];
    self.lblScoreTotal.text = score;
    
    if ([judge.failed isEqualToString:@"1"]) {
        self.lblFailed.text = @"F";
    } else {
        self.lblFailed.text = @"P";
    }
    
    self.lblJudge1.text = [judge.score1 stringValue];
    self.lblJudge2.text = [judge.score2 stringValue];
    self.lblJudge3.text = [judge.score3 stringValue];
    self.lblJudge4.text = [judge.score4 stringValue];
    self.lblJudge5.text = [judge.score5 stringValue];
    self.lblJudge6.text = [judge.score6 stringValue];
    self.lblJudge7.text = [judge.score7 stringValue];
    
}

@end
