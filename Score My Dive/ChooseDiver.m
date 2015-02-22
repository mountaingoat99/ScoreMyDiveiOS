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
#import "DiveEnter.h"
#import "Results.h"

@interface ChooseDiver ()

// moved from the Choose meet
@property (nonatomic, strong)NSArray *meetArray;
@property (nonatomic, strong) UIPickerView *meetPicker;
-(void)loadData;

@property (nonatomic, strong) NSArray *diverArray;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic) BOOL noList;
@property (nonatomic, strong) NSNumber *listStarted;
@property (nonatomic) BOOL previousInfo;

-(void)loadSpinnerData;
-(BOOL)PreviousMeetInfo;
-(void)HideControls;
-(void)writeNewDiveCollection;
-(void)GetCollectionofMeetInfo;
-(void)DeleteAllDiverMeetInfo;
-(void)CheckForNoList;
-(void)checkforListStarted;
-(void)resetDiver;
-(void)showRankings;

@end

@implementation ChooseDiver

#pragma ViewController Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundPanel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel.layer.masksToBounds = NO;
    self.backgroundPanel.layer.shadowOpacity = 1.0;
    
    self.txtChooseMeet.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseMeet.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtChooseMeet.delegate = self;
    
    self.txtChooseDiver.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseDiver.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtChooseDiver.delegate = self;
    
    self.SCDiveTotals.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCDiveTotals.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.SCDiveTotals.layer.masksToBounds = NO;
    self.SCDiveTotals.layer.shadowOpacity = 1.0;
    
    self.SCBoardSize.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCBoardSize.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.SCBoardSize.layer.masksToBounds = NO;
    self.SCBoardSize.layer.shadowOpacity = 1.0;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        // color attributes for the segmented controls in iphone
        NSDictionary *segmentedControlTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
        
        NSDictionary *segmentedControlTextAttributesPicked = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesPicked forState:UIControlStateSelected];
        
        
    } else {
        
        // color and size attributes for the SC in iPad
        NSDictionary *segmentedControlTextAttributesiPad = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
        
        
        NSDictionary *segmentedControlTextAttributesiPadPicked = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
        
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPad forState:UIControlStateHighlighted];
        [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesiPadPicked forState:UIControlStateSelected];
        
    }
    
    [self makeDiverPicker];
    [self makeMeetPicker];
    
    // add a done button to the date picker
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    toolbar.barTintColor = [UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(dateSelectionDone:)];
    
    toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone, nil];
    barButtonDone.tintColor = [UIColor blackColor];
    self.txtChooseDiver.inputAccessoryView = toolbar;
    self.txtChooseMeet.inputAccessoryView = toolbar;
}

