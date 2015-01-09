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
#import "JudgeScores.h"

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
-(void)CreateMeetResult;
-(void)CreateDiverScoreTotalByMeet;
-(void)CreateDiverJudgeScoreByMeet;
-(void)sendEmail:(NSString*)file fileName:(NSString*)filename;
-(void)canceledEmail;
-(void)savedEmail;
-(void)SentEmail;
-(void)FailedEmail;

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
    self.txtxChooseDiver.delegate = self;
    
    self.txtChooseMeet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseMeet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseMeet.layer.masksToBounds = NO;
    self.txtChooseMeet.layer.shadowOpacity = .3;
    self.txtChooseMeet.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseMeet.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtChooseMeet.delegate = self;
    
    self.txtChooseReport.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtChooseReport.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtChooseReport.layer.masksToBounds = NO;
    self.txtChooseReport.layer.shadowOpacity = .3;
    self.txtChooseReport.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtChooseReport.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.txtChooseReport.delegate = self;

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
    
    if (self.reportRecordID == 0) {
        
        if (self.txtChooseMeet.text.length > 0) {
            [self CreateMeetResult];
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You need to pick a meet first"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else if (self.reportRecordID == 1) {
        
        if (self.txtxChooseDiver.text.length > 0 && self.txtChooseMeet.text.length > 0) {
            [self CreateDiverScoreTotalByMeet];
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You need to pick a diver and a meet first"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
        
    } else {
        if (self.txtxChooseDiver.text.length > 0 && self.txtChooseMeet.text.length > 0) {
            [self CreateDiverJudgeScoreByMeet];
        } else {
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"You need to pick a diver and a meet first"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
        }
    }
}

//keps the user from entering text in the txtfield
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return NO;
    
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
    [self.reportArray insertObject:[NSMutableArray arrayWithObjects:@"1", @"Diver Score Total By Meet", nil] atIndex:1];
    [self.reportArray insertObject:[NSMutableArray arrayWithObjects:@"2", @"Diver Judge Scores By Meet", nil] atIndex:2];
    
}

-(void)CreateMeetResult {
    
    NSArray *meetinfo;
    NSString *newDate;
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Diver, School, MeetName, Date, Judges, DiveCount, DiveType, TotalScore, Dive1, Dive2, Dive3, Dive4, Dive5, Dive6, Dive7, Dive8, Dive9, Dive10, Dive11, DiveNumber, DiveStyle, DivePosition, DD, Failed, Score1, Score2, Score3, Score4, Score5, Score6, Score7"];
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    meetinfo = [scores FetchMeetResults:self.meetRecordID];
    
    // here we want to get the meet name for the file name
    NSString *meetName = [[meetinfo objectAtIndex:0] objectAtIndex:3];
    meetName = [meetName stringByAppendingString:@" Meet Results.csv"];
    
    NSUInteger count = [meetinfo count];
    
    for (NSUInteger i = 0; i < count; i++) {
        [csv appendFormat:@"\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",
            [[meetinfo objectAtIndex:i] objectAtIndex:1],
            [[meetinfo objectAtIndex:i] objectAtIndex:2],
            [[meetinfo objectAtIndex:i] objectAtIndex:3],
            newDate = [[[meetinfo objectAtIndex:i] objectAtIndex:4] stringByReplacingOccurrencesOfString:@"," withString:@""],   // date in DB has a comma, we need to remove it for the csv format
            [[meetinfo objectAtIndex:i] objectAtIndex:5],
            [[meetinfo objectAtIndex:i] objectAtIndex:6],
            [[meetinfo objectAtIndex:i] objectAtIndex:7],
            [[meetinfo objectAtIndex:i] objectAtIndex:8],
            [[meetinfo objectAtIndex:i] objectAtIndex:9],
            [[meetinfo objectAtIndex:i] objectAtIndex:10],
            [[meetinfo objectAtIndex:i] objectAtIndex:11],
            [[meetinfo objectAtIndex:i] objectAtIndex:12],
            [[meetinfo objectAtIndex:i] objectAtIndex:13],
            [[meetinfo objectAtIndex:i] objectAtIndex:14],
            [[meetinfo objectAtIndex:i] objectAtIndex:15],
            [[meetinfo objectAtIndex:i] objectAtIndex:16],
            [[meetinfo objectAtIndex:i] objectAtIndex:17],
            [[meetinfo objectAtIndex:i] objectAtIndex:18],
            [[meetinfo objectAtIndex:i] objectAtIndex:19],
            [[meetinfo objectAtIndex:i] objectAtIndex:20],
            [[meetinfo objectAtIndex:i] objectAtIndex:21],
            [[meetinfo objectAtIndex:i] objectAtIndex:22],
            [[meetinfo objectAtIndex:i] objectAtIndex:23],
            [[meetinfo objectAtIndex:i] objectAtIndex:24],
            [[meetinfo objectAtIndex:i] objectAtIndex:25],
            [[meetinfo objectAtIndex:i] objectAtIndex:26],
            [[meetinfo objectAtIndex:i] objectAtIndex:27],
            [[meetinfo objectAtIndex:i] objectAtIndex:28],
            [[meetinfo objectAtIndex:i] objectAtIndex:29],
            [[meetinfo objectAtIndex:i] objectAtIndex:30],
            [[meetinfo objectAtIndex:i] objectAtIndex:31]];
    }
    
    // lets get the document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    // then the full path and file name
    NSString *outputFileName = [docDirectory stringByAppendingPathComponent:meetName];
    
    NSError *csvError = nil;
    
    BOOL written = [csv writeToFile:outputFileName atomically:YES encoding:NSUTF8StringEncoding error:&csvError];
    
    if (!written) {
        NSLog(@"MeetResults write failed, error=%@", csvError);
    } else {
        NSLog(@"MeetResults saved! File Path =%@", outputFileName);
        [self sendEmail:outputFileName fileName:meetName];
    }

}

