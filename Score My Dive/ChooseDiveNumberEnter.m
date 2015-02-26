//
//  ChooseDiveNumberEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/24/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "ChooseDiveNumberEnter.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "DiveListScore.h"
#import "DiveListFinalScore.h"

@interface ChooseDiveNumberEnter ()

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) NSString *straight;
@property (nonatomic, strong) NSString *pike;
@property (nonatomic, strong) NSString *tuck;
@property (nonatomic, strong) NSString *free;
@property (nonatomic) int selectedPosition;

// properties to send to the diveScore screen
@property (nonatomic, strong) NSString *diveCategory;
@property (nonatomic, strong) NSString *divePosition;
@property (nonatomic, strong) NSString *diveNameForDB;
@property (nonatomic, strong) NSNumber *multiplierToSend;

-(void)UpdateDiveInfoToSend;
-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)DisableDivePositions;
-(void)GetDiveDOD;

@end

@implementation ChooseDiveNumberEnter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundPanel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel.layer.masksToBounds = NO;
    self.backgroundPanel.layer.shadowOpacity = 1.0;
    
    self.txtDiveGroup.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDiveGroup.delegate = self;
    
    self.txtDive.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtDive.delegate = self;
    
    self.SCPosition.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCPosition.layer.shadowOffset = CGSizeMake(.5f, .5f);
    self.SCPosition.layer.masksToBounds = NO;
    self.SCPosition.layer.shadowOpacity = 1.0;
    
    self.popoverPresentationController.backgroundColor = [UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1];
    
    // color attributes for the segmented controls
    NSDictionary *segmentedControlTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    
    NSDictionary *segmentedControlTextAttributesPicked = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    
    NSDictionary *segmentedControlDisabled = @{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlDisabled forState:UIControlStateDisabled];
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateHighlighted];
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributesPicked forState:UIControlStateSelected];
    
    [self.txtDiveGroup becomeFirstResponder];
    
    // add a done button to the date picker
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    toolbar.barTintColor = [UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(dateSelectionDone:)];
    
    toolbar.items = [[NSArray alloc] initWithObjects:barButtonDone, nil];
    barButtonDone.tintColor = [UIColor blackColor];
    self.txtDiveGroup.inputAccessoryView = toolbar;
    self.txtDive.inputAccessoryView = toolbar;
    
    [self makeGroupPicker];
    [self makeDivePicker];
    [self loadGroupPicker];
    [self DisableDivePositions];
}

// done button a picker
-(void)dateSelectionDone:(id)sender {
    
    [self.txtDiveGroup resignFirstResponder];
    [self.txtDive resignFirstResponder];
}

// restore state because Apple doesn't know how to write a modern OS
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    NSNumber *segment = [NSNumber numberWithInt:(int)self.SCPosition.selectedSegmentIndex];
    [coder encodeObject:segment forKey:@"segment"];
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeObject:self.txtDiveGroup.text forKey:@"diveGroupText"];
    [coder encodeInt:self.diveGroupID forKey:@"diveGroupId"];
    [coder encodeObject:self.txtDive.text forKey:@"diveText"];
    [coder encodeInt:self.diveID forKey:@"diveId"];
    [coder encodeInt:self.divePositionID forKey:@"divePos"];
    [coder encodeObject:self.diveGroupArray forKey:@"diveGroupArray"];
    [coder encodeObject:self.diveArray forKey:@"diveArray"];
    [coder encodeObject:self.lblDivedd.text forKey:@"dd"];
    [coder encodeObject:self.straight forKey:@"straight"];
    [coder encodeObject:self.tuck forKey:@"tuck"];
    [coder encodeObject:self.pike forKey:@"pike"];
    [coder encodeObject:self.free forKey:@"free"];
    [coder encodeObject:self.boardSize forKey:@"board"];
    [coder encodeInt:self.listOrNot forKey:@"listOrNot"];
    [coder encodeObject:self.onDiveNumber forKey:@"onDiveNumber"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.SCPosition.selectedSegmentIndex = [[coder decodeObjectForKey:@"segment"] intValue];
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.txtDiveGroup.text = [coder decodeObjectForKey:@"diveGroupText"];
    if (self.txtDiveGroup.text.length == 0) {
        self.txtDiveGroup.text = @"";
    }
    self.diveGroupID = [coder decodeIntForKey:@"diveGroupId"];
    self.txtDive.text = [coder decodeObjectForKey:@"diveText"];
    if (self.txtDive.text.length == 0) {
        self.txtDive.text = @"";
    }
    self.diveID = [coder decodeIntForKey:@"diveId"];
    self.divePositionID = [coder decodeIntForKey:@"divePos"];
    self.diveGroupArray = [coder decodeObjectForKey:@"diveGroupArray"];
    self.diveArray = [coder decodeObjectForKey:@"diveArray"];
    self.lblDivedd.text = [coder decodeObjectForKey:@"dd"];
    self.straight = [coder decodeObjectForKey:@"straight"];
    self.tuck = [coder decodeObjectForKey:@"tuck"];
    self.pike = [coder decodeObjectForKey:@"pike"];
    self.free = [coder decodeObjectForKey:@"free"];
    self.boardSize = [coder decodeObjectForKey:@"board"];
    self.listOrNot = [coder decodeIntForKey:@"listOrNot"];
    self.onDiveNumber = [coder decodeObjectForKey:@"onDiveNumber"];
    
    [self loadDivePicker];
    [self DisableDivePositions];
}

