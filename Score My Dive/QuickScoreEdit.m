//
//  QuickScoreEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/15/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScoreEdit.h"
#import "QuickScores.h"
#import "DBManager.h"

@interface QuickScoreEdit ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSString *nameText;
@property (nonatomic, strong) NSString *dive1;
@property (nonatomic, strong) NSString *dive2;
@property (nonatomic, strong) NSString *dive3;
@property (nonatomic, strong) NSString *dive4;
@property (nonatomic, strong) NSString *dive5;
@property (nonatomic, strong) NSString *dive6;
@property (nonatomic, strong) NSString *dive7;
@property (nonatomic, strong) NSString *dive8;
@property (nonatomic, strong) NSString *dive9;
@property (nonatomic, strong) NSString *dive10;
@property (nonatomic, strong) NSString *dive11;
@property (nonatomic, strong) NSString *scoreTotal;
@property (nonatomic) double totalScore;
@property (nonatomic) int textBoxAlert;

//private method to load the edited data
-(void)loadInfoToEdit;

@end

@implementation QuickScoreEdit

#pragma View Controller Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the delegate on the numeric text fields so we can check to insure only
    // numerics are put in
    
    
    // check if we load a specific record to edit
    if(self.recordIDToEdit != -1){
        [self loadInfoToEdit];
    }
    
    [self updateTotal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// save the info
- (IBAction)saveInfo:(id)sender {
    
    // here we will send the params to the class to do the update
    QuickScores *quick = [[QuickScores alloc] init];
    if ([quick updateQuickScore:self.recordIDToEdit Name:_nameText Dive1:_dive1 Dive2:_dive2 Dive3:_dive3 Dive4:_dive4 Dive5:_dive5 Dive6:_dive6 Dive7:_dive7 Dive8:_dive8 Dive9:_dive9 Dive10:_dive10 Dive11:_dive11 Total:_scoreTotal]) {
        NSLog(@"Query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        
        //inform the delegate that the edit was finished and update previous
        //viewcontroller table rows
        [self.delegate editInfoWasFinished];
        
        // pop the view controller
        //[self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"Could not execute the query");
    }
}

- (IBAction)diveOneClick:(id)sender {
    
    _textBoxAlert = 1;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive1Txt];
    
}

- (IBAction)diveTwoClick:(id)sender {
    
    _textBoxAlert = 2;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive2Txt];
    
}

- (IBAction)diveThreeClick:(id)sender {
    
    _textBoxAlert = 3;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive3Txt];
    
}

- (IBAction)diveFourClick:(id)sender {
    
    _textBoxAlert = 4;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive4Txt];
    
}

- (IBAction)diveFiveClick:(id)sender {
    
    _textBoxAlert = 5;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive5Txt];
    
}

- (IBAction)diveSixClick:(id)sender {
    
    _textBoxAlert = 6;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive6Txt];
    
}

- (IBAction)diveSevenClick:(id)sender {
    
    _textBoxAlert = 7;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive7Txt];
    
}

- (IBAction)diveEightClick:(id)sender {
    
    _textBoxAlert = 8;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive8Txt];
    
}

- (IBAction)diveNineClick:(id)sender {
    
    _textBoxAlert = 9;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive9Txt];
    
}

- (IBAction)diveTenClick:(id)sender {
    
    _textBoxAlert = 10;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive10Txt];
    
}

- (IBAction)diveElevenClick:(id)sender {
    
    _textBoxAlert = 11;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive11Txt];
    
}

#pragma private methods