-(void)CreateDiverScoreTotalByMeet {
    
    NSArray *meetinfo;
    NSString *newDate;
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Diver, School, MeetName, Date, TotalScore, Dive1, Dive2, Dive3, Dive4, Dive5, Dive6, Dive7, Dive8, Dive9, Dive10, Dive11"];
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    meetinfo = [scores FetchMeetScores:self.meetRecordID diverid:self.diverRecordID];
    
    // here we want to get the meet name for the file name
    NSString *meetName = [[meetinfo objectAtIndex:0] objectAtIndex:1];
    meetName = [meetName stringByAppendingString:[[meetinfo objectAtIndex:0] objectAtIndex:3]];
    meetName = [meetName stringByAppendingString:@" Diver Scores.csv"];
    
    NSUInteger count = [meetinfo count];
    
    for (NSUInteger i = 0; i < count; i++) {
        [csv appendFormat:@"\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",
         [[meetinfo objectAtIndex:i] objectAtIndex:1],
         [[meetinfo objectAtIndex:i] objectAtIndex:2],
         [[meetinfo objectAtIndex:i] objectAtIndex:3],
         newDate = [[[meetinfo objectAtIndex:i] objectAtIndex:4] stringByReplacingOccurrencesOfString:@"," withString:@""],   // date in DB has a comma, we need to remove it for the csv format
         [[meetinfo objectAtIndex:i] objectAtIndex:5],
         [[meetinfo objectAtIndex:i] objectAtIndex:6],
         [[meetinfo objectAtIndex:i] objectAtIndex:7],
         [[meetinfo objectAtIndex:i] objectAtIndex:8],
         [[meetinfo objectAtIndex:i] objectAtIndex:9],
         [[meetinfo objectAtIndex:i] objectAtIndex:10],
         [[meetinfo objectAtIndex:i] objectAtIndex:11],
         [[meetinfo objectAtIndex:i] objectAtIndex:12],
         [[meetinfo objectAtIndex:i] objectAtIndex:13],
         [[meetinfo objectAtIndex:i] objectAtIndex:14],
         [[meetinfo objectAtIndex:i] objectAtIndex:15],
         [[meetinfo objectAtIndex:i] objectAtIndex:16]];
    }
    
    // lets get the document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    // then the full path and file name
    NSString *outputFileName = [docDirectory stringByAppendingPathComponent:meetName];
    
    NSError *csvError = nil;
    
    BOOL written = [csv writeToFile:outputFileName atomically:YES encoding:NSUTF8StringEncoding error:&csvError];
    
    if (!written) {
        NSLog(@"DiverScoreTotalByMeet write failed, error=%@", csvError);
    } else {
        NSLog(@"DiverScoreTotalByMeet saved! File Path =%@", outputFileName);
        [self sendEmail:outputFileName fileName:meetName];
    }
    
}

