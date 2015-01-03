//
//  DiveEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/26/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveEnter.h"
#import "JudgeScores.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "Meet.h"
#import "Diver.h"
#import "DiverBoardSize.h"
#import "DiveTotal.h"
#import "DiveListScore.h"
#import "DiveListFinalScore.h"
#import "Results.h"
#import "MeetCollection.h"

@interface DiveEnter ()

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) NSNumber *onDiveNumber;
@property (nonatomic) int maxDiveNumber;
@property (nonatomic, strong) NSNumber *editDiveNumber;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic, strong) NSString *straight;
@property (nonatomic, strong) NSString *pike;
@property (nonatomic, strong) NSString *tuck;
@property (nonatomic, strong) NSString *free;
@property (nonatomic) BOOL allDivesEntered;
@property (nonatomic) int diveTotal;
@property (nonatomic, strong) NSNumber *scoreTotal;

// properties to send to the diveScore screen
@property (nonatomic, strong) NSString *diveCategory;
@property (nonatomic, strong) NSString *divePosition;
@property (nonatomic, strong) NSString *diveNameForDB;
@property (nonatomic, strong) NSNumber *multiplierToSend;
@property (nonatomic) int listOrNot;

-(void)LoadMeetCollection;
-(void)getTheDiveTotal;
-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)fillText;
-(void)DiverBoardSize;
-(void)fillDiveNumber;
-(void)fillDiveInfo;
-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)hideInitialControls;
-(void)DisableDivePositions;
-(void)GetDiveDOD;
-(void)UpdateDiveInfoToSend;
-(void)resetValues;
-(void)checkFinishedScoring;
-(void)ShowScoreTotal:(NSNumber*)scoretotal;

@end

@implementation DiveEnter

#pragma  view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadMeetCollection];
    [self getTheDiveTotal];
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self loadGroupPicker];
    [self makeGroupPicker];
    [self makeDivePicker];
    [self fillDiveInfo];
    [self checkFinishedScoring];
    
    // attributes for controls
    self.txtDiveGroup.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveGroup.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveGroup.layer.masksToBounds = NO;
    self.txtDiveGroup.layer.shadowRadius = 4.0f;
    self.txtDiveGroup.layer.shadowOpacity = .3;
    self.txtDiveGroup.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDiveGroup.delegate = self;
    
    self.txtDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDive.layer.masksToBounds = NO;
    self.txtDive.layer.shadowRadius = 4.0f;
    self.txtDive.layer.shadowOpacity = .3;
    self.txtDive.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDive.delegate = self;
    
    self.SCPosition.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCPosition.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCPosition.layer.masksToBounds = NO;
    self.SCPosition.layer.shadowOpacity = .7;
    
    self.btnEnterScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterScore.layer.masksToBounds = NO;
    self.btnEnterScore.layer.shadowOpacity = .7;
    
    self.btnEnterTotalScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterTotalScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterTotalScore.layer.masksToBounds = NO;
    self.btnEnterTotalScore.layer.shadowOpacity = .7;
    
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