// done button a picker
-(void)dateSelectionDone:(id)sender {
    
    [self.txtChooseDiver resignFirstResponder];
    [self.txtChooseMeet resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
    
    if (!self.savedState) {
        // initilize no list to false first
        self.noList = NO;
        self.diveTotalID = 6;
        self.boardSize1ID = 1;
    }
    
    [self HideControls];
}

// only allow portrait in iphone
-(BOOL)shouldAutorotate {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    NSNumber *diveSegments = [NSNumber numberWithInt:(int)self.SCDiveTotals.selectedSegmentIndex];
    NSNumber *boardSegments = [NSNumber numberWithInt:(int)self.SCBoardSize.selectedSegmentIndex];
    
    [coder encodeInt:self.meetRecordID forKey:@"meetid"];
    [coder encodeObject:diveSegments forKey:@"diveSegments"];
    [coder encodeObject:boardSegments forKey:@"boardSegments"];
    
    if (self.txtChooseMeet.text.length > 0) {
        [coder encodeObject:self.txtChooseMeet.text forKey:@"meetText"];
    }
    
    if (self.txtChooseDiver.text.length > 0) {
        [coder encodeObject:self.txtChooseDiver.text forKey:@"diverText"];
        [coder encodeInt:self.diverRecordID forKey:@"diverId"];
        [coder encodeInt:self.diveTotalID forKey:@"diveTotalId"];
        [coder encodeDouble:self.boardSize1ID forKey:@"boardSize"];
        [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
        self.savedState = YES;
        [coder encodeBool:self.savedState forKey:@"savedState"];
        [coder encodeBool:self.noList forKey:@"noList"];
        [coder encodeObject:self.listStarted forKey:@"listStarted"];
    }
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetRecordID = [coder decodeIntForKey:@"meetid"];
    self.SCDiveTotals.selectedSegmentIndex = [[coder decodeObjectForKey:@"diveSegments"] intValue];
    self.SCBoardSize.selectedSegmentIndex = [[coder decodeObjectForKey:@"boardSegments"] intValue];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.diveTotalID = [coder decodeIntForKey:@"diveTotalId"];
    self.boardSize1ID = [coder decodeDoubleForKey:@"boardSize"];
    self.savedState = [coder decodeBoolForKey:@"savedState"];
    self.noList = [coder decodeBoolForKey:@"noList"];
    self.listStarted = [coder decodeObjectForKey:@"listStarted"];
    self.txtChooseMeet.text = [coder decodeObjectForKey:@"meetText"];
    self.txtChooseDiver.text = [coder decodeObjectForKey:@"diverText"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToChooseDiver:(UIStoryboardSegue *)segue{

    
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
    
    if ([segue.identifier isEqualToString:@"idSegueChooseToScore"]) {
        
        DiveEnter *diver = [segue destinationViewController];
        // here we will just send a collection and the diver and meetid
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

//keps the user from entering text in the txtfield
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return NO;
    
}

// pickerview methods
-(void)makeMeetPicker{
    self.meetPicker = [[UIPickerView alloc] init];
    [self.meetPicker setBackgroundColor:[UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1]];
    self.meetPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.meetPicker.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.meetPicker.layer.masksToBounds = NO;
    self.meetPicker.layer.shadowOpacity = 1.0;
    self.meetPicker.dataSource = self;
    self.meetPicker.delegate = self;
    self.txtChooseMeet.inputView = self.meetPicker;
}

-(void)makeDiverPicker{
    
    self.divePicker = [[UIPickerView alloc] init];
    [self.divePicker setBackgroundColor:[UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1]];
    self.divePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.divePicker.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.divePicker.layer.masksToBounds = NO;
    self.divePicker.layer.shadowOpacity = 1.0;
    self.divePicker.dataSource = self;
    self.divePicker.delegate = self;
    self.txtChooseDiver.inputView = self.divePicker;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.txtChooseMeet) {
        [self.txtChooseDiver becomeFirstResponder];
    }
    if (textField == self.txtChooseDiver) {
        [self.txtChooseDiver resignFirstResponder];
    }
    
    return YES;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.meetPicker) {
        return self.meetArray.count;
    } else {
        return self.diverArray.count;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.meetPicker) {
        
        // assign the first item in array to text box right away, so user doesn't have to
        self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
        // get the meet id to see if a judge total has been picked yet
        self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
        
        [self loadSpinnerData];
        
        return [self.meetArray[row]objectAtIndex:1];
        
    } else {
        
        if (self.txtChooseMeet.text.length > 0) {
    
            // assign the first item in array to text box right away, so user doesn't have to
            self.txtChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
            self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
            
            //call the method to check if a diver has been assigned to a meet and hide controls
            [self HideControls];
            
            // call the method to see if the have a noList record
            [self CheckForNoList];
            
            return [self.diverArray[row]objectAtIndex:1];
                
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"Please Pick a Meet choosing a Diver"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
            
            return nil;
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.meetPicker) {
        // sets the text box for the choosen meet
        self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
        
        //[self.txtChooseMeet resignFirstResponder];
        self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
        
        [self loadSpinnerData];
        
        // here we will need to get the meetobject
        
    } else {
        
        if (self.txtChooseMeet.text.length > 0) {
    
            self.txtChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
            //[self.txtChooseDiver resignFirstResponder];
            self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
            
            //call the method to check if a driver has been assigned to a meet and hid controls
            [self HideControls];
            
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"Please Pick a Meet before choosing a Diver"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    }
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
    
    [self checkforListStarted];
    
    if ([self.listStarted isEqualToNumber:@0]) {
        
        if (self.txtChooseDiver.text.length != 0) {
            
            BOOL previousInfo = [self PreviousMeetInfo];
            
            if (!previousInfo) {
                [self writeNewDiveCollection];
            }
            [self GetCollectionofMeetInfo];
            
            [self performSegueWithIdentifier:@"idSegueChooseToScore" sender:self];
            
        } else {
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"Please Pick a Diver"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"You have already have a dive list started, please reset the diver if you want to enter scores without a list"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
    
}

- (IBAction)ResetDiverClick:(id)sender {
    
    
    UIAlertController *alertController = [UIAlertController
                                            alertControllerWithTitle:@"Deleting a Diver from a Meet will also delete any scores entered for the diver"
                                            message:nil
                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *rankingsAction = [UIAlertAction
                                actionWithTitle:@"Rankings"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"rankings Action");
                                    [self showRankings];
                                }];
    
    UIAlertAction *resetAction = [UIAlertAction
                                actionWithTitle:@"Delete Diver From Meet"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"resetDiver Action");
                                    [self resetDiver];
                                }];
    
    [alertController addAction:resetAction];
    [alertController addAction:rankingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.view;
        popover.sourceRect = [sender frame];
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
}

#pragma private methods

-(void)loadData {
    
    if (self.meetArray != nil) {
        self.meetArray = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.meetArray = [meets GetAllMeets];
    
}

-(void)showRankings {
    
    [self performSegueWithIdentifier:@"idSegueChooseToRankings" sender:self];
    
}

-(void)resetDiver {
    
    if (self.txtChooseDiver.text.length != 0) {
        [self DeleteAllDiverMeetInfo];
        [self.txtChooseDiver resignFirstResponder];
        [self.txtChooseMeet resignFirstResponder];
        //[self.divePicker reloadAllComponents];
        //[self.meetPicker reloadAllComponents];
        self.txtChooseMeet.text = @"";
        self.txtChooseDiver.text = @"";
        [self.SCBoardSize setHidden:NO];
        [self.SCDiveTotals setHidden:NO];
        [self.lblDiveTotal setHidden:YES];
        [self.lblBoardSize setHidden:YES];
        
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


-(void)loadSpinnerData {
    
    // here we need to get divers by meet
    
    if (self.diverArray != nil) {
        self.diverArray = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.diverArray = [divers GetAllDivers];
    
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
    
    NSString *yesDives;
    NSString *yesBoard;
    
    self.previousInfo = [self PreviousMeetInfo];
    
    if (self.previousInfo) {
        
        [self GetCollectionofMeetInfo];
        
        [self.SCBoardSize setHidden:YES];
        [self.SCDiveTotals setHidden:YES];
        [self.btnResetDiver setHidden:NO];
        [self.lblDiveTotal setHidden:NO];
        [self.lblBoardSize setHidden:NO];
        
        DiveTotal *total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
        DiverBoardSize *bSize = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
        
        yesDives = [total.diveTotal stringValue];
        yesBoard = [bSize.firstSize stringValue];
        
        self.lblDiveTotal.text = [yesDives stringByAppendingString:@" Dives"];
        self.lblBoardSize.text = [yesBoard stringByAppendingString:@" Meter"];
        
    } else {
        
        // hide button and labels until a diver is choosen and has meet records
        [self.SCBoardSize setHidden:NO];
        [self.SCDiveTotals setHidden:NO];
        [self.lblDiveTotal setHidden:YES];
        [self.lblBoardSize setHidden:YES];
        
    }
    
}

-(void)writeNewDiveCollection {
    
    //here we will set the listfilled to nil, when they start creating a list
    // we will set it to 0 and then when finished set it to 1
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
    
}

-(void)DeleteAllDiverMeetInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    [diver RemoveDiverFromMeet:self.meetRecordID diverid:self.diverRecordID];
    
}

-(void)CheckForNoList {
    
    DiveList *list = [[DiveList alloc] init];
    
    self.noList = [list CheckForNoList:self.meetRecordID diverid:self.diverRecordID];
    
}

-(void)checkforListStarted {
    
    DiveList *list = [[DiveList alloc] init];
    
    self.listStarted = [list IsListFinished:self.meetRecordID diverid:self.diverRecordID];
}

@end
