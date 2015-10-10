//
//  ChooseDiveNumber.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/22/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "ChooseDiveNumber.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "JudgeScores.h"
#import "DiveList.h"
#import "DiveListEnter.h"
#import "AlertControllerHelper.h"
#import "AppDelegate.h"

@interface ChooseDiveNumber ()

@property (nonatomic, strong) NSArray *diveGroupArray;
@property (nonatomic, strong) NSArray *diveArray;
@property (nonatomic, strong) UIPickerView *groupPicker;
@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) NSString *straight;
@property (nonatomic, strong) NSString *pike;
@property (nonatomic, strong) NSString *tuck;
@property (nonatomic, strong) NSString *free;
@property (nonatomic) int selectedPosition;

-(void)makeGroupPicker;
-(void)makeDivePicker;
-(void)loadGroupPicker;
-(void)loadDivePicker;
-(void)DisableDivePositions;
-(void)GetDiveDOD;
-(void)editDive;

@end

@implementation ChooseDiveNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self restrictRotation:YES];
    
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
    
    // we only want the keyboard popping up right away on the ipad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.txtDiveGroup becomeFirstResponder];
    }
    
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

-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}

// done button a picker
-(void)dateSelectionDone:(id)sender {
    
    [self.txtDiveGroup resignFirstResponder];
    [self.txtDive resignFirstResponder];
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

- (IBAction)btnEnter:(id)sender {
    
    self.selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    if (self.diveGroupID != 0 && self.diveID != 0 && self.selectedPosition >= 0) {
        
        // see who called depends on how we update or create a judgescore
        if (self.whoCalled == 1) {
            
            [self UpdateJudgeScores];
            // start the list
            if ([self.onDiveNumber isEqualToNumber:@1]) {
                
                [self updateListStarted];
            }
        } else if (self.whoCalled == 2) {
            [self editDive];
        }

        // call the delegate method to reload the class that called it and pop it off
        // this lets the class know who called them
        // 1 is the DiveListEnter
        // 2 is the DiveListEdit
        // 3 is the DiveEnter
        if (self.whoCalled == 1) {
            [self.delegate chooseDiveNumberWasFinished];
            
            // using the custome class dismiss the popover after passing instance of the class
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [self.controller dismissPopoverAnimated:YES];
                // else just dismiss the ViewController
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } else if (self.whoCalled == 2) {
            [self.delegate chooseDiveNumberWasFinished];
            
            // using the custome class dismiss the popover after passing instance of the class
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [self.controller dismissPopoverAnimated:YES];
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
                //[self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            // diveEnterDelegate - this may need to go right to score
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [AlertControllerHelper ShowAlert:@"Hold On!" message:@"Please make sure you've picked a dive and a valid position" view:self];

    }
}

#pragma private methods

-(void)UpdateJudgeScores {
    
    NSString *diveCategory;
    NSString *divePosition;
    NSString *diveNameForDB;
    NSNumber *multiplier;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Forward Dive";
                break;
            case 2:
                diveCategory = @"Back Dive";
                break;
            case 3:
                diveCategory = @"Reverse Dive";
                break;
            case 4:
                diveCategory = @"Inward Dive";
                break;
            case 5:
                diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Front Platform Dive";
                break;
            case 2:
                diveCategory = @"Back Platform Dive";
                break;
            case 3:
                diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (self.selectedPosition) {
        case 0:
            divePosition = @"A - Straight";
            break;
        case 1:
            divePosition = @"B - Pike";
            break;
        case 2:
            divePosition = @"C - Tuck";
            break;
        case 3:
            divePosition = @"D - Free";
            break;
    }
    
    diveNameForDB = self.txtDive.text;
    
    // use this dive number for the first entry
    NSNumber *firstDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber];
    
    // create a new dive number, just increment the old number
    NSNumber *newDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    multiplier = [formatString numberFromString:multi];
    
    // get a double value from the boardSize
    double boardSizeDouble = [self.boardSize doubleValue];
    
    if ([newDiveNumber isEqualToNumber:@1]) {
        
        // if this is the first dive we are just updating the first record we wrote
        [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:diveCategory divetype:diveNameForDB divepos:divePosition  multiplier:multiplier
                        oldDiveNumber:firstDiveNumber divenumber:self.onDiveNumber];
        
    } else {
        // create a new record
        [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:newDiveNumber divecategory:diveCategory divetype:diveNameForDB diveposition:divePosition failed:@0 multiplier:multiplier totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    }
}

-(void)editDive {
    
    NSString *diveCategory;
    NSString *divePosition;
    NSString *diveNameForDB;
    NSNumber *multiplier;
    //int selectedPosition = (int)self.SCPosition.selectedSegmentIndex;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // first lets see if these are Springboard or platform dives
    if ([self.boardSize isEqualToNumber:@1.0] || [self.boardSize isEqualToNumber:@3.0]) {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Forward Dive";
                break;
            case 2:
                diveCategory = @"Back Dive";
                break;
            case 3:
                diveCategory = @"Reverse Dive";
                break;
            case 4:
                diveCategory = @"Inward Dive";
                break;
            case 5:
                diveCategory = @"Twist Dive";
                break;
        }
    } else {
        switch (self.diveGroupID) {
            case 1:
                diveCategory = @"Front Platform Dive";
                break;
            case 2:
                diveCategory = @"Back Platform Dive";
                break;
            case 3:
                diveCategory = @"Reverse Platform Dive";
                break;
            case 4:
                diveCategory = @"Inward Platform Dive";
                break;
            case 5:
                diveCategory = @"Twist Platform Dive";
                break;
            case 6:
                diveCategory = @"Armstand Platform Dive";
                break;
        }
    }
    
    // then lets get the position into a string
    switch (self.selectedPosition) {
        case 0:
            divePosition = @"A - Straight";
            break;
        case 1:
            divePosition = @"B - Pike";
            break;
        case 2:
            divePosition = @"C - Tuck";
            break;
        case 3:
            divePosition = @"D - Free";
            break;
    }
    
    diveNameForDB = self.txtDive.text;
    
    // then get the multiplier
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc] init];
    NSString *multi = self.lblDivedd.text;
    multiplier = [formatString numberFromString:multi];
    
    // if this is the first dive we are just updating the first record we wrote
    [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:diveCategory divetype:diveNameForDB divepos:divePosition  multiplier:multiplier
                    oldDiveNumber:self.onDiveNumber divenumber:self.onDiveNumber];
    
}

-(void)updateListStarted {
    
    DiveList *list = [[DiveList alloc] init];
    
    [list updateListStarted:self.meetRecordID diverid:self.diverRecordID];
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
@end
