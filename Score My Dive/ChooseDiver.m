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

@interface ChooseDiver ()

@property (nonatomic, strong)NSArray *diverArray;

@property (nonatomic, strong) UIPickerView *divePicker;

-(void)loadSpinnerData;
-(void)getMeetName;

@end

@implementation ChooseDiver

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMeetName];
    
    [self loadSpinnerData];
    
    [self makeDiverPicker];
    
    self.txtChooseDiver.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseDiver.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseDiver.layer.masksToBounds = NO;
    self.txtChooseDiver.layer.shadowRadius = 4.0f;
    self.txtChooseDiver.layer.shadowOpacity = .3;
    self.txtChooseDiver.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.radioDiveTotals.layer.shadowColor = [UIColor blackColor].CGColor;
    self.radioDiveTotals.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.radioDiveTotals.layer.masksToBounds = NO;
    self.radioDiveTotals.layer.shadowRadius = 4.0f;
    self.radioDiveTotals.layer.shadowOpacity = .3;
    
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

@end
