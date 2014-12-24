//
//  ReportsViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "ReportsViewController.h"
#import "Diver.h"
#import "Meet.h"
#import "Reports.h"

@interface ReportsViewController ()

@property (nonatomic) int diverRecordID;
@property (nonatomic) int meetRecordID;
@property (nonatomic) int reportRecordID;

@property (nonatomic, strong)NSArray *diverArray;
@property (nonatomic, strong)NSArray *meetArray;
@property (nonatomic, strong)NSMutableArray *reportArray;

@property (nonatomic, strong) UIPickerView *divePicker;
@property (nonatomic, strong) UIPickerView *meetPicker;
@property (nonatomic, strong) UIPickerView *reportPicker;

-(void) loadData;

@end

@implementation ReportsViewController

#pragma ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load the diver and meet arrays before creating the pickerviews
    [self loadData];
    
    // call the pickers
    [self makeDiverPicker];
    [self makeMeetPicker];
    [self makeReportPicker];
    
    self.txtxChooseDiver.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtxChooseDiver.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtxChooseDiver.layer.masksToBounds = NO;
    self.txtxChooseDiver.layer.shadowOpacity = .3;
    self.txtxChooseDiver.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtxChooseDiver.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtChooseMeet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseMeet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseMeet.layer.masksToBounds = NO;
    self.txtChooseMeet.layer.shadowOpacity = .3;
    self.txtChooseMeet.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseMeet.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtChooseReport.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseReport.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseReport.layer.masksToBounds = NO;
    self.txtChooseReport.layer.shadowOpacity = .3;
    self.txtChooseReport.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseReport.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

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

- (IBAction)sendClick:(id)sender {
    //TODO add the logic here to send the reports
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
    self.txtxChooseDiver.inputView = self.divePicker;
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

-(void)makeReportPicker{
    self.reportPicker = [[UIPickerView alloc] init];
    [self.reportPicker setBackgroundColor:[UIColor grayColor]];
    self.reportPicker.layer.shadowColor = [UIColor blackColor].CGColor;
    self.reportPicker.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.reportPicker.layer.masksToBounds = NO;
    self.reportPicker.layer.shadowOpacity = .3;
    self.reportPicker.dataSource = self;
    self.reportPicker.delegate = self;
    self.txtChooseReport.inputView = self.reportPicker;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.divePicker) {
        return self.diverArray.count;
    } else if (pickerView == self.meetPicker) {
        return self.meetArray.count;
    } else {
        return self.reportArray.count;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.divePicker) {
        
        // assign the first item in array to text box right away, so user doesn't have to
        self.txtxChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
        self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
        return [self.diverArray[row]objectAtIndex:1];
        
    } else if (pickerView == self.meetPicker) {
        
        // assign the first item in array to text box right away, so user doesn't have to
        self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
        self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
        return [self.meetArray[row]objectAtIndex:1];
        
    } else {
        
        // assign the first item in array to text box right away, so user doesn't have to
        self.txtChooseReport.text = [self.reportArray [row] objectAtIndex:1];
        self.reportRecordID = [[self.reportArray [row] objectAtIndex:0] intValue];
        return [self.reportArray[row]objectAtIndex:1];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.divePicker) {
        
        self.txtxChooseDiver.text = [self.diverArray [row] objectAtIndex:1];
        [self.txtxChooseDiver resignFirstResponder];
        self.diverRecordID = [[self.diverArray [row] objectAtIndex:0] intValue];
        
    } else if (pickerView == self.meetPicker) {
        
        self.txtChooseMeet.text = [self.meetArray [row] objectAtIndex:1];
        [self.txtChooseMeet resignFirstResponder];
        self.meetRecordID = [[self.meetArray [row] objectAtIndex:0] intValue];
        
    } else {
        
        self.txtChooseReport.text = [self.reportArray [row] objectAtIndex:1];
        [self.txtChooseReport resignFirstResponder];
        self.reportRecordID = [[self.reportArray [row] objectAtIndex:0] intValue];
        
    }
}

#pragma private methods

-(void)loadData {
    if (self.diverArray != nil) {
        self.diverArray = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.diverArray = [divers GetAllDivers];
    
    if (self.meetArray != nil) {
        self.meetArray = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.meetArray = [meets GetAllMeets];
    
    self.reportArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    [self.reportArray insertObject:[NSMutableArray arrayWithObjects:@"0", @"Meet Results", nil] atIndex:0];
    [self.reportArray insertObject:[NSMutableArray arrayWithObjects:@"0", @"Diver Score Total By Meet", nil] atIndex:1];
    [self.reportArray insertObject:[NSMutableArray arrayWithObjects:@"0", @"Diver Judge Scores By Meet", nil] atIndex:2];
    
}









































@end
