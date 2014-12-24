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
@property (nonatomic, strong) NSNumber *judgeTotal;

@property (nonatomic, strong) UIPickerView *meetPicker;

-(void)loadData;
-(void)ShowJudgeTotal;

@end

@implementation ChooseMeet

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self makeMeetPicker];
    
    self.txtChooseMeet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseMeet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseMeet.layer.masksToBounds = NO;
    self.txtChooseMeet.layer.shadowOpacity = .3;
    self.txtChooseMeet.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseMeet.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
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
    
    // update the control
    [self ShowJudgeTotal];
    
    return [self.meetArray[row]objectAtIndex:1];
   
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // sets the text box for the choosen meet
    self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
    
    [self.txtChooseMeet resignFirstResponder];
    self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
    
    // update the judge control again
    [self ShowJudgeTotal];
   
}

#pragma private methods

-(void)loadData {
    
    if (self.meetArray != nil) {
        self.meetArray = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.meetArray = [meets GetAllMeets];
    
}

-(void)ShowJudgeTotal {
    
    Judges *judges = [[Judges alloc] init];
    self.judgeTotal = [judges getJudges:self.meetRecordID];
    
    if ([self.judgeTotal  isEqualToNumber: @2]) {
        self.lblJudges.text = @"2 Judges";
        NSLog(@"Judges total is %@", self.judgeTotal);
    } else if ([self.judgeTotal isEqualToNumber:@3]) {
        self.lblJudges.text = @"3 Judges";
        NSLog(@"Judges total is %@", self.judgeTotal);
    } else if ([self.judgeTotal  isEqualToNumber: @5]) {
        self.lblJudges.text = @"5 Judges";
        NSLog(@"Judges total is %@", self.judgeTotal);
    } else if ([self.judgeTotal  isEqualToNumber: @7]) {
        self.lblJudges.text = @"7 Judges";
        NSLog(@"Judges total is %@", self.judgeTotal);
    } else {
        self.lblJudges.text = @"2 Judges";
        NSLog(@"Judges total is %@", self.judgeTotal);
        self.judgeTotal = @2;
    }
    
}

@end
