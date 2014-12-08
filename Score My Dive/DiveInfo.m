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
#import "DiverBoardSize.h"
#import "JudgeScores.h"
#import "DiverMeetScores.h"

@interface DiveInfo ()

-(void)loadDiverInfo;
-(void)loadMeetInfo;
-(void)loadScores;

@end

@implementation DiveInfo

#pragma ViewController events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.meetInfo.count > 0) {
        [self loadDiverInfo];
        [self loadMeetInfo];
        [self loadScores];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(void)loadScores {
    
    int location = self.diveNumber - 1;
    
    JudgeScores *judge = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:location];
    
    self.lblDiveType.text = judge.diveType;
    self.lblDivePostion.text = judge.divePosition;
    self.lblDivedd.text = [judge.multiplier stringValue];
    self.lblScoreTotal.text = [judge.totalScore stringValue];
    self.lblFailed.text = judge.failed;
    self.lblJudge1.text = [judge.score1 stringValue];
    self.lblJudge2.text = [judge.score2 stringValue];
    self.lblJudge3.text = [judge.score3 stringValue];
    self.lblJudge4.text = [judge.score4 stringValue];
    self.lblJudge5.text = [judge.score5 stringValue];
    self.lblJudge6.text = [judge.score6 stringValue];
    self.lblJudge7.text = [judge.score7 stringValue];
    
}

@end
