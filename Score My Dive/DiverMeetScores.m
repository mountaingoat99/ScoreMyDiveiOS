//
//  DiverMeetScores.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverMeetScores.h"
#import "Diver.h"
#import "Meet.h"
#import "Results.h"
#import "DiverBoardSize.h"
#import "DiveInfo.h"
#import "MeetHistory.h"
#import "DiverHistory.h"
#import "DiveTotal.h"
#import "DiveNumber.h"
#import "JudgeScores.h"
#import "RankingsDiver.h"

@interface DiverMeetScores ()

@property (nonatomic, strong) NSNumber* diveTotal;
@property (nonatomic) int maxDiveNumber;

// private methods to load the data
-(void)loadDiverInfo;
-(void)loadMeetInfo;
-(void)loadType;
-(void)loadResults;
-(void)FindDiveTotal;
-(void)HideControls;

@end

@implementation DiverMeetScores

#pragma ViewController Events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //sets the border for the label/buttons
    [[self.btnDive1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive1 layer] setBorderWidth:1.0];
    [[self.btnDive1 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive1 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive1 layer] setMasksToBounds:NO];
    [[self.btnDive1 layer] setShadowOpacity:.3];
    
    [[self.btnDive2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive2 layer] setBorderWidth:1.0];
    [[self.btnDive2 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive2 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive2 layer] setMasksToBounds:NO];
    [[self.btnDive2 layer] setShadowOpacity:.3];
    
    [[self.btnDive3 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive3 layer] setBorderWidth:1.0];
    [[self.btnDive3 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive3 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive3 layer] setMasksToBounds:NO];
    [[self.btnDive3 layer] setShadowOpacity:.3];
    
    [[self.btnDive4 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive4 layer] setBorderWidth:1.0];
    [[self.btnDive4 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive4 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive4 layer] setMasksToBounds:NO];
    [[self.btnDive4 layer] setShadowOpacity:.3];
    
    [[self.btnDive5 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive5 layer] setBorderWidth:1.0];
    [[self.btnDive5 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive5 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive5 layer] setMasksToBounds:NO];
    [[self.btnDive5 layer] setShadowOpacity:.3];
    
    [[self.btnDive6 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive6 layer] setBorderWidth:1.0];
    [[self.btnDive6 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive6 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive6 layer] setMasksToBounds:NO];
    [[self.btnDive6 layer] setShadowOpacity:.3];
    
    [[self.btnDive7 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive7 layer] setBorderWidth:1.0];
    [[self.btnDive7 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive7 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive7 layer] setMasksToBounds:NO];
    [[self.btnDive7 layer] setShadowOpacity:.3];
    
    [[self.btnDive8 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive8 layer] setBorderWidth:1.0];
    [[self.btnDive8 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive8 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive8 layer] setMasksToBounds:NO];
    [[self.btnDive8 layer] setShadowOpacity:.3];
    
    [[self.btnDive9 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive9 layer] setBorderWidth:1.0];
    [[self.btnDive9 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive9 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive9 layer] setMasksToBounds:NO];
    [[self.btnDive9 layer] setShadowOpacity:.3];
    
    [[self.btnDive10 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive10 layer] setBorderWidth:1.0];
    [[self.btnDive10 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive10 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive10 layer] setMasksToBounds:NO];
    [[self.btnDive10 layer] setShadowOpacity:.3];
    
    [[self.btnDive11 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive11 layer] setBorderWidth:1.0];
    [[self.btnDive11 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive11 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive11 layer] setMasksToBounds:NO];
    [[self.btnDive11 layer] setShadowOpacity:.3];
    
    //NSLog(@"DiverMeetScores ViewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.meetInfo.count > 0) {
        [self loadDiverInfo];
        [self loadMeetInfo];
        [self FindDiveTotal];
        [self loadType];
        [self loadResults];
    }
    
    //NSLog(@"DiverMeetScores viewWillAppear");
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
    
    //NSLog(@"DiverMeetScores encode");
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.meetIdToView = [coder decodeIntForKey:@"meetId"];
    self.diverIdToView = [coder decodeIntForKey:@"diverId"];
    self.callingIDToReturnTo = [coder decodeIntForKey:@"CallingId"];
    self.diveNumber = [coder decodeIntForKey:@"diveNumber"];
    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
    
    //NSLog(@"DiverMeetScores Decode");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToDiverMeetScores:(UIStoryboardSegue*)segue {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idSegueDiverScores"]) {
        DiveInfo *info = [segue destinationViewController];
        
        info.callingIDToReturnTo = self.callingIDToReturnTo;
        info.meetIdToView = self.meetIdToView;
        info.diverIdToView = self.diverIdToView;
        info.diveNumber = self.diveNumber;
        info.meetInfo = self.meetInfo;
        info.boardSize = self.boardSize;
    }
    
    if ([segue.identifier isEqualToString:@"idSegueScoresToMeetHistory"]) {
        MeetHistory *history = [segue destinationViewController];
        
        history.meetInfo = self.meetInfo;
        history.recordIDToEdit = self.meetIdToView;
        history.diverid = self.diverIdToView;
        history.callingIdToReturnTo = self.callingIDToReturnTo;
        
    }
    
    if ([segue.identifier isEqualToString:@"idSegueScoresToDiverHistory"]) {
        DiverHistory *history = [segue destinationViewController];
        
        history.diverInfo = self.meetInfo;
        history.recordIdToEdit = self.diverIdToView;
        history.meetId = self.meetIdToView;
        history.callingIdToReturnTo = self.callingIDToReturnTo;
    }
    
    if ([segue.identifier isEqualToString:@"idMeetScoresToRank"]) {
        RankingsDiver *rank = [segue destinationViewController];
        
        rank.meetId = self.meetIdToView;
        rank.boardSize = self.boardSize;
    }
}

