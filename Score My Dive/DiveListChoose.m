//
//  DiveListChoose.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListChoose.h"
#import "MeetCollection.h"
#import "Meet.h"
#import "Diver.h"
#import "Judges.h"
#import "DiveTotal.h"
#import "DiverBoardSize.h"
#import "DiveNumber.h"
#import "Results.h"
#import "JudgeScores.h"
#import "DiveListScore.h"
#import "DiveListFinalScore.h"

@interface DiveListChoose ()

@property (nonatomic, strong) NSArray *diveNumberArray;
@property (nonatomic, strong) UIPickerView *diveNumberPicker;
@property (nonatomic, strong) NSNumber *DiveNumber;
@property (nonatomic, strong) NSNumber *scoreTotal;
@property (nonatomic) int diveTotal;
@property (nonatomic) int whatNumber;

-(void)GetCollectionofMeetInfo;
-(void)getTheDiveTotal;
-(void)loadPicker;
-(void)makePicker;
-(void)fillText;
-(void)fillType;
-(void)hideInitialControls;
-(void)diveNumberFromPicker;
-(void)fillDiveInfo;
-(void)checkFinishedScoring;
-(void)ShowScoreTotal:(NSNumber*)scoretotal;

@end

@implementation DiveListChoose

#pragma viewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideInitialControls];
    
    // lets grab all the meet info first
    [self GetCollectionofMeetInfo];
    [self getTheDiveTotal];
    [self loadPicker];
    [self makePicker];
    [self fillText];
    [self fillType];
    [self fillDiveInfo];
    [self checkFinishedScoring];
    
    // attributes for controls
    self.txtDiveNumber.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveNumber.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveNumber.layer.masksToBounds = NO;
    self.txtDiveNumber.layer.shadowRadius = 4.0f;
    self.txtDiveNumber.layer.shadowOpacity = .3;
    self.txtDiveNumber.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.btnEnterScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterScore.layer.masksToBounds = NO;
    self.btnEnterScore.layer.shadowOpacity = .7;
    
    self.btnEnterTotalScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterTotalScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterTotalScore.layer.masksToBounds = NO;
    self.btnEnterTotalScore.layer.shadowOpacity = .7;
    
    // sets up the following delegate method to disable horizontal scrolling
    // don't forget to declare the UIScrollViewDelegate in the .h file
    self.scrollView.delegate = self;
    
}

