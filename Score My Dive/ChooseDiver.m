//
//  ChooseDiver.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/23/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "ChooseDiver.h"
#import "Diver.h"
#import "Meet.h"
#import "MeetCollection.h"
#import "DiveTotal.h"
#import "DiveNumber.h"
#import "DiveList.h"
#import "JudgeScores.h"
#import "Judges.h"
#import "DiverBoardSize.h"
#import "DiveListEnter.h"
#import "Results.h"

@interface ChooseDiver ()

@property (nonatomic, strong)NSArray *diverArray;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic) BOOL noList;

-(void)loadSpinnerData;
-(void)getMeetName;
-(BOOL)PreviousMeetInfo;
-(void)HideControls;
-(void)writeNewDiveCollection;
-(void)GetCollectionofMeetInfo;
-(void)DeleteAllDiverMeetInfo;
-(void)CheckForNoList;

@end

@implementation ChooseDiver

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initilize no list to false first
    self.noList = NO;
    
    self.diveTotalID = 6;
    self.boardSize1ID = 1;
    
    [self getMeetName];
    
    [self loadSpinnerData];
    
    [self makeDiverPicker];
    
    // attributes for controls
    self.txtChooseDiver.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseDiver.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseDiver.layer.masksToBounds = NO;
    self.txtChooseDiver.layer.shadowRadius = 4.0f;
    self.txtChooseDiver.layer.shadowOpacity = .3;
    self.txtChooseDiver.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseDiver.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.SCDiveTotals.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCDiveTotals.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCDiveTotals.layer.masksToBounds = NO;
    self.SCDiveTotals.layer.shadowOpacity = .7;
    
    self.SCBoardSize.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCBoardSize.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCBoardSize.layer.masksToBounds = NO;
    self.SCBoardSize.layer.shadowOpacity = .7;
    
    
    //[[self.btnEnterScores layer] setBorderColor:[[UIColor blackColor] CGColor]];
    //[[self.btnEnterScores layer] setBorderWidth:1.0];
    self.btnEnterList.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterList.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterList.layer.masksToBounds = NO;
    self.btnEnterList.layer.shadowOpacity = .7;
    
    self.btnEnterScores.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterScores.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterScores.layer.masksToBounds = NO;
    self.btnEnterScores.layer.shadowOpacity = .7;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        // color attributes for the segmented controls in iphone
        NSDictionary *segmentedControlTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateSelected];
        
        
    } else {
        
        // color and size attributes for the SC in iPad
        NSDictionary *segmentedControlTextAttributesiPad = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateSelected];
        
    }
    
    // hide button and labels until a diver is choosen and has meet records
    //[self.btnResetDiver setHidden:YES];
    [self.lblDiveTotal setHidden:YES];
    [self.lblBoardSize setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToChooseDiver:(UIStoryboardSegue *)segue{
    
    // reset everything and reload the spinner
    self.txtChooseDiver.text = @"";
    [self loadSpinnerData];
    [self makeDiverPicker];
    [self.SCBoardSize setHidden:NO];
    [self.SCDiveTotals setHidden:NO];
    [self.lblDiveTotal setHidden:YES];
    [self.lblBoardSize setHidden:YES];
    
}

// push id to next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"idSegueDiveList"]) {
        
        DiveListEnter *diver = [segue destinationViewController];
        // here we will just send a collection and the diver and meetid
        diver.meetInfo = self.meetInfo;
        diver.meetRecordID = self.meetRecordID;
        diver.diverRecordID = self.diverRecordID;
    }
}

// hide the PickerView on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

// pickerview methods
-(void)makeDiverPicker{
    
    self.divePicker = [[UIPickerView alloc] init];
    [self.divePicker setBackgroundColor:[UIColor grayColor]];
    self.divePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.divePicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.divePicker.layer.masksToBounds = NO;
    self.divePicker.layer.shadowOpacity = .3;
    self.divePicker.dataSource = self;
    self.divePicker.delegate = self;
    self.txtChooseDiver.inputView = self.divePicker;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.diverArray.count;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // assign the first item in array to text box right away, so user doesn't have to
    self.txtChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
    self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
    
    //call the method to check if a driver has been assigned to a meet and hide controls
    [self HideControls];
    
    // call the method to see if the have a noList record
    [self CheckForNoList];
    
    return [self.diverArray[row]objectAtIndex:1];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.txtChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
    [self.txtChooseDiver resignFirstResponder];
    self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
    
    //call the method to check if a driver has been assigned to a meet and hid controls
    [self HideControls];
    
    
}

//segmented control methods
- (IBAction)DiveTotalIndexChanged:(UISegmentedControl *)sender {
    
    switch (self.SCDiveTotals.selectedSegmentIndex) {
        case 0:
            self.diveTotalID = 6;
            break;
        case 1:
            self.diveTotalID = 11;
            break;
    }
}

- (IBAction)BoardSizeIndexChanged:(UISegmentedControl *)sender {
    
    switch (self.SCBoardSize.selectedSegmentIndex) {
        case 0:
            self.boardSize1ID = 1;
            break;
        case 1:
            self.boardSize1ID = 3;
            break;
        case 2:
            self.boardSize1ID = 5;
            break;
        case 3:
            self.boardSize1ID = 7.5;
            break;
        case 4:
            self.boardSize1ID = 10;
            break;
    }
}