- (IBAction)btnDive1Click:(id)sender {
    
    if (self.maxDiveNumber >= 1) {
        self.diveNumber = 1;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive2Click:(id)sender {
    
    if (self.maxDiveNumber >= 2) {
        self.diveNumber = 2;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive3Click:(id)sender {
    
    if (self.maxDiveNumber >= 3) {
        self.diveNumber = 3;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive4Click:(id)sender {
    
    if (self.maxDiveNumber >= 4) {
        self.diveNumber = 4;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive5Click:(id)sender {
    
    if (self.maxDiveNumber >= 5) {
        self.diveNumber = 5;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive6Click:(id)sender {
    
    if (self.maxDiveNumber >= 6) {
        self.diveNumber = 6;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive7Click:(id)sender {
    
    if (self.maxDiveNumber >= 7) {
        self.diveNumber = 7;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive8Click:(id)sender {
    
    if (self.maxDiveNumber >= 8) {
        self.diveNumber = 8;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive9Click:(id)sender {
    
    if (self.maxDiveNumber >= 9) {
        self.diveNumber = 9;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive10Click:(id)sender {
    
    if (self.maxDiveNumber >= 10) {
        self.diveNumber = 10;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnDive11Click:(id)sender {
    
    if (self.maxDiveNumber == 11) {
        self.diveNumber = 11;
        
        [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"We don't have a score for that one yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnReturnClick:(id)sender {
    
    if (self.callingIDToReturnTo == 1) {
        
        [self performSegueWithIdentifier:@"idSegueScoresToMeetHistory" sender:self];
        
    } else if (self.callingIDToReturnTo == 2) {
        
        [self performSegueWithIdentifier:@"idSegueScoresToDiverHistory" sender:self];
        
    } else {
        
        [self performSegueWithIdentifier:@"idMeetScoresToRank" sender:self];
    }
}

#pragma Private methods

// loads the current record to update
-(void)loadDiverInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    
    self.lblName.text = diver.Name;
    self.lblSchool.text = diver.School;
    
}

-(void)loadMeetInfo {
    
    Meet *meet = [[Meet alloc] init];
    NSString *schoolAndDate;
    NSString *cityState;
    
    meet = [self.meetInfo objectAtIndex:0];
    
    self.lblMeetName.text = meet.meetName;
    schoolAndDate = meet.schoolName;
    schoolAndDate = [schoolAndDate stringByAppendingString:@" - "];
    self.lblSchoolName.text = [schoolAndDate stringByAppendingString:meet.date];
    cityState = meet.city;
    cityState = [cityState stringByAppendingString:@", "];
    self.lblCity.text = [cityState stringByAppendingString:meet.state];

}

-(void)FindDiveTotal {
    
    DiveTotal *total = [[DiveTotal alloc] init];
    total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = total.diveTotal;
    
    DiveNumber *number = [[DiveNumber alloc] init];
    number = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:3];
    self.maxDiveNumber = [number.number intValue];
    
    [self HideControls];
    
    // here we should also get the divenumber and disable the buttons if not at that number yet
    // convert it to an int and check each click event
    
}

-(void)HideControls {
    
    if ([self.diveTotal isEqualToNumber:@6]) {
        
        [self.lblDive7Text setHidden:YES];
        [self.lblDive7 setHidden:YES];
        [self.btnDive7 setHidden:YES];
        [self.btnDive7 setEnabled:NO];
        
        [self.lblDive8Text setHidden:YES];
        [self.lblDive8 setHidden:YES];
        [self.btnDive8 setHidden:YES];
        [self.btnDive8 setEnabled:NO];
        
        [self.lblDive9Text setHidden:YES];
        [self.lblDive9 setHidden:YES];
        [self.btnDive9 setHidden:YES];
        [self.btnDive9 setEnabled:NO];
        
        [self.lblDive10Text setHidden:YES];
        [self.lblDive10 setHidden:YES];
        [self.btnDive10 setHidden:YES];
        [self.btnDive10 setEnabled:NO];
        
        [self.lblDive11Text setHidden:YES];
        [self.lblDive11 setHidden:YES];
        [self.btnDive11 setHidden:YES];
        [self.btnDive11 setEnabled:NO];
    }
}

-(void)loadType {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    NSString *boardType;
    
    boardType = [board.firstSize stringValue];
    self.lblBoardType.text = [boardType stringByAppendingString:@" Meter"];
    
}

-(void)loadResults {
    
    Results *result = [[Results alloc] init];
    JudgeScores *scores = [[JudgeScores alloc] init];
    NSString *failed;
    
    result = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:5];
    
    //results total
    double totalDouble = [result.totalScoreTotal doubleValue];
    NSString *total = [NSString stringWithFormat:@"%.2f", totalDouble];
    self.lblTotal.text = total;
    
    // first we need to make sure there is a result for each dive
    if (self.maxDiveNumber >= 1) {
    
        // lets see if any of the dives failed
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:0];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive1.text = @"F";
        } else {
            double scoreDouble = [result.dive1 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive1.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 2) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:1];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive2.text = @"F";
        } else {
            double scoreDouble = [result.dive2 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive2.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 3) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:2];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive3.text = @"F";
        } else {
            double scoreDouble = [result.dive3 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive3.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 4) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:3];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive4.text = @"F";
        } else {
            double scoreDouble = [result.dive4 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive4.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 5) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:4];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive5.text = @"F";
        } else {
            double scoreDouble = [result.dive5 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive5.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 6) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:5];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive6.text = @"F";
        } else {
            double scoreDouble = [result.dive6 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive6.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 7) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:6];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive7.text = @"F";
        } else {
            double scoreDouble = [result.dive7 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive7.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 8) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:7];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive8.text = @"F";
        } else {
            double scoreDouble = [result.dive8 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive8.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 9) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:8];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive9.text = @"F";
        } else {
            double scoreDouble = [result.dive9 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive9.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 10) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:9];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive10.text = @"F";
        } else {
            double scoreDouble = [result.dive10 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive10.text = score;
        }
    }
    
    if (self.maxDiveNumber >= 11) {
        
        scores = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:10];
        failed = scores.failed;
        if ([failed isEqualToString:@"1"]) {
            self.lblDive11.text = @"F";
        } else {
            double scoreDouble = [result.dive11 doubleValue];
            NSString *score = [NSString stringWithFormat:@"%.2f", scoreDouble];
            self.lblDive11.text = score;
        }
    }
}



@end