-(IBAction)unwindToEnterDive:(UIStoryboardSegue*)sender {
    
    [self LoadMeetCollection];
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self loadGroupPicker];
    [self makeGroupPicker];
    [self makeDivePicker];
    [self fillDiveInfo];
    [self resetValues];
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the diveListScore
    if ([segue.identifier isEqualToString:@"idSegueDiveEnterToScore"]) {
        
        DiveListScore *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.diveCategory = self.diveCategory;
        score.divePosition = self.divePosition;
        score.diveNameForDB = self.diveNameForDB;
        score.multiplierToSend = self.multiplierToSend;
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListFinalScore
    if ([segue.identifier isEqualToString:@"idSegueDiveEnterToFinalScore"]) {
        
        DiveListFinalScore *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.diveCategory = self.diveCategory;
        score.divePosition = self.divePosition;
        score.diveNameForDB = self.diveNameForDB;
        score.multiplierToSend = self.multiplierToSend;
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListScore for Edit
    if ([segue.identifier isEqualToString:@"idEnterDivetoEditJudgeScores"]) {
        
        DiveListScore *score = [segue destinationViewController];
        
        self.listOrNot = 2;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListFinalScore for Edit
    if ([segue.identifier isEqualToString:@"idEnterDiveToEditFinalScore"]) {
        
        DiveListFinalScore *score = [segue destinationViewController];
        
        self.listOrNot = 2;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];  //TODO: we need to make sure this is correct?
        score.meetInfo = self.meetInfo;
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

-(void)makeGroupPicker {
    
    self.groupPicker = [[UIPickerView alloc] init];
    [self.groupPicker setBackgroundColor:[UIColor grayColor]];
    self.groupPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.groupPicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.groupPicker.layer.masksToBounds = NO;
    self.groupPicker.layer.shadowOpacity = .3;
    self.groupPicker.dataSource = self;
    self.groupPicker.delegate = self;
    self.txtDiveGroup.inputView = self.groupPicker;
    
}

-(void)makeDivePicker {
    
    self.divePicker = [[UIPickerView alloc] init];
    [self.divePicker setBackgroundColor:[UIColor grayColor]];
    self.divePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.divePicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.divePicker.layer.masksToBounds = NO;
    self.divePicker.layer.shadowOpacity = .3;
    self.divePicker.dataSource = self;
    self.divePicker.delegate = self;
    self.txtDive.inputView = self.divePicker;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView ==self.groupPicker) {
        return self.diveGroupArray.count;
    } else {
        return self.diveArray.count;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // when changing a cat show the correct dives in the type picker
            self.txtDive.text = [[self.diveArray objectAtIndex:0] objectAtIndex:3];
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            self.txtDive.text = [[self.diveArray objectAtIndex:0] objectAtIndex:4];
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
        // this will disable dive position choices based on cat, board, and dive type
        [self DisableDivePositions];
        
        // then this will set the divedod label to the correct dod
        [self GetDiveDOD];
        
        return [self.diveGroupArray[row]objectAtIndex:1];
        
    } else {
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            // assign the first item in array to text box right away, so user doesn't have to
            self.txtDive.text = [self.diveArray [row] objectAtIndex:3];
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            return [self.diveArray[row]objectAtIndex:3];
            
        } else {
            
            // assign the first item in array to text box right away, so user doesn't have to
            self.txtDive.text = [self.diveArray [row] objectAtIndex:4];
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            return [self.diveArray[row]objectAtIndex:4];
            
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        [self.txtDiveGroup resignFirstResponder];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        // empty and reload the type picker after a category has been changed
        self.diveArray= nil;
        [self.divePicker reloadAllComponents];
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            // when changing a cat show the correct dives in the type picker
            self.txtDive.text = [[self.diveArray objectAtIndex:0] objectAtIndex:3];
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            self.txtDive.text = [[self.diveArray objectAtIndex:0] objectAtIndex:4];
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
    } else {
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
            self.txtDive.text = [self.diveArray [row] objectAtIndex:3];
            [self.txtDive resignFirstResponder];
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
        } else {
            
            self.txtDive.text = [self.diveArray [row] objectAtIndex:4];
            [self.txtDive resignFirstResponder];
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
        }
    }
    
    // this will disable dive position choices based on cat, board, and dive type
    [self DisableDivePositions];
    
    // then this will set the divedod label to the correct dod
    [self GetDiveDOD];
}

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender {
    
    switch (self.SCPosition.selectedSegmentIndex) {
        case 0:
            self.divePositionID = 0;
            self.lblDivedd.text = self.straight;
            break;
        case 1:
            self.divePositionID = 1;
            self.lblDivedd.text = self.pike;
            break;
        case 2:
            self.divePositionID = 2;
            self.lblDivedd.text = self.tuck;
            break;
        case 3:
            self.divePositionID = 3;
            self.lblDivedd.text = self.free;
            break;
    }
}

- (IBAction)btnEnterScoreClick:(id)sender {
    
    int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    if (self.diveGroupID != 0 && self.diveID != 0 && selectedPosition >= 0) {
        
        [self UpdateDiveInfoToSend];
        
        [self performSegueWithIdentifier:@"idSegueDiveEnterToScore" sender:self];
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please make sure you've picked a dive and a valid position"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
    
}

- (IBAction)btnEnterTotalScoreClick:(id)sender {
    
    int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    if (self.diveGroupID != 0 && self.diveID != 0 && selectedPosition >= 0) {
        
        [self UpdateDiveInfoToSend];
        
        [self performSegueWithIdentifier:@"idSegueDiveEnterToFinalScore" sender:self];
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please make sure you've picked a dive and a valid position"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
    
}


- (IBAction)lblOptionsClick:(id)sender {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Edit a Score"
                                                    message:@"To edit a score just long-press the score for the dive you want to edit."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
}

- (IBAction)Dive1EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                   actionWithTitle:@"Edit Judge Scores"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Judges Action");
                                       // send to the DiveListScore
                                       self.onDiveNumber = @1;
                                       [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                      
                                   }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @1;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive2EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @2;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @2;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive3EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @3;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @3;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive4EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @4;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @4;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive5EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @5;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @5;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive6EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @6;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @6;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive7EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @7;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @7;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive8EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @8;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @8;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive9EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @9;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @9;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive10EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @10;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @10;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)Dive11EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @11;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @11;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma private methods

-(void)LoadMeetCollection {
    
    MeetCollection *meets = [[MeetCollection alloc] init];
    self.meetInfo = [meets GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
}

-(void)getTheDiveTotal {
    
    DiveTotal *total = [[DiveTotal alloc] init];
    
    total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    
    self.diveTotal = [total.diveTotal intValue];
    
}

-(void)UpdateDiveInfoToSend {
    
    NSString *diveName;
    int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                self.diveCategory = @"Forward Dive";
                break;
            case 2:
                self.diveCategory = @"Back Dive";
                break;
            case 3:
                self.diveCategory = @"Reverse Dive";
                break;
            case 4:
                self.diveCategory = @"Inward Dive";
                break;
            case 5:
                self.diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                self.diveCategory = @"Front Platform Dive";
                break;
            case 2:
                self.diveCategory = @"Back Platform Dive";
                break;
            case 3:
                self.diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                self.diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                self.diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                self.diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (selectedPosition) {
        case 0:
            self.divePosition = @"A - Straight";
            break;
        case 1:
            self.divePosition = @"B - Pike";
            break;
        case 2:
            self.divePosition = @"C - Tuck";
            break;
        case 3:
            self.divePosition = @"D - Free";
            break;
    }
    
    // get the dive name and then append it to the diveid
    diveName = self.txtDive.text;
    self.diveNameForDB = [NSString stringWithFormat:@"%d", self.diveID];
    self.diveNameForDB = [self.diveNameForDB stringByAppendingString:@" - "];
    self.diveNameForDB = [self.diveNameForDB stringByAppendingString:diveName];
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    self.multiplierToSend = [formatString numberFromString:multi];

}

-(void)loadGroupPicker {
    
    if (self.diveGroupArray != nil) {
        self.diveGroupArray = nil;
    }
    
    if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
        
        DiveCategory *cat = [[DiveCategory alloc] init];
        self.diveGroupArray = [cat GetSpringboardCategories];
        
    }
    else {
        
        DiveCategory *cat = [[DiveCategory alloc] init];
        self.diveGroupArray = [cat GetPlatformCategories];
    }
}

-(void)loadDivePicker {
    
    if (self.diveArray != nil) {
        self.diveArray = nil;
    }
    
    // call the class to decide which dives get loaded based on category and board size
    DiveTypes *types = [[DiveTypes alloc] init];
    self.diveArray = [types LoadDivePicker:self.diveGroupID BoardSize:self.boardSize];
}

-(void)fillText {
    
    // meet info
    Meet *meet = [[Meet alloc] init];
    meet = [self.meetInfo objectAtIndex:0];
    self.lblMeetName.text = meet.meetName;
    
    // diver info
    Diver *diver = [[Diver alloc] init];
    diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    self.lblDiverName.text = diver.Name;
    
}

-(void)DiverBoardSize {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    self.boardSize = board.firstSize;
    
    NSNumber *boardSize = board.firstSize;
    
    NSString *boardSizeText = [boardSize stringValue];
    
    boardSizeText = [boardSizeText stringByAppendingString:@" Meter"];
    
    self.lblBoardType.text = boardSizeText;
    
}

-(void)fillDiveNumber {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    self.maxDiveNumber = [scores GetMaxDiveNumber:self.meetRecordID diverid:self.diverRecordID];
    
    // we need to see what the dive total is first and set it for the whole class
    DiveTotal *total = [[DiveTotal alloc] init];
    total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = [total.diveTotal intValue];
    
    NSString *diveNum = @"Dive ";
    // here we will set the value for the whole class to use
    self.onDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
    
    diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.onDiveNumber]];
    self.lblDiveNumber.text = diveNum;
    
}

