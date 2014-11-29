//
//  ChooseMeet.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "ChooseMeet.h"
#import "ChooseDiver.h"
#import "Meet.h"
#import "Judges.h"

@interface ChooseMeet ()

@property (nonatomic, strong)NSArray *meetArray;

@property (nonatomic, strong) UIPickerView *meetPicker;

-(void)loadData;

@end

@implementation ChooseMeet

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.judgeTotal = @2;
    
    [self loadData];
    
    [self makeMeetPicker];
    
    self.txtChooseMeet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseMeet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseMeet.layer.masksToBounds = NO;
    //self.txtChooseMeet.layer.shadowRadius = 4.0f;
    self.txtChooseMeet.layer.shadowOpacity = .3;
    self.txtChooseMeet.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.SCJudges.layer.shadowColor = [UIColor blackColor].CGColor;
    self.SCJudges.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.SCJudges.layer.masksToBounds = NO;
    //self.SCJudges.layer.shadowRadius = 4.0f;
    self.SCJudges.layer.shadowOpacity = .7;

    // color attributes for the segmented controls
    NSDictionary *segmentedControlTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateHighlighted];
    [[UISegmentedControl appearance] setTitleTextAttributes:segmentedControlTextAttributes forState:UIControlStateSelected];
    
    [self.SCJudges setHidden:YES];
    [self.lblJudges setHidden:YES];
}

// push id to next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"idMeetSegue"]) {
   
    ChooseDiver *chooseDiver = [segue destinationViewController];
    chooseDiver.meetRecordID = self.meetRecordID;
        
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

-(IBAction)unwindToChooseMeet:(UIStoryboardSegue *)segue{
    
}

- (IBAction)nextClick:(id)sender {
    
    if (self.txtChooseMeet.text.length != 0) {
        
        Judges *judges = [[Judges alloc] init];
        [judges UpdateJudges:self.meetRecordID Total:self.judgeTotal];
        
        
        [self performSegueWithIdentifier:@"idMeetSegue" sender:self];
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please Pick a Meet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)JudgesClick:(UISegmentedControl *)sender {
    
    switch (self.SCJudges.selectedSegmentIndex) {
        case 0:
            self.judgeTotal = @2;
            break;
        case 1:
            self.judgeTotal = @3;
            break;
        case 2:
            self.judgeTotal = @5;
            break;
        case 3:
            self.judgeTotal = @7;
            break;
    }
}

-(void)makeMeetPicker{
    self.meetPicker = [[UIPickerView alloc] init];
    [self.meetPicker setBackgroundColor:[UIColor grayColor]];
    self.meetPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.meetPicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.meetPicker.layer.masksToBounds = NO;
    self.meetPicker.layer.shadowOpacity = .3;
    self.meetPicker.dataSource = self;
    self.meetPicker.delegate = self;
    self.txtChooseMeet.inputView = self.meetPicker;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.meetArray.count;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // assign the first item in array to text box right away, so user doesn't have to
    self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
    // get the meet id to see if a judge total has been picked yet
    self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
    
    // set the visiblity of the judge controls once a row is shown
    [self.lblJudges setHidden:NO];
    [self.SCJudges setHidden:NO];
    
    // update the control
    [self updateJudgeControls];
    
    return [self.meetArray[row]objectAtIndex:1];
   
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // sets the text box for the choosen meet
    self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
    
    // update the judge control again
    [self updateJudgeControls];
    [self.txtChooseMeet resignFirstResponder];
    self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
   
}

#pragma private methods

-(void)loadData {
    
    if (self.meetArray != nil) {
        self.meetArray = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.meetArray = [meets GetAllMeets];
    
}

-(void)updateJudgeControls {
    
    Judges *judges = [[Judges alloc] init];
    self.judgeTotal = [judges getJudges:self.meetRecordID];
    
    if ([self.judgeTotal  isEqualToNumber: @2]) {
        self.SCJudges.selectedSegmentIndex = 0;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal isEqualToNumber:@3]) {
        self.SCJudges.selectedSegmentIndex = 1;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @5]) {
        self.SCJudges.selectedSegmentIndex = 3;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else if ([self.judgeTotal  isEqualToNumber: @7]) {
        self.SCJudges.selectedSegmentIndex = 4;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
    } else {
        self.SCJudges.selectedSegmentIndex = 0;
        NSLog(@"Judges total is %@", self.judgeTotal);
        NSLog(@"index is %ld", (long)self.SCJudges.selectedSegmentIndex);
        self.judgeTotal = @2;
    }
    
}

@end
