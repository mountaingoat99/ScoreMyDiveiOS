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
#import "AppDelegate.h"

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
    
    [self restrictRotation:YES];

    [[self.backgroundPanel1 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.backgroundPanel1 layer] setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [[self.backgroundPanel1 layer] setMasksToBounds:NO];
    [[self.backgroundPanel1 layer] setShadowOpacity:1.0];

    [[self.backgroundPanel2 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.backgroundPanel2 layer] setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [[self.backgroundPanel2 layer] setMasksToBounds:NO];
    [[self.backgroundPanel2 layer] setShadowOpacity:1.0];
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

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.judgeTotal == 2 || self.judgeTotal == 3) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            self.backgroundConstraint.constant = 65;
            
        } else {
            self.backgroundConstraint.constant = 60;
        }
    }
    
    if (self.judgeTotal == 5) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            self.backgroundConstraint.constant = 30;
            
        } else {
            self.backgroundConstraint.constant = 30;
        }
    }
}

// only allow portrait in iphone
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
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

#pragma private methods

-(void)loadDiverInfo {
    
    Diver *diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    
    self.lblDiverName.text = diver.Name;
    
}

-(void)loadMeetInfo {
    
    Meet *meet = [self.meetInfo objectAtIndex:0];
    
    self.lblDiverSchool.text = meet.meetName;
    
}

-(void)findJudgeTotal {
    
    Judges *judge = [self.meetInfo objectAtIndex:1];
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
