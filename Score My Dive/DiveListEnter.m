//
//  DiveListEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListEnter.h"
#import "Diver.h"
#import "Meet.h"
#import "DiveTotal.h"
#import "DiverBoardSize.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "DiveNumber.h"
#import "JudgeScores.h"

@interface DiveListEnter ()

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) NSNumber *onDiveNumber;
@property (nonatomic, strong) NSNumber *boardSize;

-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)fillText;
-(void)DiverBoardSize;
-(void)fillDiveNumber;
-(void)fillDiveInfo;
-(void)calcDiveDD;
-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)hideInitialControls;

@end

@implementation DiveListEnter

#pragma ViewController Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fillText];
    
    [self fillDiveNumber];
    
    [self DiverBoardSize];
    
    [self loadGroupPicker];
    
    [self makeGroupPicker];
    
    // sets the scroll view content size
    self.scrollView.contentSize = CGSizeMake(0, self.scrollView.bounds.size.height);
    
    // attributes for controls
    self.txtDiveGroup.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDiveGroup.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDiveGroup.layer.masksToBounds = NO;
    self.txtDiveGroup.layer.shadowRadius = 4.0f;
    self.txtDiveGroup.layer.shadowOpacity = .3;
    
    self.txtDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtDive.layer.masksToBounds = NO;
    self.txtDive.layer.shadowRadius = 4.0f;
    self.txtDive.layer.shadowOpacity = .3;
    
    self.SCPosition.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCPosition.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCPosition.layer.masksToBounds = NO;
    self.SCPosition.layer.shadowOpacity = .7;
    
    self.btnEnterDive.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnEnterDive.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnEnterDive.layer.masksToBounds = NO;
    self.btnEnterDive.layer.shadowOpacity = .7;
  
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
    
    // lets hide some controls
    [self hideInitialControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToEnterDiveList:(UIStoryboardSegue*)sender {
    
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if([segue.identifier isEqualToString:@"idSegueDiveList"]) {
//        
//        DiveListEnter *diver = [segue destinationViewController];
//        diver.meetRecordID = self.meetRecordID;
//        diver.diverRecordID = self.diverRecordID;
}

// hide the PickerView on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
        return [self.diveGroupArray[row]objectAtIndex:1];
        
    } else {
        
        // assign the first item in array to text box right away, so user doesn't have to
        self.txtDive.text = [self.diveArray [row] objectAtIndex:3];
        self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
        return [self.diveArray[row]objectAtIndex:3];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        [self.txtDiveGroup resignFirstResponder];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        //when a different dive cat is chosen take out the entry in the txtDive
        self.txtDive.text = @"";
        
        [self loadDivePicker];
        
    } else {
        
        self.txtDive.text = [self.diveArray [row] objectAtIndex:3];
        [self.txtDive resignFirstResponder];
        self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
        
    }
}


- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender {
    
    switch (self.SCPosition.selectedSegmentIndex) {
        case 0:
            self.divePositionID = 0;
            break;
        case 1:
            self.divePositionID = 1;
            break;
        case 2:
            self.divePositionID = 2;
            break;
        case 3:
            self.divePositionID = 3;
            break;
    }
}

- (IBAction)btnEnterDive:(id)sender {
    
    //TODO: enter logic to write info to the tables
    
}

#pragma private methods

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
    
    DiveTypes *types = [[DiveTypes alloc] init];
    
    self.diveArray = [types LoadDivePicker:self.diveGroupID BoardSize:self.boardSize];
    
    [self makeDivePicker];
    
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
    
}

-(void)fillDiveNumber {
    
    NSString *diveNum = @"Dive ";
    
    DiveNumber *number = [[DiveNumber alloc] init];
    number = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:3];
    // here we will set the value for the whole class to use
    self.onDiveNumber = number.number;
    diveNum = [diveNum stringByAppendingString:[number.number stringValue]];
    self.lblDiveNumber.text = diveNum;
}

// call this from the load event?
-(void)calcDiveDD {
    
}

-(void)fillDiveInfo {
    
    JudgeScores *diveInfo = [[JudgeScores alloc] init];
    
    if ((int)self.onDiveNumber >= 1) {
        self.lblDive1.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 2) {
        self.lblDive2.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 3) {
        self.lblDive3.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 4) {
        self.lblDive4.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 5) {
        self.lblDive5.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 6) {
        self.lblDive6.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 7) {
        self.lblDive7.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive7 setHidden:NO];
        [self.lblDive7text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 8) {
        self.lblDive8.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive8 setHidden:NO];
        [self.lblDive8text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 9) {
        self.lblDive9.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive9 setHidden:NO];
        [self.lblDive9text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 10) {
        self.lblDive10.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive10 setHidden:NO];
        [self.lblDive10text setHidden:NO];
        
    }
    
    if ((int)self.onDiveNumber >= 11) {
        self.lblDive11.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.onDiveNumber];
        [self.lblDive11 setHidden:NO];
        [self.lblDive11text setHidden:NO];
        
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
    
}

@end