//button methods
- (IBAction)EnterListClick:(id)sender {
    
    // first we make sure they have chosen a diver
    if (self.txtChooseDiver.text.length != 0) {
        
        // then we make sure they they have not starting scoring without a list
        // noList = 1 is set on the scoreDives screen on the first dive scored without a list
        if (!self.noList) {
            BOOL previousInfo = [self PreviousMeetInfo];
            
            if (!previousInfo) {
                [self writeNewDiveCollection];
            }
            [self GetCollectionofMeetInfo];
            
            [self performSegueWithIdentifier:@"idSegueDiveList" sender:self];
            
        } else {
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You have already starting scoring this diver without a list. You will need to remove the diver from the meet and start over if you want to use a list."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Diver"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)EnterScoresClick:(id)sender {
    
    if (self.txtChooseDiver.text.length != 0) {
        
        BOOL previousInfo = [self PreviousMeetInfo];
        
        if (!previousInfo) {
            [self writeNewDiveCollection];
        }
        [self GetCollectionofMeetInfo];
        
        [self performSegueWithIdentifier:@"" sender:self];  //TODO: put the new segue here*********************************************************************
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Diver"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
    
}

- (IBAction)ResetDiverClick:(id)sender {
    
    if (self.txtChooseDiver.text.length != 0) {
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Be warned, this remove all diver info from a meet, including scores and dive lists."
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK Action");
                                       [self DeleteAllDiverMeetInfo];
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Diver"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
    }
    
    
}

#pragma private methods

-(void)loadSpinnerData {
    if (self.diverArray != nil) {
        self.diverArray = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.diverArray = [divers GetAllDivers];
    
}

-(void)getMeetName {
    
    Meet *meetName = [[Meet alloc] init];
    self.lblMeetName.text = [meetName GetMeetName:self.meetRecordID];
    
}

-(BOOL)PreviousMeetInfo {
    
    NSArray *valid;
    
    Results *results = [[Results alloc] init];
    
    valid = [results GetResultObject:self.meetRecordID DiverId:self.diverRecordID];
    
    if (valid.count > 0) {
        
        return true;
        
    } else {
        
        return false;
        
    }
}

-(void)HideControls{
    
    BOOL previousInfo = false;
    NSString *yesDives;
    NSString *yesBoard;
    
    previousInfo = [self PreviousMeetInfo];
    
    if (previousInfo) {
        
        [self GetCollectionofMeetInfo];
        
        [self.SCBoardSize setHidden:YES];
        [self.SCDiveTotals setHidden:YES];
        [self.btnResetDiver setHidden:NO];
        [self.lblDiveTotal setHidden:NO];
        [self.lblBoardSize setHidden:NO];
        
        DiveTotal *total = [[DiveTotal alloc] init];
        DiverBoardSize *bSize = [[DiverBoardSize alloc] init];
        
        total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
        bSize = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
        
        yesDives = [total.diveTotal stringValue];
        yesBoard = [bSize.firstSize stringValue];
        
        self.lblDiveTotal.text = [yesDives stringByAppendingString:@" Dives"];
        self.lblBoardSize.text = [yesBoard stringByAppendingString:@" Meter"];
        
    } else {
        
        // hide button and labels until a diver is choosen and has meet records
        [self.SCBoardSize setHidden:NO];
        [self.SCDiveTotals setHidden:NO];
        //[self.btnResetDiver setHidden:YES];
        [self.lblDiveTotal setHidden:YES];
        [self.lblBoardSize setHidden:YES];
        
    }
    
}

-(void)writeNewDiveCollection {
    
    DiveList *list = [[DiveList alloc] init];
    [list UpdateDiveList:self.meetRecordID diverid:self.diverRecordID listfilled:@0 noList:@0];
    
    DiveTotal *total = [[DiveTotal alloc] init];
    [total CreateDiveTotal:self.meetRecordID DiverID:self.diverRecordID Total:self.diveTotalID];
    
    DiveNumber *number = [[DiveNumber alloc] init];
    [number CreateDiveNumber:self.meetRecordID diverid:self.diverRecordID number:@0 boardsize:self.boardSize1ID];
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    [board CreateBoardSize:self.meetRecordID DiverID:self.diverRecordID Total:self.boardSize1ID TotalBoards:1];
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:self.boardSize1ID divenumber:@0 divecategory:@"" divetype:@"" diveposition:@"" failed:@0 multiplier:@0 totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    
    Results *result = [[Results alloc] init];
    
    [result CreateResult:self.meetRecordID DiverID:self.diverRecordID Dive1:@0 Dive2:@0 Dive3:@0 Dive4:@0 Dive5:@0 Dive6:@0 Dive7:@0 Dive8:@0 Dive9:@0 Dive10:@0 Dive11:@0 DiveScoreTotal:@0];
    
}

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

-(void)DeleteAllDiverMeetInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    [diver RemoveDiverFromMeet:self.meetRecordID diverid:self.diverRecordID];
    
}

-(void)CheckForNoList {
    
    DiveList *list = [[DiveList alloc] init];
    
    self.noList = [list CheckForNoList:self.meetRecordID diverid:self.diverRecordID];
    
}

@end