-(void)makeGroupPicker {
    
    self.groupPicker = [[UIPickerView alloc] init];
    [self.groupPicker setBackgroundColor:[UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1]];
    self.groupPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.groupPicker.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.groupPicker.layer.masksToBounds = NO;
    self.groupPicker.layer.shadowOpacity = 1.0;
    self.groupPicker.dataSource = self;
    self.groupPicker.delegate = self;
    self.txtDiveGroup.inputView = self.groupPicker;
    
}

-(void)makeDivePicker {
    
    self.divePicker = [[UIPickerView alloc] init];
    [self.divePicker setBackgroundColor:[UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1]];
    self.divePicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.divePicker.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.divePicker.layer.masksToBounds = NO;
    self.divePicker.layer.shadowOpacity = 1.0;
    self.divePicker.dataSource = self;
    self.divePicker.delegate = self;
    self.txtDive.inputView = self.divePicker;
    
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the diveListScore
    if ([segue.identifier isEqualToString:@"SegueChooseEnterToJudge"]) {
        
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
    if ([segue.identifier isEqualToString:@"SegueChooseEnterToTotal"]) {
        
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide the PickerView on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
        
        [self.SCPosition setEnabled:YES];
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [[self.diveArray objectAtIndex:0] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[[self.diveArray objectAtIndex:0] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [[self.diveArray objectAtIndex:0] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[[self.diveArray objectAtIndex:0] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
        // this will disable dive position choices based on cat, board, and dive type
        [self DisableDivePositions];
        
        // then this will set the divedod label to the correct dod
        [self GetDiveDOD];
        
        return [self.diveGroupArray[row]objectAtIndex:1];
        
    } else {
        
        [self.SCPosition setEnabled:YES];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // assign the first item in array to text box right away, so user doesn't have to
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            return diveText;
            
        } else {
            
            // assign the first item in array to text box right away, so user doesn't have to
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
            // this will disable dive position choices based on cat, board, and dive type
            [self DisableDivePositions];
            
            // then this will set the divedod label to the correct dod
            [self GetDiveDOD];
            
            return diveText;
            
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.groupPicker) {
        
        self.txtDiveGroup.text = [self.diveGroupArray [row] objectAtIndex:1];
        self.diveGroupID = [[self.diveGroupArray [row] objectAtIndex:0] intValue];
        
        // empty and reload the type picker after a category has been changed
        self.diveArray= nil;
        [self.divePicker reloadAllComponents];
        [self loadDivePicker];
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        } else {
            
            // when changing a cat show the correct dives in the type picker
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
            self.diveID = [[[self.diveArray objectAtIndex:0] objectAtIndex:0] intValue];
            
        }
        
    } else {
        
        if ([self.boardSize  isEqual: @1.0] || [self.boardSize  isEqual: @3.0]) {
            
            // lets add the dive number to the dive name
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:3]];
            self.txtDive.text = diveText;
            self.diveID = [[self.diveArray [row] objectAtIndex:0] intValue];
            
        } else {
            
            // lets add the dive number to the dive name
            NSString *diveText = [self.diveArray [row] objectAtIndex:0];
            diveText = [diveText stringByAppendingString:@" - "];
            diveText = [diveText stringByAppendingString:[self.diveArray [row] objectAtIndex:4]];
            self.txtDive.text = diveText;
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
    
    // then this will set the divedod label to the correct dod
    [self GetDiveDOD];
}

- (IBAction)btnEnterScores:(id)sender {
    
    self.selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    if (self.diveGroupID != 0 && self.diveID != 0 && self.selectedPosition >= 0) {
        
        [self UpdateDiveInfoToSend];
        
        [self performSegueWithIdentifier:@"SegueChooseEnterToJudge" sender:self];
        
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

- (IBAction)btnEnterTotalScores:(id)sender {
    
    self.selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    if (self.diveGroupID != 0 && self.diveID != 0 && self.selectedPosition >= 0) {
        
        [self UpdateDiveInfoToSend];
        
        [self performSegueWithIdentifier:@"SegueChooseEnterToTotal" sender:self];
        
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
    
    // call the class to decide which dives get loaded based on category and board size
    DiveTypes *types = [[DiveTypes alloc] init];
    self.diveArray = [types LoadDivePicker:self.diveGroupID BoardSize:self.boardSize];
    
}

-(void)DisableDivePositions {
    
    if (self.txtDive.text.length > 0) {
        
        // set the segmented control back to enabled
        [self.SCPosition setEnabled:YES];
        
        // lets get the valid dods based on group, type and board size
        DiveTypes *types = [[DiveTypes alloc] init];
        NSArray *dods = [types GetAllDiveDODs:self.diveGroupID DiveTypeId:self.diveID BoardType:self.boardSize];
        
        if (dods.count > 0) {
            
            
            
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
            
        } else {
            // disable the segmented control until a dive has been chosen
            [self.SCPosition setEnabled:NO];
        }
    } else {
        
        // disable the segmented control until a dive has been chosen
        [self.SCPosition setEnabled:NO];
    }
}

-(void)GetDiveDOD {
    
    if (self.txtDiveGroup.text.length > 0) {  // or on the pickers and SC
        
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
}

-(void)UpdateDiveInfoToSend {
    
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
    switch (self.selectedPosition) {
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

    self.diveNameForDB = self.txtDive.text;
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    self.multiplierToSend = [formatString numberFromString:multi];
    
}

@end