// stops horitontal scrolling
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToDiveListChoose:(UIStoryboardSegue*)sender {
    
    // refresh everything after a score is entered
    [self GetCollectionofMeetInfo];
    [self getTheDiveTotal];
    [self loadPicker];
    [self makePicker];
    [self fillText];
    [self fillType];
    [self fillDiveInfo];
    
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the diveListScore
    if([segue.identifier isEqualToString:@"idSegueDiveListScore"]) {
        
        DiveListScore *score = [segue destinationViewController];
        
        self.listOrNot = 0;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.meetRecordID;
        score.diveNumber = [self.DiveNumber intValue];
        score.meetInfo = self.meetInfo;
        
    }
    
    // send to the diveListFinalScore
    if([segue.identifier isEqualToString:@"idSegueDiveListTotalScore"]) {
        
        DiveListFinalScore *score = [segue destinationViewController];
        
        self.listOrNot = 0;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.meetRecordID;
        score.diveNumber = [self.DiveNumber intValue];
        score.meetInfo = self.meetInfo;
        
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView ==self.diveNumberPicker) {
        return self.diveNumberArray.count;
    } else {
        return self.diveNumberArray.count;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    // assign the first item in array to text box right away, so user doesn't have to
    self.txtDiveNumber.text = self.diveNumberArray [row];
    
    // here we need to see what dive number is chosen and add that number to the self.diveNumber variable
    [self diveNumberFromPicker];
    
    return self.diveNumberArray [row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.txtDiveNumber.text = self.diveNumberArray [row];
    
    // here we need to see what dive number is chosen and add that number to the self.diveNumber variable
    [self diveNumberFromPicker];
    
    [self.txtDiveNumber resignFirstResponder];
}


// hide the PickerView on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)btnEnterScoreClick:(id)sender {
    
    if (self.txtDiveNumber.text.length != 0) {
        // go to the diveListTotal
        [self performSegueWithIdentifier:@"idSegueDiveListScore" sender:self];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Dive to score"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnEnterTotalScoreClick:(id)sender {
    
    if (self.txtDiveNumber.text.length != 0) {
        // go to the diveListTotal score
        [self performSegueWithIdentifier:@"idSegueDiveListTotalScore" sender:self];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Dive to score"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

#pragma private methods

-(void)GetCollectionofMeetInfo {
    
    MeetCollection *meetCollection = [[MeetCollection alloc] init];
    
    self.meetInfo = [meetCollection GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
    
    // doing this to test and log that we get the correct data
    Meet *testMeet = [[Meet alloc] init];
    Judges *testJudges = [[Judges alloc] init];
    
    testMeet = [self.meetInfo objectAtIndex:0];
    testJudges = [self.meetInfo objectAtIndex:1];
    
    // here we just want to let the log know we have the correct meet chosen
    NSString *test = testMeet.meetID;
    NSString *testName = testMeet.meetName;
    NSString *testSchool = testMeet.schoolName;
    NSString *testCity = testMeet.city;
    NSString *testState = testMeet.state;
    NSString *testDate = testMeet.date;
    NSNumber *testJudgeTotal = testJudges.judgeTotal;
    
    NSLog(@"the meetid is %@", test);
    NSLog(@"the meetname is %@", testName);
    NSLog(@"the meetschool is %@", testSchool);
    NSLog(@"the meetcity is %@", testCity);
    NSLog(@"the meetstate is %@", testState);
    NSLog(@"the meetdate is %@", testDate);
    NSLog(@"the judgetotal is %@", testJudgeTotal);
    
}

-(void)getTheDiveTotal {
    
    DiveTotal *total = [[DiveTotal alloc] init];
    
    total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    
    self.diveTotal = [total.diveTotal intValue];
    
}

-(void)makePicker {
    
    self.diveNumberPicker = [[UIPickerView alloc] init];
    [self.diveNumberPicker setBackgroundColor:[UIColor grayColor]];
    self.diveNumberPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.diveNumberPicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.diveNumberPicker.layer.masksToBounds = NO;
    self.diveNumberPicker.layer.shadowOpacity = .3;
    self.diveNumberPicker.dataSource = self;
    self.diveNumberPicker.delegate = self;
    self.txtDiveNumber.inputView = self.diveNumberPicker;
    
}

-(void)loadPicker {
    
    if (self.diveNumberArray != nil) {
        self.diveNumberArray = nil;
    }
    
    // here we will laod the picker with class variables
    if (self.diveTotal == 6) {
        
        self.diveNumberArray = [NSArray arrayWithObjects:@"Dive 1", @"Dive 2", @"Dive 3", @"Dive 4", @"Dive 5", @"Dive 6", nil];
        
    } else {
        
        self.diveNumberArray = [NSArray arrayWithObjects:@"Dive 1", @"Dive 2", @"Dive 3", @"Dive 4", @"Dive 5", @"Dive 6", @"Dive 7", @"Dive 8", @"Dive 9", @"Dive 10", @"Dive 11", nil];
    }
}

-(void)fillText {
    
    // meet info
    Meet *meet = [[Meet alloc] init];
    meet = [self.meetInfo objectAtIndex:0];
    self.lblSchoolName.text = meet.schoolName;
    
    // diver info
    Diver *diver = [[Diver alloc] init];
    diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    self.lblDiverName.text = diver.Name;
    
}

-(void)fillType {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    NSNumber *boardSize = board.firstSize;
    
    NSString *boardSizeText = [boardSize stringValue];
    
    boardSizeText = [boardSizeText stringByAppendingString:@" Meter"];
    
    self.lblBoardType.text = boardSizeText;
    
}

-(void)hideInitialControls {
    
    [self.lblDive1 setHidden:YES];
    [self.lblDive2 setHidden:YES];
    [self.lblDive3 setHidden:YES];
    [self.lblDive4 setHidden:YES];
    [self.lblDive5 setHidden:YES];
    [self.lblDive6 setHidden:YES];
    [self.lblDive7 setHidden:YES];
    [self.lblDive8 setHidden:YES];
    [self.lblDive9 setHidden:YES];
    [self.lblDive10 setHidden:YES];
    [self.lblDive11 setHidden:YES];
    [self.lblDive1text setHidden:YES];
    [self.lblDive2text setHidden:YES];
    [self.lblDive3text setHidden:YES];
    [self.lblDive4text setHidden:YES];
    [self.lblDive5text setHidden:YES];
    [self.lblDive6text setHidden:YES];
    [self.lblDive7text setHidden:YES];
    [self.lblDive8text setHidden:YES];
    [self.lblDive9text setHidden:YES];
    [self.lblDive10text setHidden:YES];
    [self.lblDive11text setHidden:YES];
    
}

-(void)diveNumberFromPicker {
    
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 1"]) {
        self.DiveNumber = @1;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 2"]) {
        self.DiveNumber = @2;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 3"]) {
        self.DiveNumber = @3;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 4"]) {
        self.DiveNumber = @4;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 5"]) {
        self.DiveNumber = @5;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 6"]) {
        self.DiveNumber = @6;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 7"]) {
        self.DiveNumber = @7;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 8"]) {
        self.DiveNumber = @8;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 9"]) {
        self.DiveNumber = @9;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 10"]) {
        self.DiveNumber = @10;
        return;
    }
    if ([self.txtDiveNumber.text isEqualToString: @"Dive 11"]) {
        self.DiveNumber = @11;
        return;
    }
}

-(void)fillDiveInfo {
    
    // text for the label
    NSString *diveInfoText;
    
    //result object for the label
    Results *score = [[Results alloc] init];
    JudgeScores *diveInfo = [[JudgeScores alloc] init];
    
    // for checking a failed dive
    JudgeScores *failInfo = [[JudgeScores alloc] init];
    NSString *failedDive;
    
    // lets see what dive number we are on first
    DiveNumber *number = [[DiveNumber alloc] init];
    number = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:3];
    self.whatNumber = [number.number intValue];
    
    // lets get the results from the meetcollection object for the whole method to use
    score = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:5];
    
    // now we check the number and show the score and divetype
    if (self.whatNumber >= 1) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:0];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:1]];
        } else {
        
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive1 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:1]];
        }
        self.lblDive1text.text = diveInfoText;
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
    }
    
    if (self.whatNumber >= 2) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:1];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:2]];
        } else {
            
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive2 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:2]];
        }
        self.lblDive2text.text = diveInfoText;
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
    }
    
    if (self.whatNumber >= 3) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:2];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:3]];
        } else {
            
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive3 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:3]];
        }
        self.lblDive3text.text = diveInfoText;
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
    }
    
    if (self.whatNumber >= 4) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:3];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:4]];
        } else {
            
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive4 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:4]];
        }
        self.lblDive4text.text = diveInfoText;
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
    }
    
    if (self.whatNumber >= 5) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:4];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:5]];
        } else {
            
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive5 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:5]];
        }
        self.lblDive5text.text = diveInfoText;
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
    }
    
    if (self.whatNumber >= 6) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:5];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:6]];
        } else {
            
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive6 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:6]];
        }
        self.lblDive6text.text = diveInfoText;
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
    }
    
    // we won't bother checking these unless the diveTotal is 11
    if (self.diveTotal == 11) {
        
        if (self.whatNumber >= 7) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:6];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:7]];
            } else {
                
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive7 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:7]];
            }
            self.lblDive7text.text = diveInfoText;
            [self.lblDive7 setHidden:NO];
            [self.lblDive7text setHidden:NO];
        }
        
        if (self.whatNumber >= 8) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:7];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:8]];
            } else {
                
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive8 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:8]];
            }
            self.lblDive8text.text = diveInfoText;
            [self.lblDive8 setHidden:NO];
            [self.lblDive8text setHidden:NO];
        }
        
        if (self.whatNumber >= 9) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:8];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:9]];
            } else {
                
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive9 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:9]];
            }
            self.lblDive9text.text = diveInfoText;
            [self.lblDive9 setHidden:NO];
            [self.lblDive9text setHidden:NO];
        }
        
        if (self.whatNumber >= 10) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:9];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:10]];
            } else {
                
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive10 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:10]];
            }
            self.lblDive10text.text = diveInfoText;
            [self.lblDive10 setHidden:NO];
            [self.lblDive10text setHidden:NO];
        }
        
        if (self.whatNumber >= 11) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:10];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:11]];
            } else {
                
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive11 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:11]];
            }
            self.lblDive11text.text = diveInfoText;
            [self.lblDive11 setHidden:NO];
            [self.lblDive11text setHidden:NO];
        }
    }
    
    // sets the score total
    [self ShowScoreTotal:score.totalScoreTotal];
}

-(void)ShowScoreTotal:(NSNumber*)scoretotal {
    
    if (![scoretotal isEqual:@0]) {
        
        // have to do an idiodic convert to double, round and convert back to number because
        // of the insane apple datatypes
        double total = [scoretotal doubleValue];
        
        self.scoreTotal = scoretotal;
        self.lblTotalScore.text = [NSString stringWithFormat:@"%.2f", total];
        
    } else {
        self.lblTotalScore.text = @"0.0";
    }
}

-(void)checkFinishedScoring {
    
    if (self.diveTotal == self.whatNumber) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Congradulations!"
                                                        message:@"Scoring is complete for this diver"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

@end