-(void)CreateDiverJudgeScoreByMeet {
    
    NSArray *meetinfo;
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Diver, Meet Name, Dive Number, Dive Name, Position, DD, Total, Judges, Pass/Failed, Score 1, Score 2, Score 3, Score 4, Score 5, Score 6, Score 7"];
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    meetinfo = [scores FetchJudgeMeetScores:self.meetRecordID diverid:self.diverRecordID]; 
    
    // here we want to get the meet name for the file name
    NSString *meetName = [[meetinfo objectAtIndex:0] objectAtIndex:1];
    meetName = [meetName stringByAppendingString:[[meetinfo objectAtIndex:0] objectAtIndex:2]];
    meetName = [meetName stringByAppendingString:@" Judge Scores.csv"];
    
    NSUInteger count = [meetinfo count];
    
    for (NSUInteger i = 0; i < count; i++) {
        [csv appendFormat:@"\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",
         [[meetinfo objectAtIndex:i] objectAtIndex:1],
         [[meetinfo objectAtIndex:i] objectAtIndex:2],
         [[meetinfo objectAtIndex:i] objectAtIndex:3],
         [[meetinfo objectAtIndex:i] objectAtIndex:4],
         [[meetinfo objectAtIndex:i] objectAtIndex:5],
         [[meetinfo objectAtIndex:i] objectAtIndex:6],
         [[meetinfo objectAtIndex:i] objectAtIndex:7],
         [[meetinfo objectAtIndex:i] objectAtIndex:8],
         [[meetinfo objectAtIndex:i] objectAtIndex:9],
         [[meetinfo objectAtIndex:i] objectAtIndex:10],
         [[meetinfo objectAtIndex:i] objectAtIndex:11],
         [[meetinfo objectAtIndex:i] objectAtIndex:12],
         [[meetinfo objectAtIndex:i] objectAtIndex:13],
         [[meetinfo objectAtIndex:i] objectAtIndex:14],
         [[meetinfo objectAtIndex:i] objectAtIndex:15],
         [[meetinfo objectAtIndex:i] objectAtIndex:16]];
    }
    
    // lets get the document path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    // then the full path and file name
    NSString *outputFileName = [docDirectory stringByAppendingPathComponent:meetName];
    
    NSError *csvError = nil;
    
    BOOL written = [csv writeToFile:outputFileName atomically:YES encoding:NSUTF8StringEncoding error:&csvError];
    
    if (!written) {
        NSLog(@"JudgeScoresByMeet write failed, error=%@", csvError);
    } else {
        NSLog(@"JudgeScoresByMeet saved! File Path =%@", outputFileName);
        [self sendEmail:outputFileName fileName:meetName];
    }
    
}

-(void)sendEmail:(NSString*)file fileName:(NSString*)filename {
    
    NSString *subject = filename;
    NSString *body = filename;
    
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    [composer setSubject:subject];
    [composer setMessageBody:body isHTML:NO];
 
    // get the file path from resources
    NSString *filePath = file;
    
    // read the file
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // set the MIME type
    NSString *mimetype = @"text/csv";
    
    //add attachment
    [composer addAttachmentData:fileData mimeType:mimetype fileName:filename];
    
    // present it on the screen
    [self presentViewController:composer animated:YES completion:nil];
    
}

// delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self canceledEmail];
            break;
        case MFMailComposeResultSaved:
            [self savedEmail];
            break;
        case MFMailComposeResultSent:
            [self SentEmail];
            break;
        case MFMailComposeResultFailed:
            [self FailedEmail];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// delegate method
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    // no social messages yet
    
}

-(void)canceledEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Cancelled"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

-(void)savedEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Saved"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

-(void)SentEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

-(void)FailedEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Failed"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}













































@end