-(void)DisableDivePositions {
    
    NSArray *dods = [[NSArray alloc] init];
    
    // lets get the valid dods based on group, type and board size
    DiveTypes *types = [[DiveTypes alloc] init];
    dods = [types GetAllDiveDODs:self.diveGroupID DiveTypeId:self.diveID BoardType:self.boardSize];
    
    // now put those into a NSNumber variable
    self.straight = [[dods objectAtIndex:0] objectAtIndex:0];
    self.pike = [[dods objectAtIndex:0] objectAtIndex:1];
    self.tuck = [[dods objectAtIndex:0] objectAtIndex:2];
    self.free = [[dods objectAtIndex:0] objectAtIndex:3];
    
    if ([self.straight isEqualToString:@"0.0"]) {
        [self.SCPosition setEnabled:NO forSegmentAtIndex:0];
    } else {
        [self.SCPosition setEnabled:YES forSegmentAtIndex:0];
    }
    
    if ([self.pike isEqualToString:@"0.0"]) {
        [self.SCPosition setEnabled:NO forSegmentAtIndex:1];
    } else {
        [self.SCPosition setEnabled:YES forSegmentAtIndex:1];
    }
    
    if ([self.tuck isEqualToString:@"0.0"]) {
        [self.SCPosition setEnabled:NO forSegmentAtIndex:2];
    } else {
        [self.SCPosition setEnabled:YES forSegmentAtIndex:2];
    }
    
    if ([self.free isEqualToString:@"0.0"]) {
        [self.SCPosition setEnabled:NO forSegmentAtIndex:3];
    } else {
        [self.SCPosition setEnabled:YES forSegmentAtIndex:3];
    }
}

