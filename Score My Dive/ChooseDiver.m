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
#import "DiveTotal.h"
#import "DiverBoardSize.h"
#import "DiveListEnter.h"
#import "Results.h"

@interface ChooseDiver ()

@property (nonatomic, strong)NSArray *diverArray;
@property (nonatomic, strong) UIPickerView *divePicker;

-(void)loadSpinnerData;
-(void)getMeetName;
-(void)checkForPreviousMeetInfo;

@end

@implementation ChooseDiver

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.btnResetDiver setHidden:YES];
    [self.lblDiveTotal setHidden:YES];
    [self.lblBoardSize setHidden:YES];
    
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
    return [self.diverArray[row]objectAtIndex:1];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.txtChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
    [self.txtChooseDiver resignFirstResponder];
    self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
    
    [self checkForPreviousMeetInfo];
    
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
    
    DiveTotal *total = [[DiveTotal alloc] init];
    [total CreateDiveTotal:self.meetRecordID DiverID:self.diverRecordID Total:self.diveTotalID];
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    [board CreateBoardSize:self.meetRecordID DiverID:self.diverRecordID Total:self.boardSize1ID TotalBoards:1];
    
    //MeetCollection *meetsInfo = [[MeetCollection alloc] init];
    //[meetsInfo GetMeetCollection:self.meetRecordID];
}

- (IBAction)EnterScoresClick:(id)sender {
}

- (IBAction)ResetDiverClick:(id)sender {
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

-(void)checkForPreviousMeetInfo {
    
    NSArray *valid;
    
    Results *results = [[Results alloc] init];
    
    valid = [results GetResultObject:self.meetRecordID DiverId:self.diverRecordID];
    
    if (valid != nil) {
        
        [self.SCBoardSize setHidden:YES];
        [self.SCDiveTotals setHidden:YES];
        
    } else {
        
        // hide button and labels until a diver is choosen and has meet records
        [self.btnResetDiver setHidden:YES];
        [self.lblDiveTotal setHidden:YES];
        [self.lblBoardSize setHidden:YES];
        
    }
    
}

@end