- (void)updateTotal {
    // alloc an array and add the labels to it
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array insertObject:self.dive1Txt.text atIndex:0];
    [array insertObject:self.dive2Txt.text atIndex:1];
    [array insertObject:self.dive3Txt.text atIndex:2];
    [array insertObject:self.dive4Txt.text atIndex:3];
    [array insertObject:self.dive5Txt.text atIndex:4];
    [array insertObject:self.dive6Txt.text atIndex:5];
    [array insertObject:self.dive7Txt.text atIndex:6];
    [array insertObject:self.dive8Txt.text atIndex:7];
    [array insertObject:self.dive9Txt.text atIndex:8];
    [array insertObject:self.dive10Txt.text atIndex:9];
    [array insertObject:self.dive11Txt.text atIndex:10];
    
    // add the labels to the properties, we will use these to add to the DB
    _dive1 = self.dive1Txt.text;
    _dive2 = self.dive2Txt.text;
    _dive3 = self.dive3Txt.text;
    _dive4 = self.dive4Txt.text;
    _dive5 = self.dive5Txt.text;
    _dive6 = self.dive6Txt.text;
    _dive7 = self.dive7Txt.text;
    _dive8 = self.dive8Txt.text;
    _dive9 = self.dive9Txt.text;
    _dive10 = self.dive10Txt.text;
    _dive11 = self.dive11Txt.text;
    
    _nameText = self.nameTxt.text;
    
    // calls the class method to add up all the scores
    // and then we format the double to a readable type and
    // put it in the total label
    QuickScores *quick = [[QuickScores alloc] init];
    _totalScore = [quick GetQuickScoreTotal:array];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    self.totalTxt.text = [formatter stringFromNumber:[NSNumber numberWithDouble:_totalScore]];
    _scoreTotal = [formatter stringFromNumber:[NSNumber numberWithDouble:_totalScore]];
    
}


//loads a current record to update
-(void)loadInfoToEdit{

    // send the id to the class method to get the results array for the text boxes
    QuickScores *quick  = [[QuickScores alloc] init];
    NSArray *results = [quick loadInfo:self.recordIDToEdit];
    
    // set the data to the correct labels
    self.nameTxt.text = [[results objectAtIndex:0] objectAtIndex:1];
    self.dive1Txt.text = [[results objectAtIndex:0] objectAtIndex:2];
    self.dive2Txt.text = [[results objectAtIndex:0] objectAtIndex:3];
    self.dive3Txt.text = [[results objectAtIndex:0] objectAtIndex:4];
    self.dive4Txt.text = [[results objectAtIndex:0] objectAtIndex:5];
    self.dive5Txt.text = [[results objectAtIndex:0] objectAtIndex:6];
    self.dive6Txt.text = [[results objectAtIndex:0] objectAtIndex:7];
    self.dive7Txt.text = [[results objectAtIndex:0] objectAtIndex:8];
    self.dive8Txt.text = [[results objectAtIndex:0] objectAtIndex:9];
    self.dive9Txt.text = [[results objectAtIndex:0] objectAtIndex:10];
    self.dive10Txt.text = [[results objectAtIndex:0] objectAtIndex:11];
    self.dive11Txt.text = [[results objectAtIndex:0] objectAtIndex:12];
    self.totalTxt.text = [[results objectAtIndex:0] objectAtIndex:13];
    
}

// only allow numbers and two decimal places in the dive score text fields
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *sep = [newString componentsSeparatedByString:@"."];
    if([sep count] >= 2)
    {
        NSString *sepStr=[NSString stringWithFormat:@"%@",[sep objectAtIndex:1]];
        return !([sepStr length]>2);
    }
    return YES;
}

#pragma AlertController Events

// AlertController for the sheet name
- (IBAction)nameClick:(id)sender {
    
    // updated alertController for iOS 8
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Edit Name"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Enter Sheet Title";
         textField.keyboardAppearance = UIKeyboardAppearanceDark;
         textField.keyboardType = UIKeyboardTypeDefault;
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Action");
                                   UITextField *name = alertController.textFields.firstObject;
                                   self.nameTxt.text = name.text;
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// AlertController for the dive Numbers
-(void)DiveAlert:(int)diveNumber TextField:(UILabel*)diveText {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[NSMutableString stringWithFormat:@"Edit Dive %d", diveNumber]
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"0.0";
         textField.keyboardAppearance = UIKeyboardAppearanceDark;
         textField.keyboardType = UIKeyboardTypeDecimalPad;
         // add the text field delegate here
         textField.delegate = self;
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Action");
                                   UITextField *score = alertController.textFields.firstObject;
                                    diveText.text = score.text;
                                   [self updateTotal];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