-(void)GetDiveDOD {
    
    switch (self.SCPosition.selectedSegmentIndex) {
        case 0:
            self.divePositionID = 0;
            self.lblDivedd.text = self.straight;
            break;
        case 1:
            self.divePositionID = 1;
            self.lblDivedd.text = self.pike;
            break;
        case 2:
            self.divePositionID = 2;
            self.lblDivedd.text = self.tuck;
            break;
        case 3:
            self.divePositionID = 3;
            self.lblDivedd.text = self.free;
            break;
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
    
    // lets get the results from the meetcollection object for the whole method to use
    score = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:5];
    
    if (self.maxDiveNumber >= 1) {
        
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
        
        self.lblDive1.text = diveInfoText;
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
        [self.view1 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 2) {
        
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
        
        self.lblDive2.text = diveInfoText;
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
        [self.view2 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 3) {
        
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
        
        self.lblDive3.text = diveInfoText;
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
        [self.view3 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 4) {
        
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
        
        self.lblDive4.text = diveInfoText;
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
        [self.view4 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 5) {
        
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
        
        self.lblDive5.text = diveInfoText;
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
        [self.view5 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 6) {
        
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
        
        self.lblDive6.text = diveInfoText;
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
        [self.view6 setUserInteractionEnabled:YES];
    }
    
    // we won't even bother checking these unless the diveTotal is 11
    if (self.diveTotal == 11) {
        if (self.maxDiveNumber >= 7) {
            
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
            
            self.lblDive7.text = diveInfoText;
            [self.lblDive7 setHidden:NO];
            [self.lblDive7text setHidden:NO];
            [self.view7 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 8) {
            
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
            
            self.lblDive8.text = diveInfoText;
            [self.lblDive8 setHidden:NO];
            [self.lblDive8text setHidden:NO];
            [self.view8 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 9) {
            
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
            
            self.lblDive9.text = diveInfoText;
            [self.lblDive9 setHidden:NO];
            [self.lblDive9text setHidden:NO];
            [self.view9 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 10) {
            
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
            
            self.lblDive10.text = diveInfoText;
            [self.lblDive10 setHidden:NO];
            [self.lblDive10text setHidden:NO];
            [self.view10 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 11) {
            
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
            
            self.lblDive11.text = diveInfoText;
            [self.lblDive11 setHidden:NO];
            [self.lblDive11text setHidden:NO];
            [self.view11 setUserInteractionEnabled:YES];
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
    
    if (self.diveTotal == self.maxDiveNumber) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Congradulations!"
                                                        message:@"Scoring is complete for this diver"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
        [self.txtDiveGroup setEnabled:NO];
        [self.txtDive setEnabled:NO];
        [self.btnEnterScore setEnabled:NO];
        [self.btnEnterTotalScore setEnabled:NO];
        [self.SCPosition setEnabled:NO];
        self.lblDivedd.text = @"";
        self.lblDiveNumber.text = @"Finished";
    }
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
    [self.view1 setUserInteractionEnabled:NO];
    [self.view2 setUserInteractionEnabled:NO];
    [self.view3 setUserInteractionEnabled:NO];
    [self.view4 setUserInteractionEnabled:NO];
    [self.view5 setUserInteractionEnabled:NO];
    [self.view6 setUserInteractionEnabled:NO];
    [self.view7 setUserInteractionEnabled:NO];
    [self.view8 setUserInteractionEnabled:NO];
    [self.view9 setUserInteractionEnabled:NO];
    [self.view10 setUserInteractionEnabled:NO];
    [self.view11 setUserInteractionEnabled:NO];
    
}

-(void)resetValues {
    
    self.txtDiveGroup.text = @"";
    self.txtDive.text = @"";
    self.SCPosition.selectedSegmentIndex = -0;
    self.lblDivedd.text = @"0.0";
    
    self.diveGroupID = 0;
    self.diveID = 0;
    
}

@end
