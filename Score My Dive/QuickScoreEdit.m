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

#pragma LoadEvents

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // sets the delegate on the numeric text fields so we can check to insure only
    // numerics are put in
    
    
    // alloc the database
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
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

#pragma Database events
//loads a current record to update
-(void)loadInfoToEdit{
    //create the query
    NSString *query = [NSString stringWithFormat:@"select * from quick_score where id=%d", self.recordIDToEdit];
    
    //load the correct record
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // set the data to the correct labels
    self.nameTxt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name_meet"]];
    self.dive1Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_1"]];
    self.dive2Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_2"]];
    self.dive3Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_3"]];
    self.dive4Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_4"]];
    self.dive5Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_5"]];
    self.dive6Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_6"]];
    self.dive7Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_7"]];
    self.dive8Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_8"]];
    self.dive9Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_9"]];
    self.dive10Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_10"]];
    self.dive11Txt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"dive_11"]];
    self.totalTxt.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"total_score"]];
    
}

// save the info
- (IBAction)saveInfo:(id)sender {
    NSString *query;
    
    //TODO: get an id and if it exists then do an update instead of a select
    if (self.recordIDToEdit == -1) {
        //insert query
        query = [NSString stringWithFormat:@"insert into quick_score(name_meet, dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11, total_score) values('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", _nameText, _dive1, _dive2, _dive3, _dive4, _dive5, _dive6, _dive7, _dive8, _dive9, _dive10, _dive11, _scoreTotal];
        
    } else {
        //update query
        query = [NSString stringWithFormat:@"update quick_score set name_meet='%@', dive_1='%@', dive_2='%@', dive_3='%@', dive_4='%@', dive_5='%@', dive_6='%@', dive_7='%@', dive_8='%@', dive_9='%@', dive_10='%@', dive_11='%@', total_score='%@' where id=%d", self.nameText, self.dive1, self.dive2, self.dive3, self.dive4, self.dive5, self.dive6, self.dive7, self.dive8, self.dive9, self.dive10, self.dive11, self.scoreTotal, self.recordIDToEdit];
    }
    
    
    
    // execute the query
    [self.dbManager executeQuery:query];
    
    // if the query was succesfully executed then pop the view controller
    if (self.dbManager.affectedRows != 0) {
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

#pragma AlertController

// this looks to see who called the alert and assigns the values to the correct labels and fields
// to update the table
//-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        switch (_textBoxAlert) {
//            case 1:
//                self.dive1Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 2:
//                self.dive2Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 3:
//                self.dive3Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 4:
//                self.dive4Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 5:
//                self.dive5Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 6:
//                self.dive6Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 7:
//                self.dive7Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 8:
//                self.dive8Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 9:
//                self.dive9Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 10:
//                self.dive10Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
//            case 11:
//                self.dive11Txt.text = [alertView textFieldAtIndex:0].text;
//                break;
////            case 12:
////                self.nameTxt.text = [alertView textFieldAtIndex:0].text;
////                break;
//        }
//        [self updateTotal];
//    }
//}

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
                                   UITextField *score = alertController.textFields.firstObject;
                                   diveText.text = score.text;
                                   [self updateTotal];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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

@end
